import 'dart:io';
import 'dart:ui' show Rect;

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import '../../domain/models/scan_models.dart';
import '../../domain/repositories/card_repository.dart';
import '../../features/scanner/utils/viewfinder_transform.dart';

class OcrScanService {
  TextRecognizer? _textRecognizer;

  void initialize() {
    _textRecognizer ??= TextRecognizer(script: TextRecognitionScript.latin);
  }

  void dispose() {
    _textRecognizer?.close();
    _textRecognizer = null;
  }

  /// Process an image file and extract parsed card tokens.
  Future<ParsedCardTokens> processImage(
    InputImage inputImage, {
    Set<String> knownSetCodes = const {},
  }) async {
    initialize();
    final recognizedText = await _textRecognizer!.processImage(inputImage);
    return parseRecognizedText(recognizedText, knownSetCodes: knownSetCodes);
  }

  /// Process image using multiple cropped and upscaled passes for better targeting.
  Future<ParsedCardTokens> processImageTargeted({
    required XFile imageFile,
    required double screenWidth,
    required double screenHeight,
    required double guideLeft,
    required double guideTop,
    required double guideWidth,
    required double guideHeight,
    required CardRepository cardRepository,
  }) async {
    initialize();

    final sets = await cardRepository.getAllSets();
    final knownSetCodes = sets
        .map((s) => s.setCode?.toUpperCase())
        .whereType<String>()
        .toSet();

    final stopwatch = Stopwatch()..start();

    // Decode original JPEG image
    final bytes = await imageFile.readAsBytes();
    final decodedImage = await compute(img.decodeImage, bytes);

    if (decodedImage == null) {
      // Fallback
      return processImage(
        InputImage.fromFilePath(imageFile.path),
        knownSetCodes: knownSetCodes,
      );
    }

    final decodeMs = stopwatch.elapsedMilliseconds;

    // 1. Calculate the Card ROI from the Viewfinder Transform
    final cardCropRect = ViewfinderTransform.mapScreenToImageCrop(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      imageWidth: decodedImage.width.toDouble(),
      imageHeight: decodedImage.height.toDouble(),
      guideLeft: guideLeft,
      guideTop: guideTop,
      guideWidth: guideWidth,
      guideHeight: guideHeight,
    );

    // Define Header (top 30%) and Identity (bottom 25%) relative to Card ROI
    final headerRect = Rect.fromLTWH(
      cardCropRect.left,
      cardCropRect.top,
      cardCropRect.width,
      cardCropRect.height * 0.30,
    );

    final identityRect = Rect.fromLTWH(
      cardCropRect.left,
      cardCropRect.top + cardCropRect.height * 0.75,
      cardCropRect.width,
      cardCropRect.height * 0.25,
    );

    debugPrint(
      'BENCHMARK LOG: Original Image ${decodedImage.width}x${decodedImage.height}',
    );
    debugPrint('BENCHMARK LOG: Card ROI Crop $cardCropRect');
    debugPrint('BENCHMARK LOG: Header Crop $headerRect');
    debugPrint('BENCHMARK LOG: Identity Crop $identityRect');

    // Extract crops using image package
    final identityCrop = img.copyCrop(
      decodedImage,
      x: identityRect.left.toInt(),
      y: identityRect.top.toInt(),
      width: identityRect.width.toInt(),
      height: identityRect.height.toInt(),
    );

    final headerCrop = img.copyCrop(
      decodedImage,
      x: headerRect.left.toInt(),
      y: headerRect.top.toInt(),
      width: headerRect.width.toInt(),
      height: headerRect.height.toInt(),
    );

    // Upscale Identity Crop 2x for better small-text segmentation
    final upscaledIdentity = img.copyResize(
      identityCrop,
      width: identityCrop.width * 2,
      height: identityCrop.height * 2,
      interpolation: img.Interpolation.cubic, // High-quality resize
    );

    // Write to temporary files to feed into ML Kit
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final idFile = File('${tempDir.path}/identity_crop_$timestamp.jpg');
    final hdFile = File('${tempDir.path}/header_crop_$timestamp.jpg');

    await idFile.writeAsBytes(img.encodeJpg(upscaledIdentity));
    await hdFile.writeAsBytes(img.encodeJpg(headerCrop));

    final cropEncodeMs = stopwatch.elapsedMilliseconds - decodeMs;

    // Run parallel OCR passes
    final idRecognized = await _textRecognizer!.processImage(
      InputImage.fromFilePath(idFile.path),
    );
    final hdRecognized = await _textRecognizer!.processImage(
      InputImage.fromFilePath(hdFile.path),
    );
    final fullRecognized = await _textRecognizer!.processImage(
      InputImage.fromFilePath(imageFile.path),
    );

    final ocrMs = stopwatch.elapsedMilliseconds - decodeMs - cropEncodeMs;

    // Cleanup temp files asynchronously
    idFile.delete().ignore();
    hdFile.delete().ignore();

    // 2. Extract tokens from each pass
    final idTokens = parseRecognizedText(
      idRecognized,
      knownSetCodes: knownSetCodes,
    );
    final hdTokens = parseRecognizedText(
      hdRecognized,
      knownSetCodes: knownSetCodes,
    );
    final fullTokens = parseRecognizedText(
      fullRecognized,
      knownSetCodes: knownSetCodes,
    );

    debugPrint('BENCHMARK LOG: [HD Pass] Name: ${hdTokens.detectedName}');
    debugPrint(
      'BENCHMARK LOG: [ID Pass] Number: ${idTokens.detectedNumber}, Set: ${idTokens.detectedSetCode}',
    );
    debugPrint(
      'BENCHMARK LOG: [Full Pass] Name: ${fullTokens.detectedName}, Number: ${fullTokens.detectedNumber}',
    );
    debugPrint(
      'BENCHMARK LOG: Timings: Decode: ${decodeMs}ms, Crop/Encode: ${cropEncodeMs}ms, OCR passes: ${ocrMs}ms',
    );

    // 3. Merge evidence with provenance
    // The Targeted Crops are structurally trusted over the Full Image.
    return ParsedCardTokens(
      rawText: '${hdTokens.rawText}\n---\n${idTokens.rawText}',
      rawNameCandidate:
          hdTokens.rawNameCandidate ?? fullTokens.rawNameCandidate,
      detectedName: hdTokens.detectedName ?? fullTokens.detectedName,
      detectedNumber: idTokens.detectedNumber ?? fullTokens.detectedNumber,
      detectedSetCode: idTokens.detectedSetCode ?? fullTokens.detectedSetCode,
      nameConfidence: hdTokens.detectedName != null
          ? 0.95
          : fullTokens.nameConfidence,
      numberConfidence: idTokens.detectedNumber != null
          ? 0.95
          : fullTokens.numberConfidence,
    );
  }

