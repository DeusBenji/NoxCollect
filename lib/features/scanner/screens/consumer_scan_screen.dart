import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../domain/models/scan_models.dart';
import '../widgets/camera_viewfinder_overlay.dart';
import '../widgets/consumer_scan_result_sheet.dart';

class ConsumerScanScreen extends ConsumerStatefulWidget {
  const ConsumerScanScreen({super.key});

  @override
  ConsumerState<ConsumerScanScreen> createState() => _ConsumerScanScreenState();
}

class _ConsumerScanScreenState extends ConsumerState<ConsumerScanScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isProcessing = false;
  Size? _previewSize;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        debugPrint('No cameras found.');
        return;
      }

      final backCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        backCamera,
        ResolutionPreset.high,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await controller.initialize();
      if (!mounted) return;

      await controller.setFlashMode(FlashMode.off);
      await controller.setFocusMode(FocusMode.auto);

      setState(() {
        _cameraController = controller;
        _isCameraInitialized = true;
      });
    } catch (e) {
      debugPrint('Camera init error: $e');
    }
  }

  void _onTapFocus(TapUpDetails details, BoxConstraints constraints) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    final offset = details.localPosition;
    final x = offset.dx / constraints.maxWidth;
    final y = offset.dy / constraints.maxHeight;

    try {
      await _cameraController!.setFocusPoint(Offset(x, y));
    } catch (e) {
      debugPrint('Focus error: $e');
    }
  }

  Future<void> _performScan() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final image = await _cameraController!.takePicture();

      if (!mounted) return;
      final scanRepo = ref.read(scanRepositoryProvider);

      final screenWidth = _previewSize?.width ?? MediaQuery.of(context).size.width;
      final screenHeight = _previewSize?.height ?? MediaQuery.of(context).size.height;
      final targetWidth = screenWidth * 0.75;
      final targetHeight = targetWidth * 1.4;
      final guideLeft = (screenWidth - targetWidth) / 2;
      final guideTop = (screenHeight - targetHeight) / 2.5;

      // 1. Run Targeted OCR
      final tokens = await scanRepo.processImageTargeted(
        image,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        guideLeft: guideLeft,
        guideTop: guideTop,
        guideWidth: targetWidth,
        guideHeight: targetHeight,
      );

      // 2. Run Visual Backend with OCR tokens
      final visualResult = await scanRepo.recognizeVisually(
        imageFile: image,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        guideLeft: guideLeft,
        guideTop: guideTop,
        guideWidth: targetWidth,
        guideHeight: targetHeight,
        ocrName: tokens.detectedName,
        ocrNumber: tokens.detectedNumber,
        ocrSetCode: tokens.detectedSetCode,
      );

      // 3. Fuse Evidence
      final matchResult = await scanRepo.matchWithVisualCandidates(
        visualResult,
        tokens,
      );

      if (!mounted) return;
      _showResultSheet(matchResult, tokens);
    } catch (e) {
      debugPrint('Scan Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during scan: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showResultSheet(ScanMatchResult result, ParsedCardTokens tokens) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        builder: (_, scrollController) {
          return ConsumerScanResultSheet(
            matchResult: result,
            tokens: tokens,
            scrollController: scrollController,
          );
        },
      ),
    ).then((_) {
      // Re-enable continuous processing if needed later, but right now we rely on a manual button
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview inside Viewfinder Overlay
          CameraViewfinderOverlay(
            child: SizedBox.expand(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  _previewSize = Size(
                    constraints.maxWidth,
                    constraints.maxHeight,
                  );
                  return GestureDetector(
                    onTapUp: (details) => _onTapFocus(details, constraints),
                    child: CameraPreview(_cameraController!),
                  );
                },
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),

          // Bottom Control Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(bottom: 36, top: 16),
              color: Colors.black.withValues(alpha: 0.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _isProcessing ? null : _performScan,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        color: _isProcessing
                            ? Colors.grey
                            : Colors.amber.shade700,
                      ),
                      child: _isProcessing
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 36,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
