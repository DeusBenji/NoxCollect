import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../domain/models/card_models.dart';
import '../../domain/models/scan_models.dart';
import '../../domain/repositories/card_repository.dart';
import '../../domain/repositories/scan_repository.dart';
import '../services/ocr_scan_service.dart';
import 'visual_recognition_repository.dart';

class OnDeviceScanRepository implements ScanRepository {
  final CardRepository _cardRepository;
  final OcrScanService _ocrService;
  final VisualRecognitionRepository _visualRepo;

  OnDeviceScanRepository(
    this._cardRepository, [
    OcrScanService? ocrService,
    VisualRecognitionRepository? visualRepo,
  ]) : _ocrService = ocrService ?? OcrScanService(),
       _visualRepo = visualRepo ?? VisualRecognitionRepository();

  @override
  Future<void> initialize() async {
    _ocrService.initialize();
  }

  @override
  Future<ParsedCardTokens> processImage(XFile imageFile) async {
    final inputImage = InputImage.fromFilePath(imageFile.path);
    final sets = await _cardRepository.getAllSets();
    final knownSetCodes = sets
        .map((s) => s.setCode?.toUpperCase())
        .whereType<String>()
        .toSet();
    return _ocrService.processImage(inputImage, knownSetCodes: knownSetCodes);
  }

  @override
  Future<ParsedCardTokens> processImageTargeted(
    XFile imageFile, {
    required double screenWidth,
    required double screenHeight,
    required double guideLeft,
    required double guideTop,
    required double guideWidth,
    required double guideHeight,
  }) async {
    return _ocrService.processImageTargeted(
      imageFile: imageFile,
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      guideLeft: guideLeft,
      guideTop: guideTop,
      guideWidth: guideWidth,
      guideHeight: guideHeight,
      cardRepository: _cardRepository,
    );
  }

  @override
  Future<ParsedCardTokens> processCameraImage(CameraImage cameraImage) async {
    // Note: Live stream conversion can be piped into ML Kit input image
    // For snapshot testing in the benchmark, we use XFile images
    return const ParsedCardTokens();
  }

  @override
  Future<ScanMatchResult> matchCardCandidates(ParsedCardTokens tokens) async {
    final candidates = <CardMatchCandidate>[];
    final detectedNumber = tokens.detectedNumber;
    final detectedName = tokens.detectedName;
    final detectedSetCode = tokens.detectedSetCode;

    // Check if OCR failed completely
    if (detectedNumber == null &&
        detectedName == null &&
        detectedSetCode == null) {
      return const ScanMatchResult(state: ScanResultState.ocrFailed);
    }

    // Identify if the detected set code is actually verified against the DB
    bool isSetVerified = false;
    if (detectedSetCode != null) {
      final sets = await _cardRepository.getAllSets();
      isSetVerified = sets.any(
        (s) => s.setCode?.toUpperCase() == detectedSetCode.toUpperCase(),
      );
    }

    List<CardModel> matchedCards = [];

    // 1. Search by Number (strongest specific identifier)
    if (detectedNumber != null && detectedNumber.isNotEmpty) {
      matchedCards = await _cardRepository.findCardsByNumber(detectedNumber);
    }

    // 2. Fallback to Name
    if (matchedCards.isEmpty &&
        detectedName != null &&
        detectedName.isNotEmpty) {
      matchedCards = await _cardRepository.searchCards(
        query: detectedName,
        limit: 10,
      );
    }

    // 3. Fallback to Set Code if nothing else matched
    if (matchedCards.isEmpty && detectedSetCode != null && isSetVerified) {
      final sets = await _cardRepository.getAllSets();
      final matchingSet = sets
          .where(
            (s) => s.setCode?.toUpperCase() == detectedSetCode.toUpperCase(),
          )
          .firstOrNull;
      if (matchingSet != null) {
        matchedCards = await _cardRepository.getCardsBySet(matchingSet.id);
      }
    }

    if (matchedCards.isEmpty) {
      return const ScanMatchResult(
        state: ScanResultState.ocrParsedNoCatalogMatch,
      );
    }

    // Rank and score candidates
    for (final card in matchedCards) {
      double score = 0.0;
      final reasons = <String>[];
      bool hasNumberMatch = false;
      bool hasNameMatch = false;
      bool hasSetMatch = false;

      // Exact number match check
      if (detectedNumber != null &&
          _isNumberMatch(detectedNumber, card.cardNumber, card.numberClean)) {
        score += 0.50;
        reasons.add('Exact Card # (${card.cardNumber})');
        hasNumberMatch = true;
      }

      // Name similarity check
      if (detectedName != null && _isNameMatch(detectedName, card.name)) {
        score += 0.35;
        reasons.add('Name Match (${card.name})');
        hasNameMatch = true;
      }

      // Set code bonus check (e.g. SVI, MEW)
      if (detectedSetCode != null &&
          card.setCode != null &&
          detectedSetCode.toUpperCase() == card.setCode!.toUpperCase()) {
        score += 0.15;
        reasons.add('Set Code Match (${card.setCode})');
        hasSetMatch = isSetVerified;
      }

      candidates.add(
        CardMatchCandidate(
          card: card,
          score: score.clamp(0.0, 1.0),
          matchReason: reasons.join(' + '),
          hasNumberMatch: hasNumberMatch,
          hasNameMatch: hasNameMatch,
          hasSetMatch: hasSetMatch,
        ),
      );
    }

    // Sort descending by score
    candidates.sort((a, b) => b.score.compareTo(a.score));

    // Evaluation for EXACT VERIFICATION
    CardModel? verifiedCard;
    if (candidates.isNotEmpty) {
      final topCandidate = candidates.first;

      bool uniqueBySetAndNumber =
          candidates.where((c) => c.hasNumberMatch && c.hasSetMatch).length ==
          1;
      bool verifiedBySetAndNumber =
          topCandidate.hasSetMatch &&
          topCandidate.hasNumberMatch &&
          uniqueBySetAndNumber;

      bool uniqueByNameAndNumber =
          candidates.where((c) => c.hasNameMatch && c.hasNumberMatch).length ==
          1;
      bool verifiedByNameAndNumber =
          topCandidate.hasNameMatch &&
          topCandidate.hasNumberMatch &&
          uniqueByNameAndNumber;

      bool uniqueByNameAndSet =
          candidates.where((c) => c.hasNameMatch && c.hasSetMatch).length == 1;
      bool verifiedByNameAndSet =
          topCandidate.hasNameMatch &&
          topCandidate.hasSetMatch &&
          uniqueByNameAndSet;

      if (verifiedBySetAndNumber ||
          verifiedByNameAndNumber ||
          verifiedByNameAndSet) {
        verifiedCard = topCandidate.card;
      }
    }

    return ScanMatchResult(
      state: verifiedCard != null
          ? ScanResultState.exactMatchVerified
          : ScanResultState.candidatesUnverified,
      verifiedCard: verifiedCard,
      candidates: candidates,
    );
  }

