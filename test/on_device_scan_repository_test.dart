import 'package:flutter_test/flutter_test.dart';
import 'package:noxcollect/domain/models/card_models.dart';
import 'package:noxcollect/domain/models/scan_models.dart';
import 'package:noxcollect/domain/repositories/card_repository.dart';
import 'package:noxcollect/data/repositories/on_device_scan_repository.dart';

class MockCardRepository implements CardRepository {
  final List<SetModel> sets = [
    const SetModel(
      id: 'ja-m1l',
      name: 'Mega Brave',
      setCode: 'M1L',
      language: 'ja',
      region: 'JP',
      series: 'Mega',
    ),
    const SetModel(id: 'base1', name: 'Base Set', series: 'Base'),
  ];

  final List<CardModel> cards = [
    const CardModel(
      id: 'c1',
      name: 'Mega Lucario ex',
      localName: 'メガルカリオex',
      cardNumber: '078/063',
      numberClean: '078',
      numberDenominator: '063',
      setCode: 'M1L',
      setId: 'ja-m1l',
      cleanName: 'megalucarioex',
      language: 'ja',
      region: 'JP',
    ),
    const CardModel(
      id: 'c2',
      name: 'Mega Lucario ex',
      localName: 'メガルカリオex',
      cardNumber: '029/063',
      numberClean: '029',
      numberDenominator: '063',
      setCode: 'M1L',
      setId: 'ja-m1l',
      cleanName: 'megalucarioex',
      language: 'ja',
      region: 'JP',
    ),
    const CardModel(
      id: 'c3',
      name: 'Riolu',
      localName: 'リオル',
      cardNumber: '028/063',
      numberClean: '028',
      numberDenominator: '063',
      setCode: 'M1L',
      setId: 'ja-m1l',
      cleanName: 'riolu',
      language: 'ja',
      region: 'JP',
    ),
    const CardModel(
      id: 'c4',
      name: 'Charizard',
      cardNumber: '4/102',
      numberClean: '4',
      numberDenominator: '102',
      setId: 'base1',
      cleanName: 'charizard',
    ),
    const CardModel(
      id: 'chr-41',
      name: 'Gourgeist ex',
      cleanName: 'gourgeistex',
      cardNumber: '041/086',
      numberClean: '041',
      numberDenominator: '086',
      setId: 'chr',
      setCode: null,
      language: 'en',
      region: 'US',
    ),
  ];

  @override
  Future<List<SetModel>> getAllSets() async => sets;

  @override
  Future<List<CardModel>> findCardsByNumber(String number) async {
    final clean = number.split('/').first;
    return cards
        .where((c) => c.numberClean == clean || c.cardNumber == number)
        .toList();
  }

  @override
  Future<List<CardModel>> searchCards({
    String? query,
    String? setId,
    String? artist,
    int limit = 50,
  }) async {
    if (query == null) return [];
    final clean = query.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    return cards.where((c) => c.cleanName.contains(clean)).toList();
  }

  @override
  Future<List<CardModel>> getCardsByArtist(String artistName) async => [];

  @override
  Future<List<CardModel>> getCardsBySet(String setId) async {
    return cards.where((c) => c.setId == setId).toList();
  }

