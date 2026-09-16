import '../models/card_models.dart';

abstract class PriceRepository {
  /// Get raw market pricing for a card.
  Future<RawPriceModel?> getRawPrice(String cardId);

  /// Get all graded market prices available for a card (all companies & grades).
  Future<List<GradedPriceModel>> getGradedPrices(String cardId);

  /// Get graded price for a specific company and grade (e.g. PSA 10).
  Future<GradedPriceModel?> getSpecificGradedPrice(
    String cardId,
    String gradingCompany,
    String grade,
  );

  /// Save raw price information.
  Future<void> upsertRawPrice(RawPriceModel price);

  /// Save graded price information.
  Future<void> upsertGradedPrices(List<GradedPriceModel> prices);
}
