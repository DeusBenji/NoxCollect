import '../models/card_models.dart';

abstract class CardRepository {
  /// Look up a card by its unique internal ID.
  Future<CardModel?> getCardById(String id);

  /// Find matching cards by exact or prefix card number (e.g. "151/165" or "151").
  Future<List<CardModel>> findCardsByNumber(String cardNumber);

  /// Search cards by query across name, number, set, or artist.
  Future<List<CardModel>> searchCards({
    String? query,
    String? setId,
    String? artist,
    int limit = 50,
  });

  /// Get all known cards for a specific set.
  Future<List<CardModel>> getCardsBySet(String setId);

  /// Get all known cards illustrated by a specific artist.
  Future<List<CardModel>> getCardsByArtist(String artistName);

  /// Get all sets.
  Future<List<SetModel>> getAllSets();

  /// Insert or replace cards in the local database (used by import script / seeder).
  Future<void> upsertCards(List<CardModel> cards);

  /// Insert or replace sets in the local database.
  Future<void> upsertSets(List<SetModel> sets);
}