  /// Deterministically parses OCR text blocks based on card spatial layout and regex patterns.
  static ParsedCardTokens parseRecognizedText(
    RecognizedText recognizedText, {
    Set<String> knownSetCodes = const {},
  }) {
    final rawFullText = recognizedText.text;
    if (recognizedText.blocks.isEmpty) {
      return ParsedCardTokens(rawText: rawFullText);
    }

    String? detectedName;
    String? rawNameCandidate;
    String? detectedNumber;
    String? detectedSetCode;
    double nameConfidence = 0.0;
    double numberConfidence = 0.0;

    // Standard card layout regex patterns
    // 078/063, 041/086R (we will strip the R), TG01/TG30
    final slashNumberPattern = RegExp(
      r'\b([A-Z]{0,3}[0-9OIl]{1,4}[A-Z]{0,2})\s*[\/|\\]\s*([A-Z]{0,3}[0-9OIl]{1,4}[A-Z]{0,2})\b',
      caseSensitive: false,
    );

    // Promos: MEP 073, SVP050, XY166, SM226, SWSH050
    final promoPattern = RegExp(
      r'\b(MEP|SVP|SWSH|SM|XY|BW|DP|HGSS|PROMO|TG)\s*[-#]?\s*([0-9OIl]{1,4})\b',
      caseSensitive: false,
    );
    final setCodePattern = RegExp(
      r'\[?([A-Z0-9]{3,4})\]?\s*(?:EN|FR|DE|IT|ES|JP)?',
      caseSensitive: true,
    );

    // 1. Establish Card-Relative Geometry
    // Instead of trusting the whole sensor image, we find the vertical bounds
    // of text blocks that are vertically aligned in the center.
    // This rejects background objects and isolates the physical card.
    double medianX = 0;
    if (recognizedText.blocks.isNotEmpty) {
      final centers =
          recognizedText.blocks.map((b) => b.boundingBox.center.dx).toList()
            ..sort();
      medianX = centers[centers.length ~/ 2];
    }

    double cardTopY = double.infinity;
    double cardBottomY = 0;

    // Filter blocks roughly in the horizontal column of the card
    final cardBlocks = recognizedText.blocks.where((b) {
      return (b.boundingBox.center.dx - medianX).abs() <
          (b.boundingBox.width + 100);
    }).toList();

    for (final block in cardBlocks) {
      if (block.boundingBox.top < cardTopY) cardTopY = block.boundingBox.top;
      if (block.boundingBox.bottom > cardBottomY)
        cardBottomY = block.boundingBox.bottom;
    }
    final cardSpanY = cardBottomY - cardTopY;
    if (cardSpanY <= 0) return ParsedCardTokens(rawText: rawFullText);

    // Sort blocks by bounding box top (vertical layout)
    final sortedBlocks = List<TextBlock>.from(recognizedText.blocks)
      ..sort((a, b) => a.boundingBox.top.compareTo(b.boundingBox.top));

    // 2. Top region scanning for Pokémon / Card Name
    // We restrict name search to the top 35% of the *card-relative* span.
    double maxLineHeight = 0;

    for (int i = 0; i < sortedBlocks.length; i++) {
      final block = sortedBlocks[i];
      final relativeY = (block.boundingBox.top - cardTopY) / cardSpanY;

      // Card names shouldn't be below the top 35% of the card
      if (relativeY > 0.35) continue;

      for (final line in block.lines) {
        final text = line.text.trim();

        // Skip negative context signals (rules, abilities, types, damage)
        if (_isNegativeContextSignal(text)) continue;

        final height = line.boundingBox.bottom - line.boundingBox.top;
        if (height > maxLineHeight) {
          maxLineHeight = height;
          rawNameCandidate = text;
        }
      }
    }

    if (rawNameCandidate != null) {
      final cleanedName = _cleanCandidateName(rawNameCandidate);
      if (cleanedName.length >= 2) {
        detectedName = cleanedName;
        nameConfidence = 0.85;
      }
    }

    // 3. Bottom region scanning for Card Number & Set Code
    // Collector numbers/sets shouldn't be in the top 50% of the card.
    final reversedBlocks = sortedBlocks.reversed.toList();
    for (final block in reversedBlocks) {
      final relativeY = (block.boundingBox.top - cardTopY) / cardSpanY;
      if (relativeY < 0.50) continue; // Skip top half of the card

      for (final line in block.lines) {
        final text = line.text.trim();

        // Standard Collector Number (078/063, etc.)
        final slashMatch = slashNumberPattern.firstMatch(text);
        if (slashMatch != null && detectedNumber == null) {
          final rawNum = slashMatch.group(1)!;
          final rawDen = slashMatch.group(2)!;

          final numClean = _normalizeDigits(rawNum).replaceAll(
            RegExp(r'[A-Za-z]$'),
            '',
          ); // strip trailing rarity like 'R' in 041/086R
          final denClean = _normalizeDigits(rawDen)
              .replaceAll(RegExp(r'[A-Za-z]$'), '');

          if (numClean.isNotEmpty && denClean.isNotEmpty) {
            detectedNumber = '$numClean/$denClean';
            numberConfidence = 0.95;
          }
        }

        // Promo/Gallery Identifier (MEP 073, SVP050, etc.)
        final promoMatch = promoPattern.firstMatch(text);
        if (promoMatch != null && detectedNumber == null) {
          final prefix = promoMatch.group(1)!.toUpperCase();
          final numClean = _normalizeDigits(promoMatch.group(2)!);
          detectedNumber = '$prefix$numClean';
          numberConfidence = 0.90;
        }

        // Set Code (strict matching against DB, or exact brackets)
        final setMatch = setCodePattern.firstMatch(text);
        if (setMatch != null && detectedSetCode == null) {
          final code = setMatch.group(1)!.toUpperCase();
          if (code.length >= 3 && code.length <= 4) {
            if (knownSetCodes.contains(code)) {
              detectedSetCode = code; // Database verified
            } else if (text.contains('[$code]')) {
              detectedSetCode = code; // Exact structural match (SV format)
            } else if (code.startsWith('SV') || code.startsWith('SWSH')) {
              // Fallback for modern standard prefixes if DB is missing it
              detectedSetCode = code;
            }
          }
        }
      }
    }

    return ParsedCardTokens(
      rawText: rawFullText,
      rawNameCandidate: rawNameCandidate,
      detectedName: detectedName,
      detectedNumber: detectedNumber,
      detectedSetCode: detectedSetCode,
      nameConfidence: nameConfidence,
      numberConfidence: numberConfidence,
    );
  }