  @override
  Future<VisualRecognitionResult> recognizeVisually({
    required XFile imageFile,
    required double screenWidth,
    required double screenHeight,
    required double guideLeft,
    required double guideTop,
    required double guideWidth,
    required double guideHeight,
    String? ocrName,
    String? ocrNumber,
  }) async {
    return await _visualRepo.recognizeCard(
      imageFile: imageFile,
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      guideLeft: guideLeft,
      guideTop: guideTop,
      guideWidth: guideWidth,
      guideHeight: guideHeight,
      ocrName: ocrName,
      ocrNumber: ocrNumber,
    );
  }

  @override
  Future<ScanMatchResult> matchWithVisualCandidates(
    VisualRecognitionResult visualResult,
    ParsedCardTokens tokens,
  ) async {
    final candidates = <CardMatchCandidate>[];
    CardModel? verifiedCard;
    final Map<String, dynamic> fusionTrace = {
      'visual_backend_status': visualResult.status,
      'visual_candidates_count': visualResult.candidates.length,
    };

    // Check for explicit failure
    if (visualResult.status != 'SUCCESS') {
      return ScanMatchResult(
        state: ScanResultState.visualBackendFailed,
        visualBackendStatus: visualResult.status,
        fusionTrace: fusionTrace,
      );
    }

    // Convert backend visual dicts into full local CardModels for scoring
    for (int i = 0; i < visualResult.candidates.length; i++) {
      final vc = visualResult.candidates[i];
      var card = await _cardRepository.getCardById(vc.id);
      
      if (card == null) {
        // Fallback to the backend-provided data if local DB is out of sync
          card = CardModel(
            id: vc.id,
            name: vc.name,
            localName: vc.localName,
            cleanName: vc.name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), ''),
            language: vc.language,
            region: vc.region,
            cardNumber: vc.cardNumber ?? '?',
            numberClean: (vc.cardNumber ?? '').toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), ''),
            setId: vc.setCode ?? 'UNKNOWN',
            setCode: vc.setCode,
          );
      }

      // Use the backend-provided similarity score directly
      double score = vc.similarity;
      final reasons = <String>['Visual Match Rank ${i + 1} (Dist: ${vc.distance.toStringAsFixed(3)}, Sim: ${vc.similarity.toStringAsFixed(3)})'];
      bool hasNumberMatch = false;
      bool hasNameMatch = false;
      bool hasSetMatch = false;

      // Number matching logic
      if (tokens.detectedNumber != null &&
          _isNumberMatch(
            tokens.detectedNumber!,
            card.cardNumber,
            card.numberClean,
          )) {
        score += 0.50;
        reasons.add('Exact Card # (${card.cardNumber})');
        hasNumberMatch = true;
      } else if (tokens.detectedNumber != null &&
          _isFuzzyNumberMatch(tokens.detectedNumber!, card.cardNumber)) {
        // Task 13: Fuzzy candidate-aware matching
        score += 0.20;
        reasons.add(
          'Fuzzy Card # (Observed: ${tokens.detectedNumber}, Canonical: ${card.cardNumber})',
        );
        hasNumberMatch = true;
      }

      if (tokens.detectedName != null &&
          _isNameMatch(tokens.detectedName!, card.name)) {
        score += 0.35;
        reasons.add('Name Match (${card.name})');
        hasNameMatch = true;
      }

      if (tokens.detectedSetCode != null &&
          card.setCode != null &&
          tokens.detectedSetCode!.toUpperCase() ==
              card.setCode!.toUpperCase()) {
        score += 0.15;
        reasons.add('Set Code Match (${card.setCode})');
        hasSetMatch = true;
      }

      candidates.add(
        CardMatchCandidate(
          card: card,
          score: score.clamp(0.0, 2.0),
          matchReason: reasons.join(' + '),
          hasNumberMatch: hasNumberMatch,
          hasNameMatch: hasNameMatch,
          hasSetMatch: hasSetMatch,
        ),
      );
    }

    candidates.sort((a, b) => b.score.compareTo(a.score));

      if (candidates.isNotEmpty) {
        final top = candidates.first;
        // Since the backend is now OCR-primary and highly filtered via SQL,
        // we can trust the visual match heavily. We only require a partial
        // agreement (name OR number) or a strong visual similarity score.
        bool exactNumberMatch = top.hasNumberMatch;
        bool exactNameMatch = top.hasNameMatch;
        bool exactSetMatch = top.hasSetMatch;

        fusionTrace['top_candidate_id'] = top.card.id;
        fusionTrace['top_candidate_number_match'] = exactNumberMatch;
        fusionTrace['top_candidate_name_match'] = exactNameMatch;
        fusionTrace['top_candidate_set_match'] = exactSetMatch;

        if (exactNumberMatch || exactNameMatch || top.score >= 0.70) {
          verifiedCard = top.card;
          fusionTrace['verification_rule'] = 'BACKEND_AUTHORITATIVE';
        } else {
          fusionTrace['verification_rule'] = 'FAILED (Backend Match Score Too Low)';
        }
      } else {
      fusionTrace['verification_rule'] = 'FAILED (No Visual Candidates)';
    }

    return ScanMatchResult(
      state: verifiedCard != null
          ? ScanResultState.exactMatchVerified
          : candidates.isNotEmpty
          ? ScanResultState.candidatesUnverified
          : ScanResultState.ocrParsedNoCatalogMatch,
      verifiedCard: verifiedCard,
      candidates: candidates,
      visualBackendStatus: visualResult.status,
      visualCandidates: visualResult.candidates,
      fusionTrace: fusionTrace,
    );
  }

  @override
  Future<void> dispose() async {
    _ocrService.dispose();
  }

  static bool _isNumberMatch(
    String detected,
    String cardNumber,
    String numberClean,
  ) {
    final dClean = detected
        .replaceAll(RegExp(r'[^a-zA-Z0-9/]'), '')
        .toLowerCase();
    final cClean = cardNumber
        .replaceAll(RegExp(r'[^a-zA-Z0-9/]'), '')
        .toLowerCase();
    final dNumerator = detected
        .split('/')
        .first
        .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
        .toLowerCase();
    return dClean == cClean ||
        dNumerator == numberClean.toLowerCase() ||
        cClean.contains(dClean);
  }

  static bool _isFuzzyNumberMatch(String detected, String cardNumber) {
    // Treat '0L078/063' -> '078/063' by stripping common garbage prefixes
    final cClean = cardNumber
        .replaceAll(RegExp(r'[^a-zA-Z0-9/]'), '')
        .toLowerCase();
    final dClean = detected
        .replaceAll(RegExp(r'[^a-zA-Z0-9/]'), '')
        .toLowerCase();
    if (dClean.endsWith(cClean) && dClean.length <= cClean.length + 3) {
      return true;
    }
    return false;
  }

  static bool _isNameMatch(String detected, String cardName) {
    final d = detected.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    final c = cardName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    return c.contains(d) || d.contains(c);
  }
}
