import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../search/widgets/advanced_add_sheet.dart';

import '../../../core/providers.dart';
import '../../../domain/models/card_models.dart';

final isGridProvider = StateProvider<bool>((ref) => true);

class MyCollectionScreen extends ConsumerWidget {
  const MyCollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCardsAsync = ref.watch(userCardsStreamProvider);
    final isGrid = ref.watch(isGridProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              ref.read(isGridProvider.notifier).state = !isGrid;
            },
          ),
        ],
      ),
      body: userCardsAsync.when(
        data: (userCards) {
          if (userCards.isEmpty) {
            return const Center(
              child: Text(
                'Your collection is empty.\nScan some cards to get started!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          if (isGrid) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.71,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: userCards.length,
              itemBuilder: (context, index) {
                final userCard = userCards[index];
                return _CollectionCardItem(userCard: userCard, isGrid: true);
              },
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: userCards.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final userCard = userCards[index];
                return _CollectionCardItem(userCard: userCard, isGrid: false);
              },
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error loading collection: $err'),
        ),
      ),
    );
  }
}

class _CollectionCardItem extends ConsumerWidget {
  final UserCardModel userCard;
  final bool isGrid;

  const _CollectionCardItem({required this.userCard, required this.isGrid});

  void _showAdvancedAddSheet(BuildContext context, CardModel card) {
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

  Future<void> _decreaseQuantity(BuildContext context, WidgetRef ref) async {
    final inventoryRepo = ref.read(inventoryRepositoryProvider);
    
    // We get all physical records that match the cardId and condition to decrement correctly
    final allCards = await inventoryRepo.getUserCards();
    final matchingCards = allCards.where((c) => c.cardId == userCard.cardId && c.condition == userCard.condition).toList();
    
    if (matchingCards.isEmpty) return;
    
    // Remove one record or decrement its quantity
    final target = matchingCards.first;
    if (target.quantity > 1) {
      final updated = UserCardModel(
        id: target.id,
        userId: target.userId,
        cardId: target.cardId,
        quantity: target.quantity - 1,
        condition: target.condition,
        createdAt: target.createdAt,
        updatedAt: DateTime.now(),
      );
      await inventoryRepo.updateInventoryCard(updated);
    } else {
      await inventoryRepo.removeCardFromInventory(target.id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<CardModel?>(
      future: ref.read(cardRepositoryProvider).getCardById(userCard.cardId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Card(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final card = snapshot.data;
        if (card == null) {
          return Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Card missing\n(${userCard.cardId})',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _decreaseQuantity(context, ref),
                  )
                ],
              ),
            ),
          );
        }

        if (isGrid) {
          return _buildGridItem(context, ref, card);
        } else {
          return _buildListItem(context, ref, card);
        }
      },
    );
  }

  Widget _buildGridItem(BuildContext context, WidgetRef ref, CardModel card) {
    final conditionText = userCard.gradingCompany != null && userCard.grade != null
        ? '${userCard.gradingCompany} ${userCard.grade}'
        : (userCard.gradingCompany ?? userCard.condition).toUpperCase();
        
    final priceText = userCard.purchasePrice != null 
        ? '${userCard.purchasePrice!.toStringAsFixed(2)} kr' 
        : '0.00 kr';

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey.shade200,
                  child: card.imageUrlSmall != null
                      ? Image.network(
                          card.imageUrlSmall!,
                          fit: BoxFit.contain,
                          errorBuilder: (ctx, err, stack) => const Icon(
                            Icons.broken_image,
                            size: 48,
                            color: Colors.grey,
                          ),
                        )
                      : const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      card.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (card.setSymbolUrl != null) ...[
                          CachedNetworkImage(
                            imageUrl: card.setSymbolUrl!,
                            height: 14,
                            width: 14,
                            errorWidget: (c, u, e) => Text(
                              card.setCode ?? '?',
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ),
                          const SizedBox(width: 4),
                        ] else
                          Text(
                            '${card.setCode ?? "?"} • ',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                          ),
                        Expanded(
                          child: Text(
                            '#${card.cardNumber}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 4,
                            runSpacing: 4,
                            children: [
                              if (card.rarity != null)
                                _Badge(text: card.rarity!, color: Colors.blue.shade100),
                              _Badge(text: conditionText, color: Colors.green.shade100),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'x${userCard.quantity}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      priceText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 4,
            right: 4,
            child: Row(
              children: [
                Material(
                  color: Colors.blue.shade600,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => _showAdvancedAddSheet(context, card),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.add, size: 16, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Material(
                  color: Colors.black54,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => _decreaseQuantity(context, ref),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(Icons.remove, size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, WidgetRef ref, CardModel card) {
    final conditionText = userCard.gradingCompany != null && userCard.grade != null
        ? '${userCard.gradingCompany} ${userCard.grade}'
        : (userCard.gradingCompany ?? userCard.condition).toUpperCase();
        
    final priceText = userCard.purchasePrice != null 
        ? '${userCard.purchasePrice!.toStringAsFixed(2)} kr' 
        : '0.00 kr';

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60,
                height: 84,
                color: Colors.grey.shade200,
                child: card.imageUrlSmall != null
                    ? Image.network(
                        card.imageUrlSmall!,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, err, stack) => const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      )
                    : const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 12),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (card.setSymbolUrl != null) ...[
                        CachedNetworkImage(
                          imageUrl: card.setSymbolUrl!,
                          height: 14,
                          width: 14,
                          errorWidget: (c, u, e) => Text(
                            card.setCode ?? '?',
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                          ),
                        ),
                        const SizedBox(width: 4),
                      ] else
                        Text(
                          '${card.setCode ?? "?"} • ',
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                        ),
                      Text(
                        '#${card.cardNumber}',
                        style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (card.rarity != null) ...[
                        _Badge(text: card.rarity!, color: Colors.blue.shade100),
                        const SizedBox(width: 8),
                      ],
                      _Badge(text: conditionText, color: Colors.green.shade100),
                    ],
                  ),
                ],
              ),
            ),
            // Price & Quantity & Actions
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  priceText,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: Colors.blue),
                      onPressed: () => _showAdvancedAddSheet(context, card),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                      onPressed: () => _decreaseQuantity(context, ref),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'x${userCard.quantity}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }
}