  static bool _isNegativeContextSignal(String text) {
    final upper = text.toUpperCase();
    return upper.startsWith('EVOLVES FROM') ||
        upper.startsWith('ABILITY') ||
        upper.startsWith('VMAX RULE') ||
        upper.startsWith('VSTAR RULE') ||
        upper.startsWith('PUT ') ||
        upper.startsWith('WHEN YOUR') ||
        upper.contains('RESTORED') ||
        upper == 'BASIC' ||
        upper == 'STAGE 1' ||
        upper == 'STAGE 2' ||
        upper == 'VSTAR' ||
        upper == 'VMAX' ||
        RegExp(r'^\d+\s*HP', caseSensitive: false).hasMatch(text) ||
        RegExp(r'^\d+$').hasMatch(text); // Standalone damage/HP numbers
  }

  static String _cleanCandidateName(String text) {
    var cleaned = text;
    // Extract HP fused at the end (e.g. "Mega GengareX350").
    // Avoid stripping numbers that are legitimately part of a name like "Porygon2".
    // HP is almost always a multiple of 10 between 30 and 400.
    final fusedHpPattern = RegExp(
      r'^(.+?)(?:\s*HP\s*\d{2,3}|\s*\d{2,3}\s*HP|(?<=[a-zA-Z])[1-4]\d0|(?<=ex|EX|eX|v|V)\d{2,3})\s*$',
      caseSensitive: false,
    );
    final match = fusedHpPattern.firstMatch(cleaned);
    if (match != null) {
      cleaned = match.group(1)!;
    }

    // Clean trailing EX/ex space issues if needed
    cleaned = cleaned.replaceAllMapped(
      RegExp(r'(?<!\s)e[Xx]$', caseSensitive: true),
      (m) => ' ex',
    );
    cleaned = cleaned.replaceAllMapped(
      RegExp(r'(?<!\s)E[Xx]$', caseSensitive: true),
      (m) => ' EX',
    );
    cleaned = cleaned.replaceAll(RegExp(r'[®©™]'), '').trim();
    cleaned = cleaned.replaceAll(RegExp(r'\s+'), ' '); // Collapse double spaces
    return cleaned;
  }

  /// Fixes common OCR letter-to-digit confusions in numeric tokens
  static String _normalizeDigits(String input) {
    return input
        .replaceAll('O', '0')
        .replaceAll('o', '0')
        .replaceAll('I', '1')
        .replaceAll('l', '1')
        .replaceAll('i', '1')
        .replaceAll('|', '1')
        .replaceAll('S', '5')
        .replaceAll('s', '5')
        .replaceAll('B', '8')
        .replaceAll('Z', '2')
        .replaceAll('z', '2');
  }
}
