import 'package:camera/camera.dart';

import '../models/scan_models.dart';

abstract class ScanRepository {
  /// Initialize the on-device text recognizer engine.
  Future<void> initialize();

  /// Extract text tokens from a captured camera image or snapshot.
  Future<ParsedCardTokens> processImage(XFile imageFile);

  /// Extract text tokens using a multi-pass ROI approach.
  Future<ParsedCardTokens> processImageTargeted(
    XFile imageFile, {
    required double screenWidth,
    required double screenHeight,
    required double guideLeft,
    required double guideTop,
    required double guideWidth,
    required double guideHeight,
  });

  /// Extract text tokens from a live camera image stream frame.
  Future<ParsedCardTokens> processCameraImage(CameraImage cameraImage);

  /// Attempt to match parsed OCR tokens against the local card database.
  Future<ScanMatchResult> matchCardCandidates(ParsedCardTokens tokens);

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
  });

  /// Fuse visual backend candidates with local OCR tokens to determine identity.
  Future<ScanMatchResult> matchWithVisualCandidates(
    VisualRecognitionResult visualResult,
    ParsedCardTokens tokens,
  );

  /// Release resources held by the OCR engine.
  Future<void> dispose();
}
