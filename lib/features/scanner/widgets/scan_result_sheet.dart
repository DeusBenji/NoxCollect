import 'package:flutter/material.dart';

import '../../../domain/models/scan_models.dart';

class ScanResultSheet extends StatelessWidget {
  final ParsedCardTokens tokens;
  final ScanMatchResult matchResult;
  final int latencyMs;
  final VoidCallback onScanAgain;

  const ScanResultSheet({
    super.key,
    required this.tokens,
    required this.matchResult,
    required this.latencyMs,
    required this.onScanAgain,
  });

  @override
  Widget build(BuildContext context) {
    final candidates = matchResult.candidates;
    final verifiedCard = matchResult.verifiedCard;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        // Added scroll view for space
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with latency badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Scan Benchmark Result',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: Text(
                    '${latencyMs}ms',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.green.shade50,
                  labelStyle: TextStyle(color: Colors.green.shade800),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 1. VISUAL BACKEND PROVENANCE
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'VISUAL BACKEND PROVENANCE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildDiagnosticRow(
                    'Status:',
                    matchResult.visualBackendStatus ?? 'UNKNOWN',
                    matchResult.visualBackendStatus == 'SUCCESS',
                  ),

                  if (matchResult.visualCandidates != null &&
                      matchResult.visualCandidates!.isNotEmpty) ...[
                    const Divider(height: 16),
                    const Text(
                      'VISUAL TOP-K:',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    ...matchResult.visualCandidates!
                        .take(3)
                        .map(
                          (vc) => Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              '${vc.id} | ${vc.name} | Dist: ${vc.distance.toStringAsFixed(3)} | Sim: ${vc.similarity.toStringAsFixed(3)}',
                              style: const TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                        ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 2. OCR EXTRACTION PROVENANCE
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'OCR OBSERVATION',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildDiagnosticRow(
                    'Parsed Card #:',
                    tokens.detectedNumber ?? 'NOT FOUND',
                    tokens.detectedNumber != null,
                  ),
                  _buildDiagnosticRow(
                    'Parsed Name:',
                    tokens.detectedName ?? 'NOT FOUND',
                    tokens.detectedName != null,
                  ),
                  if (tokens.detectedSetCode != null)
                    _buildDiagnosticRow(
                      'Set Code:',
                      tokens.detectedSetCode!,
                      true,
                    ),
                  const Divider(height: 16),
                  const Text(
                    'RAW TEXT (DEVELOPER MODE)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildRawTextDiagnostic(tokens),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // 3. EVIDENCE FUSION PROVENANCE
            if (matchResult.fusionTrace != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.purple.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'EVIDENCE FUSION',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 6),
                    _buildDiagnosticRow(
                      'Rule applied:',
                      matchResult.fusionTrace!['verification_rule']
                              ?.toString() ??
                          'N/A',
                      matchResult.state == ScanResultState.exactMatchVerified,
                    ),
                    if (matchResult.fusionTrace!['top_candidate_id'] != null)
                      _buildDiagnosticRow(
                        'Top ID:',
                        matchResult.fusionTrace!['top_candidate_id'].toString(),
                        true,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // 4. VERIFICATION STATE Banner
            _buildResultStateBanner(matchResult.state),
            const SizedBox(height: 16),

            // Matches
            if (candidates.isEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 36,
                      color: Colors.amber.shade800,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'NO CATALOG MATCH',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.amber.shade900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Could not find a candidate card in the local database.',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else ...[
              Text(
                verifiedCard != null
                    ? 'EXACT MATCH VERIFIED'
                    : 'CANDIDATES (UNVERIFIED)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: verifiedCard != null
                      ? Colors.green.shade800
                      : Colors.orange.shade800,
                ),
              ),
              const SizedBox(height: 8),
              ...candidates
                  .take(3)
                  .map(
                    (c) =>
                        _buildCandidateTile(c, c.card.id == verifiedCard?.id),
                  ),
            ],

            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onScanAgain,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Scan Next Card'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosticRow(String label, String value, bool isSuccess) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withValues(alpha: 0.89),
            ),
          ),
          Row(
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.cancel,
                size: 14,
                color: isSuccess ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isSuccess ? Colors.black87 : Colors.red.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultStateBanner(ScanResultState state) {
    Color color;
    String text;
    switch (state) {
      case ScanResultState.ocrFailed:
        color = Colors.red;
        text = 'OCR FAILED';
        break;
      case ScanResultState.ocrParsedNoCatalogMatch:
        color = Colors.orange;
        text = 'OCR PARSED - NO CATALOG MATCH';
        break;
      case ScanResultState.candidatesUnverified:
        color = Colors.amber.shade700;
        text = 'CANDIDATES UNVERIFIED';
        break;
      case ScanResultState.exactMatchVerified:
        color = Colors.green.shade700;
        text = 'EXACT MATCH VERIFIED';
        break;
      case ScanResultState.visualBackendFailed:
        color = Colors.red.shade900;
        text = 'VISUAL BACKEND FAILED';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            state == ScanResultState.exactMatchVerified
                ? Icons.check_circle
                : Icons.info,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCandidateTile(CardMatchCandidate candidate, bool isVerified) {
    final card = candidate.card;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isVerified ? Colors.green.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isVerified ? Colors.green.shade300 : Colors.grey.shade300,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          card.name,
          style: TextStyle(
            fontWeight: isVerified ? FontWeight.bold : FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (card.localName != null) Text('Local: ${card.localName!}'),
            Text(
              '${card.setCode ?? "Unknown"} • #${card.cardNumber}',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            if (isVerified && card.language.isNotEmpty)
              Text(
                'Lang: ${card.language} • Reg: ${card.region}',
                style: TextStyle(color: Colors.green.shade800, fontSize: 11),
              ),
            const SizedBox(height: 4),
            Text(
              'Evidence: ${candidate.matchReason}',
              style: TextStyle(
                fontSize: 11,
                color: isVerified
                    ? Colors.green.shade700
                    : Colors.blue.shade700,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${(candidate.score * 100).toInt()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: isVerified
                    ? Colors.green.shade700
                    : Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRawTextDiagnostic(ParsedCardTokens tokens) {
    if (tokens.rawText == null || tokens.rawText!.trim().isEmpty) {
      return Text(
        'ML Kit returned no text',
        style: TextStyle(
          fontSize: 12,
          color: Colors.red.shade700,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    final bool parsingFailed =
        tokens.detectedNumber == null &&
        tokens.detectedName == null &&
        tokens.detectedSetCode == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (parsingFailed) ...[
          Text(
            'ML Kit returned text but token parsing failed.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.orange.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
        ],
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxHeight: 120),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: parsingFailed
                  ? Colors.orange.shade300
                  : Colors.grey.shade200,
            ),
          ),
          child: SingleChildScrollView(
            child: SelectableText(
              tokens.rawText!,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
