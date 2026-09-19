import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers.dart';
import '../../../domain/models/card_models.dart';
import '../../../domain/models/scan_models.dart';
import '../../search/widgets/advanced_add_sheet.dart';

class ConsumerScanResultSheet extends ConsumerStatefulWidget {
  final ScanMatchResult matchResult;
  final ParsedCardTokens tokens;
  final ScrollController scrollController;

  const ConsumerScanResultSheet({
    super.key,
    required this.matchResult,
    required this.tokens,
    required this.scrollController,
  });

  @override
  ConsumerState<ConsumerScanResultSheet> createState() =>
      _ConsumerScanResultSheetState();
}

class _ConsumerScanResultSheetState
    extends ConsumerState<ConsumerScanResultSheet> {
  bool _isSaving = false;
  bool _showAlternatives = false;
  CardModel? _selectedCard;

  @override
  void initState() {
    super.initState();
    _selectedCard = widget.matchResult.verifiedCard ?? 
                    (widget.matchResult.candidates.isNotEmpty ? widget.matchResult.candidates.first.card : null);
  }

  void _addToCollection(CardModel card) {
    // Pop the current scan result sheet
    Navigator.of(context).pop();

    // Show the Advanced Add Sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AdvancedAddSheet(card: card),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isVerified =
        widget.matchResult.state == ScanResultState.exactMatchVerified ||
        _selectedCard != null;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: ListView(
              controller: widget.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              children: [
                if (isVerified && _selectedCard != null)
                  _buildVerifiedCard(_selectedCard!)
                else
                  _buildUnverifiedState(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifiedCard(CardModel card) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 28),
            const SizedBox(width: 8),
            Text(
              'Card Identified',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (card.imageUrlLarge != null)
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                card.imageUrlLarge!,
                height: 300,
                fit: BoxFit.contain,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      height: 300,
                      width: 215,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.broken_image, size: 64),
                    ),
              ),
            ),
          )
        else
          Container(
            height: 300,
            width: 215,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
            ),
          ),
        const SizedBox(height: 24),
        Text(
          card.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '${card.setCode ?? "Unknown Set"} • #${card.cardNumber}',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 32),
        FilledButton.icon(
          onPressed: _isSaving ? null : () => _addToCollection(card),
          icon:
              _isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.add_circle_outline),
          label: const Text('Add to Collection'),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.amber.shade700,
            foregroundColor: Colors.white,
          ),
        ),
        
        // Alternatives Fallback UI
        if (widget.matchResult.candidates.length > 1) ...[
          const SizedBox(height: 16),
          if (!_showAlternatives)
            TextButton(
              onPressed: () => setState(() => _showAlternatives = true),
              child: const Text('Wrong card? See other matches'),
            )
          else ...[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Other possible matches:',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.matchResult.candidates.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final candidate = widget.matchResult.candidates[index];
                  if (candidate.card.id == card.id) return const SizedBox.shrink(); // skip currently selected
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCard = candidate.card;
                        _showAlternatives = false; // Optionally collapse after selection
                      });
                    },
                    child: SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: candidate.card.imageUrlSmall != null
                                  ? Image.network(
                                      candidate.card.imageUrlSmall!,
                                      fit: BoxFit.contain,
                                      errorBuilder: (ctx, e, s) => const Icon(Icons.broken_image),
                                    )
                                  : Container(
                                      color: Colors.grey.shade200,
                                      child: const Icon(Icons.image_not_supported),
                                    ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            candidate.card.name,
                            style: const TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${candidate.card.setCode ?? "?"} #${candidate.card.cardNumber}',
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ]
        ],
      ],
    );
  }

  Widget _buildUnverifiedState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.help_outline, color: Colors.orange, size: 64),
        const SizedBox(height: 16),
        const Text(
          'Card Not Found',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'We couldn\'t verify this card with high confidence. Please ensure it is well lit, clearly in frame, and not obscured.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 32),
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          child: const Text('Try Again'),
        ),
      ],
    );
  }
}
