import '../models/card_models.dart';

abstract class InventoryRepository {
  /// Stream all owned cards for a user.
  Stream<List<UserCardModel>> watchUserCards({String userId = 'local_user'});

  /// Fetch all owned cards for a user.
  Future<List<UserCardModel>> getUserCards({String userId = 'local_user'});

  /// Add a physical card to inventory.
  Future<void> addCardToInventory(UserCardModel userCard);

  /// Update an inventory entry (quantity, grade, notes, etc.).
  Future<void> updateInventoryCard(UserCardModel userCard);

  /// Remove a card from inventory.
  Future<void> removeCardFromInventory(String userCardId);
}
