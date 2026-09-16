import 'package:drift/drift.dart';

import '../../domain/models/card_models.dart';
import '../../domain/repositories/price_repository.dart';
import '../database/app_database.dart';

class DriftPriceRepository implements PriceRepository {
  final AppDatabase _db;

  DriftPriceRepository(this._db);

  @override
  Future<RawPriceModel?> getRawPrice(String cardId) async {
    final query = _db.select(_db.rawPricesTable)
      ..where((tbl) => tbl.cardId.equals(cardId));
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return RawPriceModel(
      cardId: row.cardId,
      marketPrice: row.marketPrice,
      lowPrice: row.lowPrice,
      midPrice: row.midPrice,
      highPrice: row.highPrice,
      currency: row.currency,
      source: row.source,
      updatedAt: row.updatedAt,
    );
  }

  @override
  Future<List<GradedPriceModel>> getGradedPrices(String cardId) async {
    final query = _db.select(_db.gradedPricesTable)
      ..where((tbl) => tbl.cardId.equals(cardId));
    final rows = await query.get();
    return rows
        .map(
          (r) => GradedPriceModel(
            id: r.id,
            cardId: r.cardId,
            gradingCompany: r.gradingCompany,
            grade: r.grade,
            marketPrice: r.marketPrice,
            lowPrice: r.lowPrice,
            highPrice: r.highPrice,
            currency: r.currency,
            source: r.source,
            updatedAt: r.updatedAt,
          ),
        )
        .toList();
  }

  @override
  Future<GradedPriceModel?> getSpecificGradedPrice(
    String cardId,
    String gradingCompany,
    String grade,
  ) async {
    final query = _db.select(_db.gradedPricesTable)
      ..where(
        (tbl) =>
            tbl.cardId.equals(cardId) &
            tbl.gradingCompany.equals(gradingCompany) &
            tbl.grade.equals(grade),
      );
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return GradedPriceModel(
      id: row.id,
      cardId: row.cardId,
      gradingCompany: row.gradingCompany,
      grade: row.grade,
      marketPrice: row.marketPrice,
      lowPrice: row.lowPrice,
      highPrice: row.highPrice,
      currency: row.currency,
      source: row.source,
      updatedAt: row.updatedAt,
    );
  }

  @override
  Future<void> upsertRawPrice(RawPriceModel price) async {
    await _db
        .into(_db.rawPricesTable)
        .insert(
          RawPricesTableCompanion(
            cardId: Value(price.cardId),
            marketPrice: Value(price.marketPrice),
            lowPrice: Value(price.lowPrice),
            midPrice: Value(price.midPrice),
            highPrice: Value(price.highPrice),
            currency: Value(price.currency),
            source: Value(price.source),
            updatedAt: Value(price.updatedAt),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Future<void> upsertGradedPrices(List<GradedPriceModel> prices) async {
    await _db.batch((batch) {
      for (final p in prices) {
        batch.insert(
          _db.gradedPricesTable,
          GradedPricesTableCompanion(
            id: Value(p.id),
            cardId: Value(p.cardId),
            gradingCompany: Value(p.gradingCompany),
            grade: Value(p.grade),
            marketPrice: Value(p.marketPrice),
            lowPrice: Value(p.lowPrice),
            highPrice: Value(p.highPrice),
            currency: Value(p.currency),
            source: Value(p.source),
            updatedAt: Value(p.updatedAt),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }
}
