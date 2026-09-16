import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import '../lib/domain/models/scan_models.dart';
import '../lib/data/repositories/visual_recognition_repository.dart';

void main() {
  test('VisualRecognitionRepository parses real FastAPI JSON response correctly', () {
    // Simulated JSON exactly matching the FastAPI response
    const jsonString = '''
    {
      "status": "success",
      "requestId": "1234-abcd",
      "model": "clip-ViT-B-32",
      "metrics": {
        "decode_ms": 1.2,
        "infer_ms": 45.0,
        "pgvector_ms": 5.0,
        "serial_ms": 1.0,
        "total_ms": 52.2
      },
      "candidates": [
        {
          "id": "chr-41",
          "name": "Gourgeist ex",
          "localName": null,
          "language": "en",
          "region": "US",
          "cardNumber": "041/086",
          "setCode": "PHF",
          "distance": 0.1245,
          "similarity": 0.8755,
          "referenceImageId": 99
        }
      ]
    }
    ''';

    final data = jsonDecode(jsonString);
    
    expect(data['status'], 'success');
    
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
            distance: (c['distance'] as num).toDouble(),
            similarity: (c['similarity'] as num).toDouble(),
          ),
        )
        .toList();

    expect(candidates.length, 1);
    final vc = candidates.first;
    expect(vc.id, 'chr-41');
    expect(vc.name, 'Gourgeist ex');
    expect(vc.localName, isNull);
    expect(vc.distance, 0.1245);
    expect(vc.similarity, 0.8755);
  });
}
