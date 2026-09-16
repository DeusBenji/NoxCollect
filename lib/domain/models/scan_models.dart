import 'card_models.dart';

/// Represents parsed text tokens extracted from an OCR scan.
class ParsedCardTokens {
  final String? rawText;
  final String? rawNameCandidate;
  final String? detectedName;
  final String? detectedNumber;
  final String? detectedSetCode;
  final double nameConfidence;
  final double numberConfidence;

  const ParsedCardTokens({
    this.rawText,
    this.rawNameCandidate,
    this.detectedName,
    this.detectedNumber,
    this.detectedSetCode,
    this.nameConfidence = 0.0,
    this.numberConfidence = 0.0,
  });

  bool get hasNumber => detectedNumber != null && detectedNumber!.isNotEmpty;
  bool get hasName => detectedName != null && detectedName!.isNotEmpty;
}

/// The exact state of the identification pipeline.
enum ScanResultState {
  /// OCR failed to extract any meaningful text.
  ocrFailed,

  /// OCR parsed tokens, but no matching catalog candidates were found.
  ocrParsedNoCatalogMatch,

  /// Candidates were found, but evidence is insufficient for exact verification.
  candidatesUnverified,

  /// Strong independent evidence unambiguously resolved to an exact catalog printing.
  exactMatchVerified,

  /// Visual backend could not be reached or timed out.
  visualBackendFailed,
}

/// A visual candidate from the backend
class VisualCandidate {
  final String id;
  final String name;
  final String? localName;
  final String language;
  final String region;
  final String? cardNumber;
  final String? setCode;
  final String? imageUrl;
  final double distance;
  final double similarity;

  VisualCandidate({
    required this.id,
    required this.name,
    this.localName,
    required this.language,
    required this.region,
    this.cardNumber,
    this.setCode,
    this.imageUrl,
    required this.distance,
    required this.similarity,
  });
}

class VisualRecognitionResult {
  final String status;
  final List<VisualCandidate> candidates;
  final String? error;

  VisualRecognitionResult({
    required this.status,
    this.candidates = const [],
    this.error,
  });
}

/// The final outcome of the scan, candidate generation, and verification.
class ScanMatchResult {
  final ScanResultState state;
  final CardModel? verifiedCard;
  final List<CardMatchCandidate> candidates;
  final String visualBackendStatus; // e.g. "SUCCESS", "TIMEOUT", "UNREACHABLE"
  final List<VisualCandidate> visualCandidates;
  final Map<String, dynamic>? fusionTrace;

  const ScanMatchResult({
    required this.state,
    this.verifiedCard,
    this.candidates = const [],
    this.visualBackendStatus = 'NOT_RUN',
    this.visualCandidates = const [],
    this.fusionTrace,
  });
}

/// A candidate match returned by the card identification query.
class CardMatchCandidate {
  final CardModel card;
  final double score; // 0.0 to 1.0 confidence
  final String
  matchReason; // e.g. "Exact Number + Name Prefix", "Number Match Only"
  final bool hasNumberMatch;
  final bool hasNameMatch;
  final bool hasSetMatch;

  const CardMatchCandidate({
    required this.card,
    required this.score,
    required this.matchReason,
    this.hasNumberMatch = false,
    this.hasNameMatch = false,
    this.hasSetMatch = false,
  });
}

/// Comprehensive benchmark record for a single scan execution.
class ScanBenchmarkResult {
  final String id;
  final DateTime timestamp;
  final int processingTimeMs;

  // OCR Extraction Metrics
  final bool cardNumberOcrSuccess;
  final bool cardNameOcrSuccess;
  final bool combinedOcrSuccess;

  // Identification & Matching Metrics
  final bool exactMatchSuccess;
  final bool top3CandidateSuccess;
  final bool isFalsePositive;

  // Environmental & Card Condition Context
  final String lightingCondition; // 'normal', 'low_light', 'overhead_glare'
  final String
  sleeveState; // 'raw', 'penny_sleeve', 'matte_sleeve', 'toploader', 'slab'
  final String finishType; // 'non_holo', 'holofoil', 'reverse_holo', 'full_art'
  final String? targetCardId; // Expected card ID in ground truth

  // Raw Diagnostic Data
  final String rawOcrText;
  final String? parsedNumber;
  final String? parsedName;
  final List<CardMatchCandidate> candidates;

  const ScanBenchmarkResult({
    required this.id,
    required this.timestamp,
    required this.processingTimeMs,
    required this.cardNumberOcrSuccess,
    required this.cardNameOcrSuccess,
    required this.combinedOcrSuccess,
    required this.exactMatchSuccess,
    required this.top3CandidateSuccess,
    required this.isFalsePositive,
    this.lightingCondition = 'normal',
    this.sleeveState = 'raw',
    this.finishType = 'non_holo',
    this.targetCardId,
    required this.rawOcrText,
    this.parsedNumber,
    this.parsedName,
    this.candidates = const [],
  });
}
