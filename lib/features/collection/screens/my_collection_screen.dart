import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${card.setCode ?? "?"} • #${card.cardNumber}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 4,
            right: 4,
            child: Material(
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
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, WidgetRef ref, CardModel card) {
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
                  Text(
                    '${card.setCode ?? "?"} • #${card.cardNumber}',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (card.rarity != null) ...[
                        _Badge(text: card.rarity!, color: Colors.blue.shade100),
                        const SizedBox(width: 8),
                      ],
                      _Badge(text: userCard.condition.toUpperCase(), color: Colors.green.shade100),
                    ],
                  ),
                ],
              ),
            ),
            // Price & Quantity & Actions
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '0.00 kr',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
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
