import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:noxcollect/data/services/ocr_scan_service.dart';

RecognizedText _mockRecognizedText(List<Map<String, dynamic>> blocksData) {
  final blocks = blocksData.map<TextBlock>((b) {
    final linesData = b['lines'] as List<String>;
    final lines = linesData.map<TextLine>((l) {
      return TextLine(
        text: l,
        boundingBox: b['rect'] ?? const Rect.fromLTWH(0, 0, 100, 20),
        elements: [],
        recognizedLanguages: [],
        cornerPoints: [],
        confidence: 1.0,
        angle: 0.0,
      );
    }).toList();
    return TextBlock(
      text: linesData.join('\n'),
      lines: lines,
      boundingBox: b['rect'] ?? const Rect.fromLTWH(0, 0, 100, 20),
      recognizedLanguages: [],
      cornerPoints: [],
    );
  }).toList();
  return RecognizedText(
    text: blocks.map((b) => b.text).join('\n'),
    blocks: blocks,
  );
}

void main() {
  group('OcrScanService Parser Tests', () {
    test('1. Plausible header name beats "Evolves from ..."', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Mega Gengar ex'],
          'rect': const Rect.fromLTWH(10, 10, 200, 40),
        },
        {
          'lines': ['Evolves from Haunter'],
          'rect': const Rect.fromLTWH(10, 60, 150, 15),
        },
        {
          'lines': ['Some random body text here'],
          'rect': const Rect.fromLTWH(10, 100, 200, 20),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedName, 'Mega Gengar ex');
      expect(tokens.rawNameCandidate, 'Mega Gengar ex');
    });

    test('2. Fused name + HP being separable', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Mega GengareX350'],
          'rect': const Rect.fromLTWH(10, 10, 250, 40),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(
        tokens.detectedName,
        'Mega Gengar ex',
      ); // _cleanCandidateName cleans up the 'eX' to ' ex' and strips HP
    });

    test('3. HP such as 340 not becoming collector number or name', () {
      final input = _mockRecognizedText([
        {
          'lines': ['340'],
          'rect': const Rect.fromLTWH(10, 10, 50, 20),
        },
        {
          'lines': ['130'],
          'rect': const Rect.fromLTWH(10, 50, 50, 20),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedName, isNull);
      expect(tokens.detectedNumber, isNull);
    });

    test(
      '5 & 6. Random numeric/alphanumeric fragments not becoming set codes',
      () {
        final input = _mockRecognizedText([
          {
            'lines': ['0780'],
            'rect': const Rect.fromLTWH(10, 10, 50, 20),
          },
          {
            'lines': ['2770'],
            'rect': const Rect.fromLTWH(10, 50, 50, 20),
          },
          {
            'lines': ['GAML'],
            'rect': const Rect.fromLTWH(10, 80, 50, 20),
          },
          {
            'lines': ['19D'],
            'rect': const Rect.fromLTWH(10, 110, 50, 20),
          },
        ]);
        final tokens = OcrScanService.parseRecognizedText(input);
        expect(
          tokens.detectedSetCode,
          isNull,
        ); // Without known DB evidence, strict format applies
      },
    );

    test('7. Known catalog set codes being accepted', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Card name'],
          'rect': const Rect.fromLTWH(10, 10, 100, 20),
        },
        {
          'lines': ['M1L'],
          'rect': const Rect.fromLTWH(10, 80, 50, 20),
        }, // Bottom zone
      ]);
      final tokens = OcrScanService.parseRecognizedText(
        input,
        knownSetCodes: {'M1L'},
      );
      expect(tokens.detectedSetCode, 'M1L');
    });

    test('8. Standard collector number 029/063', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Card name'],
          'rect': const Rect.fromLTWH(10, 10, 100, 20),
        },
        {
          'lines': ['029/063'],
          'rect': const Rect.fromLTWH(10, 80, 100, 20),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedNumber, '029/063');
    });

    test('9. Classic collector number 4/102', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Card name'],
          'rect': const Rect.fromLTWH(10, 10, 100, 20),
        },
        {
          'lines': ['4/102'],
          'rect': const Rect.fromLTWH(10, 80, 100, 20),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedNumber, '4/102');
    });

    test('10. Trainer Gallery TG01/TG30', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Card name'],
          'rect': const Rect.fromLTWH(10, 10, 100, 20),
        },
        {
          'lines': ['TG01/TG30'],
          'rect': const Rect.fromLTWH(10, 80, 100, 20),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedNumber, 'TG01/TG30');
    });

    test('11. Promo SVP050', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Card name'],
          'rect': const Rect.fromLTWH(10, 10, 100, 20),
        },
        {
          'lines': ['SVP 050'],
          'rect': const Rect.fromLTWH(10, 80, 100, 20),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedNumber, 'SVP050');
    });

    test(
      '12 & 13. Japanese/Latin mixed OCR where Japanese name is unavailable',
      () {
        // Name is unreadable garbage, but has set code and number
        final input = _mockRecognizedText([
          {
            'lines': ['3bDUtes340'],
            'rect': const Rect.fromLTWH(10, 10, 100, 20),
          },
          {
            'lines': ['M1L'],
            'rect': const Rect.fromLTWH(10, 100, 50, 20),
          },
          {
            'lines': ['029/063'],
            'rect': const Rect.fromLTWH(60, 100, 100, 20),
          },
        ]);
        final tokens = OcrScanService.parseRecognizedText(
          input,
          knownSetCodes: {'M1L'},
        );
        // The parser actually rejects 3bDUtes340? Wait, it won't reject it because it's not in the negative signal list.
        // But it will extract M1L and 029/063.
        expect(tokens.detectedSetCode, 'M1L');
        expect(tokens.detectedNumber, '029/063');
      },
    );

    test('14. Trainer-card layouts not being broken by Pokémon heuristics', () {
      final input = _mockRecognizedText([
        {
          'lines': ['TRAINER'],
          'rect': const Rect.fromLTWH(10, 10, 50, 10),
        }, // small text
        {
          'lines': ["Professor's Research"],
          'rect': const Rect.fromLTWH(10, 30, 200, 40),
        }, // large text
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedName, "Professor's Research");
    });

    test('15. Porygon2 does not lose its 2', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Porygon2'],
          'rect': const Rect.fromLTWH(10, 10, 200, 40),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedName, 'Porygon2');
    });

    test('16. take5/fewer does not become collector number', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Some text here'],
          'rect': const Rect.fromLTWH(10, 10, 100, 20),
        },
        {
          'lines': ['take5/fewer'],
          'rect': const Rect.fromLTWH(10, 100, 100, 20),
        }, // In lower half
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedNumber, isNull);
    });

    test('17. 041/086R correctly strips trailing R', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Card name'],
          'rect': const Rect.fromLTWH(10, 10, 100, 20),
        },
        {
          'lines': ['041/086R'],
          'rect': const Rect.fromLTWH(10, 80, 100, 20),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedNumber, '041/086');
    });

    test('18. Promo MEP 073', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Card name'],
          'rect': const Rect.fromLTWH(10, 10, 100, 20),
        },
        {
          'lines': ['MEP 073'],
          'rect': const Rect.fromLTWH(10, 80, 100, 20),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedNumber, 'MEP073');
    });

    test('19. Promo XY166', () {
      final input = _mockRecognizedText([
        {
          'lines': ['Card name'],
          'rect': const Rect.fromLTWH(10, 10, 100, 20),
        },
        {
          'lines': ['XY166'],
          'rect': const Rect.fromLTWH(10, 80, 100, 20),
        },
      ]);
      final tokens = OcrScanService.parseRecognizedText(input);
      expect(tokens.detectedNumber, 'XY166');
    });
  });
}
