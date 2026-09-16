import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    SetsTable,
    CardsTable,
    RawPricesTable,
    GradedPricesTable,
    UserCardsTable,
    CollectionsTable,
    CollectionItemsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      // Create custom indices for rapid card scanning queries
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_cards_number ON cards(card_number);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_cards_number_clean ON cards(number_clean);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_cards_clean_name ON cards(clean_name);',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_cards_artist ON cards(artist_clean);',
      );
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // FUTURE MIGRATIONS: Must use non-destructive Drift migrations
      // (like m.addColumn) to preserve user collection data.
      if (from < 2) {
        // Add multilingual & regional columns to SetsTable
        await m.addColumn(setsTable, setsTable.localName);
        await m.addColumn(setsTable, setsTable.setCode);
        await m.addColumn(setsTable, setsTable.language);
        await m.addColumn(setsTable, setsTable.region);

        // Add multilingual & regional columns to CardsTable
        await m.addColumn(cardsTable, cardsTable.localName);
        await m.addColumn(cardsTable, cardsTable.language);
        await m.addColumn(cardsTable, cardsTable.region);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'noxcollect.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
