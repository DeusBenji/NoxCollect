import 'package:drift/drift.dart';

import '../../domain/models/card_models.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../database/app_database.dart';

class DriftInventoryRepository implements InventoryRepository {
  final AppDatabase _db;

  DriftInventoryRepository(this._db);

  @override
  Stream<List<UserCardModel>> watchUserCards({String userId = 'local_user'}) {
    final query = _db.select(_db.userCardsTable)
      ..where((tbl) => tbl.userId.equals(userId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);
      
    return query.watch().map((rows) {
      final models = rows.map(_mapRowToModel).toList();
      // Group by cardId + condition
      final grouped = <String, UserCardModel>{};
      for (final card in models) {
        final key = '${card.cardId}_${card.condition}';
        if (grouped.containsKey(key)) {
          final existing = grouped[key]!;
          grouped[key] = UserCardModel(
            id: existing.id,
            userId: existing.userId,
            cardId: existing.cardId,
            quantity: existing.quantity + card.quantity,
            condition: existing.condition,
            createdAt: existing.createdAt,
            updatedAt: existing.updatedAt,
          );
        } else {
          grouped[key] = card;
        }
      }
      return grouped.values.toList();
    });
  }

  @override
  Future<List<UserCardModel>> getUserCards({
    String userId = 'local_user',
  }) async {
    final query = _db.select(_db.userCardsTable)
      ..where((tbl) => tbl.userId.equals(userId))
      ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]);
    final rows = await query.get();
    return rows.map(_mapRowToModel).toList();
  }

  @override
  Future<void> addCardToInventory(UserCardModel userCard) async {
    await _db
        .into(_db.userCardsTable)
        .insert(
          UserCardsTableCompanion(
            id: Value(userCard.id),
            userId: Value(userCard.userId),
            cardId: Value(userCard.cardId),
            quantity: Value(userCard.quantity),
            condition: Value(userCard.condition),
            gradingCompany: Value(userCard.gradingCompany),
            grade: Value(userCard.grade),
            certNumber: Value(userCard.certNumber),
            purchasePrice: Value(userCard.purchasePrice),
            purchaseDate: Value(userCard.purchaseDate),
            notes: Value(userCard.notes),
            createdAt: Value(userCard.createdAt),
            updatedAt: Value(userCard.updatedAt),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Future<void> updateInventoryCard(UserCardModel userCard) async {
    await (_db.update(
      _db.userCardsTable,
    )..where((tbl) => tbl.id.equals(userCard.id))).write(
      UserCardsTableCompanion(
        quantity: Value(userCard.quantity),
        condition: Value(userCard.condition),
        gradingCompany: Value(userCard.gradingCompany),
        grade: Value(userCard.grade),
        certNumber: Value(userCard.certNumber),
        purchasePrice: Value(userCard.purchasePrice),
        purchaseDate: Value(userCard.purchaseDate),
        notes: Value(userCard.notes),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> removeCardFromInventory(String userCardId) async {
    await (_db.delete(
      _db.userCardsTable,
    )..where((tbl) => tbl.id.equals(userCardId))).go();
  }

  UserCardModel _mapRowToModel(UserCardsTableData row) {
    return UserCardModel(
      id: row.id,
      userId: row.userId,
      cardId: row.cardId,
      quantity: row.quantity,
      condition: row.condition,
      gradingCompany: row.gradingCompany,
      grade: row.grade,
      certNumber: row.certNumber,
      purchasePrice: row.purchasePrice,
      purchaseDate: row.purchaseDate,
      notes: row.notes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
