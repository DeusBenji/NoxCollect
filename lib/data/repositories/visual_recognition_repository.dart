import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as img;

import '../../domain/models/scan_models.dart';
import '../../features/scanner/utils/viewfinder_transform.dart';

class VisualRecognitionRepository {
  // Use dart-define for configurability, fallback to emulator localhost
  final String baseUrl = const String.fromEnvironment(
    'NOX_BACKEND_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );
  final _uuid = const Uuid();

  Future<VisualRecognitionResult> recognizeCard({
    required XFile imageFile,
    required double screenWidth,
    required double screenHeight,
    required double guideLeft,
    required double guideTop,
    required double guideWidth,
    required double guideHeight,
    String? ocrName,
    String? ocrNumber,
    String? ocrSetCode,
  }) async {
    final requestId = _uuid.v4();
    final stopwatch = Stopwatch()..start();

    print(
      '[$requestId] VisualRecognitionRepository: Target URL resolves to $baseUrl',
    );

    int? statusCode;
    String? responseBody;

    try {
      // 1. Decode original image and calculate crop
      final bytes = await imageFile.readAsBytes();
      final decodedImage = img.decodeImage(bytes);
      if (decodedImage == null) throw Exception('Failed to decode image bytes');

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

      // 2. Crop the image precisely to the ROI
      final croppedImage = img.copyCrop(
        decodedImage,
        x: cardCropRect.left.toInt(),
        y: cardCropRect.top.toInt(),
        width: cardCropRect.width.toInt(),
        height: cardCropRect.height.toInt(),
      );

      // 3. Encode back to JPG for upload
      final croppedBytes = img.encodeJpg(croppedImage, quality: 90);
      print('[$requestId] Cropped image size: ${croppedBytes.length} bytes');

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/recognize'),
      );
      request.headers['x-request-id'] = requestId;
      
      if (ocrName != null) request.fields['ocr_name'] = ocrName;
      if (ocrNumber != null) request.fields['ocr_number'] = ocrNumber;
      if (ocrSetCode != null) request.fields['ocr_set_code'] = ocrSetCode;

      request.files.add(
        http.MultipartFile.fromBytes(
          'file', 
          croppedBytes, 
          filename: 'cropped.jpg',
        ),
      );

      final responseStream = await request.send().timeout(
        const Duration(seconds: 15),
      );
      stopwatch.stop();
      statusCode = responseStream.statusCode;

      print(
        '[$requestId] HTTP $statusCode in ${stopwatch.elapsedMilliseconds}ms',
      );

      responseBody = await responseStream.stream.bytesToString();

      if (statusCode != 200) {
        return VisualRecognitionResult(
          status: 'HTTP_$statusCode',
          error: 'Server returned $statusCode',
        );
      }

      final data = jsonDecode(responseBody);

      if (data['status'] == 'success') {
        final candidates = (data['candidates'] as List)
            .map(
              (c) => VisualCandidate(
                id: c['id'],
                name: c['name'],
                localName: c['localName'],
                language: c['language'],
                region: c['region'],
                cardNumber: c['cardNumber'],
                setCode: c['setCode'],
                imageUrl: c['imageUrl'],
                distance: (c['distance'] as num).toDouble(),
                similarity: (c['similarity'] as num).toDouble(),
              ),
            )
            .toList();

        print(
          '[$requestId] Successfully parsed ${candidates.length} visual candidates',
        );
        return VisualRecognitionResult(
          status: 'SUCCESS',
          candidates: candidates,
        );
      }

      return VisualRecognitionResult(
        status: 'API_ERROR',
        error: 'API returned status: ${data['status']}',
      );
    } on TimeoutException {
      print('[$requestId] ERROR: Request timed out after 15s');
      return VisualRecognitionResult(
        status: 'TIMEOUT',
        error: 'Request timed out',
      );
    } on SocketException catch (e) {
      print('[$requestId] ERROR: SocketException - Unreachable: $e');
      return VisualRecognitionResult(
        status: 'UNREACHABLE',
        error: e.toString(),
      );
    } catch (e, st) {
      print('''
[$requestId] FATAL EXCEPTION IN VISUAL REPOSITORY
RuntimeType: ${e.runtimeType}
Message: $e
StatusCode: ${statusCode ?? 'null'}
ResponseBody: ${responseBody != null ? (responseBody.length > 500 ? responseBody.substring(0, 500) + '...' : responseBody) : 'null'}
StackTrace:
$st
=========================================
''');
      return VisualRecognitionResult(status: 'EXCEPTION', error: e.toString());
    }
  }
}
