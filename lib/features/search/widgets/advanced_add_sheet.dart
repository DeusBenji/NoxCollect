import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/providers.dart';
import '../../../domain/models/card_models.dart';
import '../../../domain/models/scan_models.dart';

class AdvancedAddSheet extends ConsumerStatefulWidget {
  final CardModel card;

  const AdvancedAddSheet({super.key, required this.card});

  @override
  ConsumerState<AdvancedAddSheet> createState() => _AdvancedAddSheetState();
}

class _AdvancedAddSheetState extends ConsumerState<AdvancedAddSheet> {
  String _selectedGrading = 'raw';
  double _selectedGrade = 10.0;
  final TextEditingController _priceController = TextEditingController();
  int _quantity = 1;
  bool _isSaving = false;

  final List<Map<String, String>> _gradingOptions = [
    {'label': 'Ungraded', 'value': 'raw'},
    {'label': 'PSA', 'value': 'PSA'},
    {'label': 'CGC', 'value': 'CGC'},
    {'label': 'BGS', 'value': 'BGS'},
    {'label': 'SGC', 'value': 'SGC'},
  ];

  Future<void> _submit() async {
    setState(() => _isSaving = true);
    
    try {
      final cardRepo = ref.read(cardRepositoryProvider);
      final inventoryRepo = ref.read(inventoryRepositoryProvider);

      // Ensure set exists in local DB
      await cardRepo.upsertSets([
        SetModel(
          id: widget.card.setId,
          name: widget.card.setCode ?? 'Unknown Set',
          setCode: widget.card.setCode,
          series: 'Unknown Series',
          symbolUrl: widget.card.setSymbolUrl,
        )
      ]);

      // Ensure card exists in local DB
      await cardRepo.upsertCards([widget.card]);

      // Parse price
      double? purchasePrice;
      final priceText = _priceController.text.trim();
      if (priceText.isNotEmpty) {
        purchasePrice = double.tryParse(priceText.replaceAll(',', '.'));
      }

      // Add to inventory
      final userCard = UserCardModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        cardId: widget.card.id,
        quantity: _quantity,
        condition: _selectedGrading != 'raw' ? 'graded' : 'raw',
        gradingCompany: _selectedGrading != 'raw' ? _selectedGrading : null,
        grade: _selectedGrading != 'raw' ? _selectedGrade.toString().replaceAll('.0', '') : null,
        purchasePrice: purchasePrice,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await inventoryRepo.addCardToInventory(userCard);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${widget.card.name} to collection'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding for keyboard
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Image, Name, Set, Rarity
          Row(
            children: [
              if (widget.card.imageUrlSmall != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.card.imageUrlSmall!,
                    height: 80,
                    width: 60,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => const Icon(Icons.broken_image),
                  ),
                )
              else
                Container(
                  height: 80,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.image_not_supported),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.card.name,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (widget.card.setSymbolUrl != null) ...[
                          CachedNetworkImage(
                            imageUrl: widget.card.setSymbolUrl!,
                            height: 16,
                            width: 16,
                            errorWidget: (c, u, e) => Text(widget.card.setCode ?? ''),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          '#${widget.card.cardNumber}',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.card.rarity ?? 'Unknown Rarity',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.teal.shade400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Grading Selector
          const Text('Condition / Grading', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _gradingOptions.map((option) {
                final isSelected = _selectedGrading == option['value'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(option['label']!),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedGrading = option['value']!);
                      }
                    },
                    selectedColor: Colors.blue.shade100,
                  ),
                );
              }).toList(),
            ),
          ),
          
          if (_selectedGrading != 'raw') ...[
            const SizedBox(height: 16),
            const Text('Grade', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _selectedGrade,
                    min: 1.0,
                    max: 10.0,
                    divisions: 18,
                    label: _selectedGrade.toString().replaceAll('.0', ''),
                    onChanged: (value) => setState(() => _selectedGrade = value),
                  ),
                ),
                Text(
                  _selectedGrade.toString().replaceAll('.0', ''),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
          
          const SizedBox(height: 16),
          
          // Purchase Price
          const Text('Purchase Price', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _priceController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: 'e.g. 150',
              prefixText: 'kr ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Quantity & Submit
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                    ),
                    Text(
                      '$_quantity',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => setState(() => _quantity++),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: FilledButton(
                  onPressed: _isSaving ? null : _submit,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Collect Card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
