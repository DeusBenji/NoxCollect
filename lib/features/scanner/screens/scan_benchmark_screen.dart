import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../domain/models/scan_models.dart';
import '../widgets/camera_viewfinder_overlay.dart';
import '../widgets/scan_result_sheet.dart';

class ScanBenchmarkScreen extends ConsumerStatefulWidget {
  const ScanBenchmarkScreen({super.key});

  @override
  ConsumerState<ScanBenchmarkScreen> createState() =>
      _ScanBenchmarkScreenState();
}

class _BenchmarkRunData {
  final int latencyMs;
  final bool ocrHadText;
  final bool nameDetected;
  final bool numberDetected;
  final bool setDetected;
  final bool candidateFound;
  final ScanResultState resultState;

  _BenchmarkRunData({
    required this.latencyMs,
    required this.ocrHadText,
    required this.nameDetected,
    required this.numberDetected,
    required this.setDetected,
    required this.candidateFound,
    required this.resultState,
  });
}

class _ScanBenchmarkScreenState extends ConsumerState<ScanBenchmarkScreen> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isProcessing = false;
  Size _previewSize = Size.zero;

  final List<_BenchmarkRunData> _benchmarkHistory = [];

  // Benchmark environmental tags for test recording
  String _selectedLighting =
      'normal'; // 'normal', 'low_light', 'overhead_glare'
  String _selectedSleeve =
      'raw'; // 'raw', 'penny_sleeve', 'matte_sleeve', 'toploader'
  String _selectedFinish =
      'non_holo'; // 'non_holo', 'holofoil', 'reverse_holo', 'full_art'

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        setState(() => _isCameraInitialized = false);
        return;
      }

      final backCamera = _cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras.first,
      );

      final controller = CameraController(
        backCamera,
        ResolutionPreset.veryHigh, // 1080p is typically ideal balance for OCR speed/sharpness
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );

      await controller.initialize();
      if (!mounted) return;

      // Benchmark must use ambient light only.
      // Never allow the device to automatically use flash/torch.
      await controller.setFlashMode(FlashMode.off);

      // Ensure auto-focus is explicitly enabled
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

    // Tap mapping to Camera sensor space:
    // Screen preview uses BoxFit.cover, which means some of the image is cropped.
    // However, setFocusPoint uses (0,0) to (1,1) in sensor coordinates.
    // Portrait orientation on Android means the camera sensor is rotated 90 degrees.
    // The `camera` package's `setFocusPoint` handles orientation internally on modern versions,
    // so we can often just pass (x/width, y/height).
    // Let's add logging to verify this assumption.
    final dx = details.localPosition.dx;
    final dy = details.localPosition.dy;
    final w = constraints.maxWidth;
    final h = constraints.maxHeight;

    final offset = Offset(dx / w, dy / h);
    debugPrint('BENCHMARK LOG: Tap to focus mapped to $offset');

    try {
      await _cameraController!.setFocusPoint(offset);
      await _cameraController!.setExposurePoint(offset);
      debugPrint('BENCHMARK LOG: Focus/Exposure point set successfully.');
    } catch (e) {
      debugPrint('BENCHMARK LOG: Focus/Exposure point failed: $e');
    }
  }

  Future<void> _performBenchmarkScan() async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _isProcessing) {
      return;
    }

    setState(() => _isProcessing = true);
    final traceStopwatch = Stopwatch()..start();
    final stepStopwatch = Stopwatch()..start();

    try {
      debugPrint('BENCHMARK LOG: Forcing flash OFF before capture...');
      await _cameraController!.setFlashMode(FlashMode.off);

      debugPrint(
        'BENCHMARK LOG: Requesting autofocus settling before capture...',
      );
      await _cameraController!.setFocusMode(FocusMode.auto);

      await Future.delayed(const Duration(milliseconds: 500));

      stepStopwatch.reset();
      final image = await _cameraController!.takePicture();
      final captureTime = stepStopwatch.elapsedMilliseconds;

      final scanRepo = ref.read(scanRepositoryProvider);

      final screenWidth = _previewSize.width;
      final screenHeight = _previewSize.height;
      final targetWidth = screenWidth * 0.85;
      final targetHeight = targetWidth * 1.4;
      final guideLeft = (screenWidth - targetWidth) / 2;
      final guideTop = (screenHeight - targetHeight) / 2.5;

      stepStopwatch.reset();
      // 1. Run Targeted OCR First (required for new visual backend flow)
      final tokens = await scanRepo.processImageTargeted(
        image,
        screenWidth: screenWidth,
        screenHeight: screenHeight,
        guideLeft: guideLeft,
        guideTop: guideTop,
        guideWidth: targetWidth,
        guideHeight: targetHeight,
      );
      final ocrTime = stepStopwatch.elapsedMilliseconds;

      // 2. Run Visual Backend with OCR tokens
      stepStopwatch.reset();
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
      );
      final visualTime = stepStopwatch.elapsedMilliseconds;

      stepStopwatch.reset();
      // Fuse Evidence
      ScanMatchResult matchResult;
      if (visualResult.status == 'SUCCESS' &&
          visualResult.candidates.isNotEmpty) {
        matchResult = await scanRepo.matchWithVisualCandidates(
          visualResult,
          tokens,
        );
      } else {
        // Explicitly log the fallback in tracing
        debugPrint(
          'BENCHMARK LOG: Visual backend failed or empty (${visualResult.status}). Falling back to OCR-only drift.',
        );
        matchResult = await scanRepo.matchCardCandidates(tokens);
        // Manually attach visual failure trace if we fell back
        matchResult = ScanMatchResult(
          state: ScanResultState.visualBackendFailed,
          verifiedCard: matchResult.verifiedCard, // Local OCR verified card
          candidates: matchResult.candidates,     // Local OCR candidates
          visualBackendStatus: visualResult.status,
          fusionTrace: {'verification_rule': 'LOCAL_OCR_FALLBACK'},
        );
      }
      final fusionTime = stepStopwatch.elapsedMilliseconds;

      traceStopwatch.stop();
      final totalLatencyMs = traceStopwatch.elapsedMilliseconds;

      debugPrint('''
=== NOX SCAN TRACE ===
capture: ${captureTime}ms
ocr: ${ocrTime}ms
visual: ${visualTime}ms
fusion: ${fusionTime}ms
total_latency: ${totalLatencyMs}ms
visual_status: ${visualResult.status}
visual_top_k: ${visualResult.candidates.length}
ocr_name: ${tokens.detectedName}
ocr_number: ${tokens.detectedNumber}
result_state: ${matchResult.state.name}
rule: ${matchResult.fusionTrace?['verification_rule']}
======================
''');

      final runData = _BenchmarkRunData(
        latencyMs: totalLatencyMs,
        ocrHadText: (tokens.rawText ?? '').trim().isNotEmpty,
        nameDetected: tokens.detectedName != null,
        numberDetected: tokens.detectedNumber != null,
        setDetected: tokens.detectedSetCode != null,
        candidateFound: matchResult.candidates.isNotEmpty,
        resultState: matchResult.state,
      );
      _benchmarkHistory.add(runData);

      _printBenchmarkSummary();

      if (!mounted) return;

      // Display diagnostic result sheet
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => ScanResultSheet(
          tokens: tokens,
          matchResult: matchResult,
          latencyMs: totalLatencyMs,
          onScanAgain: () => Navigator.of(ctx).pop(),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Scan error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _printBenchmarkSummary() {
    if (_benchmarkHistory.isEmpty) return;
    final total = _benchmarkHistory.length;
    final verified = _benchmarkHistory
        .where((r) => r.resultState == ScanResultState.exactMatchVerified)
        .length;
    final unverifiedCandidates = _benchmarkHistory
        .where((r) => r.resultState == ScanResultState.candidatesUnverified)
        .length;
    final noMatch = _benchmarkHistory
        .where((r) => r.resultState == ScanResultState.ocrParsedNoCatalogMatch)
        .length;
    final failed = _benchmarkHistory
        .where((r) => r.resultState == ScanResultState.ocrFailed)
        .length;
    final avgLatency =
        _benchmarkHistory.map((r) => r.latencyMs).reduce((a, b) => a + b) ~/
        total;

    debugPrint('=== BENCHMARK SESSION SUMMARY ===');
    debugPrint('Total Scans: $total');
    debugPrint(
      'Verified Exact Matches: $verified (${(verified / total * 100).toStringAsFixed(1)}%)',
    );
    debugPrint('Unverified Candidates: $unverifiedCandidates');
    debugPrint('No Catalog Match: $noMatch');
    debugPrint('OCR Failed completely: $failed');
    debugPrint('Average Latency: ${avgLatency}ms');
    debugPrint('=================================');
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraInitialized || _cameraController == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('NoxCollect Scanner Benchmark')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.camera_alt_outlined,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Camera Initializing / Unavailable',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'On Android device, ensure camera permissions are granted. If on emulator, mock camera or photo testing is supported.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _setupCamera,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry Camera'),
              ),
            ],
          ),
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
                  // Capture preview size for the ROI math
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

          // Top App Bar & Test Environmental Tag Bar
          SafeArea(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: Colors.black.withValues(alpha: 0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'NoxCollect Benchmark',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.tune, color: Colors.white),
                        onPressed: _showConditionSelector,
                      ),
                    ],
                  ),
                ),
                // Current Benchmark Tag Indicators
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  color: Colors.black.withValues(alpha: 0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTagBadge('Light', _selectedLighting),
                      _buildTagBadge('Sleeve', _selectedSleeve),
                      _buildTagBadge('Finish', _selectedFinish),
                    ],
                  ),
                ),
              ],
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
                    onTap: _isProcessing ? null : _performBenchmarkScan,
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

  Widget _buildTagBadge(String label, String value) {
    return Text(
      '$label: $value',
      style: const TextStyle(
        color: Colors.amberAccent,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  void _showConditionSelector() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Benchmark Test Condition Tags',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Lighting Condition:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Wrap(
                spacing: 8,
                children: ['normal', 'low_light', 'overhead_glare'].map((l) {
                  return ChoiceChip(
                    label: Text(l),
                    selected: _selectedLighting == l,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedLighting = l);
                        setModalState(() {});
                      }
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 8),
              const Text(
                'Card Protection / Sleeve:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Wrap(
                spacing: 8,
                children:
                    [
                      'raw',
                      'penny_sleeve',
                      'matte_sleeve',
                      'toploader',
                      'slab',
                    ].map((s) {
                      return ChoiceChip(
                        label: Text(s),
                        selected: _selectedSleeve == s,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedSleeve = s);
                            setModalState(() {});
                          }
                        },
                      );
                    }).toList(),
              ),
              const SizedBox(height: 8),
              const Text(
                'Card Finish:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Wrap(
                spacing: 8,
                children: ['non_holo', 'holofoil', 'reverse_holo', 'full_art']
                    .map((f) {
                      return ChoiceChip(
                        label: Text(f),
                        selected: _selectedFinish == f,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedFinish = f);
                            setModalState(() {});
                          }
                        },
                      );
                    })
                    .toList(),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Apply Tags'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