  // Not needed for these tests
  @override
  Future<void> upsertCards(List<CardModel> cards) async {}
  @override
  Future<void> upsertSets(List<SetModel> sets) async {}
  @override
  Future<CardModel?> getCardById(String id) async {
    try {
      return cards.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}

void main() {
  late OnDeviceScanRepository repository;

  setUp(() {
    repository = OnDeviceScanRepository(MockCardRepository());
  });

  group('Verification Policy', () {
    test('1. Collector number alone does NOT verify a card', () async {
      final tokens = const ParsedCardTokens(detectedNumber: '028/063');
      final result = await repository.matchCardCandidates(tokens);
      expect(result.state, ScanResultState.candidatesUnverified);
      expect(result.candidates.first.card.name, 'Riolu');
    });

    test('2. Set code alone does NOT verify a card', () async {
      final tokens = const ParsedCardTokens(detectedSetCode: 'M1L');
      final result = await repository.matchCardCandidates(tokens);
      expect(result.state, ScanResultState.candidatesUnverified);
      expect(result.candidates.length, greaterThan(1));
    });

    test(
      '4 & 15. Known verified set + exact collector number verifies printing',
      () async {
        final tokens = const ParsedCardTokens(
          detectedSetCode: 'M1L',
          detectedNumber: '078/063',
        );
        final result = await repository.matchCardCandidates(tokens);
        expect(result.state, ScanResultState.exactMatchVerified);
        expect(result.verifiedCard?.name, 'Mega Lucario ex');
        expect(result.verifiedCard?.cardNumber, '078/063');
      },
    );

    test('5. Strong name + exact collector number verify identity', () async {
      final tokens = const ParsedCardTokens(
        detectedName: 'Charizard',
        detectedNumber: '4/102',
      );
      final result = await repository.matchCardCandidates(tokens);
      expect(result.state, ScanResultState.exactMatchVerified);
      expect(result.verifiedCard?.name, 'Charizard');
    });

    test(
      '6 & 7. Regex-valid but unknown token is NOT a verified set',
      () async {
        final tokens = const ParsedCardTokens(
          detectedSetCode: 'SVI',
        ); // Not in mock DB
        final result = await repository.matchCardCandidates(tokens);
        // It falls back to OCR PARSED NO CATALOG MATCH
        expect(result.state, ScanResultState.ocrParsedNoCatalogMatch);
      },
    );

    test('11. Unknown English card remains NO_CATALOG_MATCH', () async {
      final tokens = const ParsedCardTokens(
        detectedName: 'Mega Gengar ex',
        detectedSetCode: 'PHF',
        detectedNumber: '34/119',
      );
      final result = await repository.matchCardCandidates(tokens);
      expect(result.state, ScanResultState.ocrParsedNoCatalogMatch);
    });

    test(
      '16 & 17. Garbled Japanese name + 028/063 does NOT verify Riolu',
      () async {
        final tokens = const ParsedCardTokens(
          detectedName: 'XbDUex340',
          detectedNumber: '028/063',
        );
        final result = await repository.matchCardCandidates(tokens);
        expect(result.state, ScanResultState.candidatesUnverified);
        expect(result.candidates.first.card.name, 'Riolu');
      },
    );

    test(
      '18. Garbled Japanese name + verified M1L + exact 078/063 CAN resolve',
      () async {
        final tokens = const ParsedCardTokens(
          detectedName: 'XbDUex340',
          detectedSetCode: 'M1L',
          detectedNumber: '078/063',
        );
        final result = await repository.matchCardCandidates(tokens);
        expect(result.state, ScanResultState.exactMatchVerified);
        expect(result.verifiedCard?.cardNumber, '078/063');
      },
    );
    test('Verification Policy 19. English card with exact number + name verifies (Gourgeist ex)', () async {
      final tokens = const ParsedCardTokens(
        detectedName: 'Gourgeist ex',
        detectedNumber: '041/086',
      );
      final result = await repository.matchCardCandidates(tokens);
      expect(result.state, ScanResultState.exactMatchVerified);
      expect(result.verifiedCard?.name, 'Gourgeist ex');
    });

    test('Visual Fusion 1. Strong visual match WITHOUT any OCR is candidatesUnverified', () async {
      final tokens = const ParsedCardTokens(
        rawText: "some garbage",
        detectedName: null,
        detectedNumber: null,
      );
      final visualCandidates = VisualRecognitionResult(
        status: 'SUCCESS',
        candidates: [
          VisualCandidate(
            id: 'chr-41',
            name: 'Gourgeist ex',
            language: 'en',
            region: 'US',
            cardNumber: '041/086',
            distance: 0.05,
            similarity: 0.95,
          ),
          VisualCandidate(
            id: 'ex1-2',
            name: 'Other Card',
            language: 'en',
            region: 'US',
            distance: 0.2,
            similarity: 0.8,
          ),
        ],
      );
      final result = await repository.matchWithVisualCandidates(
        visualCandidates,
        tokens,
      );

      expect(result.state, ScanResultState.candidatesUnverified);
      expect(result.verifiedCard, isNull);
      expect(
        result.candidates.first.card.id,
        'chr-41',
      ); // Correctly placed it at top
    });

    test('Visual Fusion 3. Visual match + name + number OCR verifies the printing', () async {
      final tokens = const ParsedCardTokens(rawText: "Gourgeist ex 041/086", detectedNumber: "041/086", detectedName: "Gourgeist ex");
      final visualCandidates = VisualRecognitionResult(status: 'SUCCESS', candidates: [
        VisualCandidate(id: 'chr-41', name: 'Gourgeist ex', language: 'en', region: 'US', cardNumber: '041/086', distance: 0.05, similarity: 0.95),
        VisualCandidate(id: 'ex1-2', name: 'Other Card', language: 'en', region: 'US', distance: 0.2, similarity: 0.8),
      ]);
      final result = await repository.matchWithVisualCandidates(visualCandidates, tokens);
      
      expect(result.state, ScanResultState.exactMatchVerified);
      expect(result.verifiedCard?.id, 'chr-41');
    });

    test('Visual Fusion 4. Visual match + fuzzy number OCR verifies safely', () async {
      // e.g., ML Kit outputs '0L078/063' instead of '078/063'
      final visualCandidates = VisualRecognitionResult(status: 'SUCCESS', candidates: [
        // Our mock DB doesn't have Mega Lucario, so let's pretend Gourgeist is the card but OCR got '0L041/086'
        VisualCandidate(id: 'chr-41', name: 'Gourgeist ex', language: 'en', region: 'US', cardNumber: '041/086', distance: 0.05, similarity: 0.95),
      ]);
      final tokensFuzzy = const ParsedCardTokens(rawText: "Gourgeist ex 0L041/086", detectedNumber: "0L041/086", detectedName: "Gourgeist ex");
      
      final result = await repository.matchWithVisualCandidates(visualCandidates, tokensFuzzy);
      
      expect(result.state, ScanResultState.exactMatchVerified);
      expect(result.verifiedCard?.id, 'chr-41');
      expect(result.fusionTrace?['verification_rule'], 'NAME + NUMBER');
    });

    test('Visual Fusion 5. Distance and Similarity contract is preserved', () async {
      final tokens = const ParsedCardTokens(rawText: "garbage", detectedNumber: null, detectedName: null);
      final visualCandidates = VisualRecognitionResult(status: 'SUCCESS', candidates: [
        VisualCandidate(id: 'chr-41', name: 'Gourgeist ex', language: 'en', region: 'US', cardNumber: '041/086', distance: 0.1245, similarity: 0.8755),
      ]);
      final result = await repository.matchWithVisualCandidates(visualCandidates, tokens);
      
      final candidate = result.candidates.first;
      expect(candidate.score, 0.8755);
      expect(candidate.matchReason, contains('Dist: 0.124'));
      expect(candidate.matchReason, contains('Sim: 0.875')); // toStringAsFixed(3)
    });
  });
}
