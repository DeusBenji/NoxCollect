import 'package:drift/drift.dart';

/// Sets table definition in SQLite via Drift.
class SetsTable extends Table {
  @override
  String get tableName => 'sets';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get localName =>
      text().nullable()(); // Native-script name (e.g. メガブレイブ)
  TextColumn get setCode =>
      text().nullable()(); // First-class set code (e.g. M1L, SVI)
  TextColumn get language =>
      text().withDefault(const Constant('en'))(); // ISO 639-1 (en, ja, etc.)
  TextColumn get region => text().withDefault(
    const Constant('US'),
  )(); // Market/region identity (e.g. US, JP)
  TextColumn get series => text().nullable()();
  TextColumn get releaseDate => text().nullable()();
  IntColumn get totalPrinted => integer().nullable()();
  TextColumn get symbolUrl => text().nullable()();
  TextColumn get logoUrl => text().nullable()();
  TextColumn get externalIds => text().nullable()(); // JSON string

  @override
  Set<Column> get primaryKey => {id};
}

/// Cards table definition with indexed card numbers and artist fields.
class CardsTable extends Table {
  @override
  String get tableName => 'cards';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get localName =>
      text().nullable()(); // Native-script name (e.g. メガルカリオex)
  TextColumn get cleanName => text()();
  TextColumn get language =>
      text().withDefault(const Constant('en'))(); // ISO 639-1 (en, ja, etc.)
  TextColumn get region => text().withDefault(
    const Constant('US'),
  )(); // Market/region identity (e.g. US, JP)
  TextColumn get cardNumber => text()();
  TextColumn get numberClean => text()();
  TextColumn get numberDenominator => text().nullable()();
  TextColumn get setId => text().references(SetsTable, #id)();
  TextColumn get setCode => text().nullable()();
  TextColumn get rarity => text().nullable()();
  TextColumn get supertype => text().nullable()();
  TextColumn get subtypes => text().nullable()(); // JSON string array
  TextColumn get types => text().nullable()(); // JSON string array
  TextColumn get hp => text().nullable()();
  TextColumn get artist => text().nullable()();
  TextColumn get artistClean => text().nullable()();
  TextColumn get imageUrlSmall => text().nullable()();
  TextColumn get imageUrlLarge => text().nullable()();
  TextColumn get externalIds => text().nullable()(); // JSON string

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {cardNumber, setId},
  ];
}

/// Raw / ungraded price table.
class RawPricesTable extends Table {
  @override
  String get tableName => 'raw_prices';

  TextColumn get cardId => text().references(CardsTable, #id)();
  RealColumn get marketPrice => real().nullable()();
  RealColumn get lowPrice => real().nullable()();
  RealColumn get midPrice => real().nullable()();
  RealColumn get highPrice => real().nullable()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  TextColumn get source => text().withDefault(const Constant('tcgplayer'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {cardId};
}

/// Normalized & extensible graded pricing table.
/// Supports arbitrary grading companies (PSA, CGC, BGS, SGC, etc.) and grades.
class GradedPricesTable extends Table {
  @override
  String get tableName => 'graded_prices';

  TextColumn get id => text()();
  TextColumn get cardId => text().references(CardsTable, #id)();
  TextColumn get gradingCompany => text()(); // 'PSA', 'CGC', 'BGS', etc.
  TextColumn get grade => text()(); // '10', '9.5', '9', '8', etc.
  RealColumn get marketPrice => real()();
  RealColumn get lowPrice => real().nullable()();
  RealColumn get highPrice => real().nullable()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  TextColumn get source =>
      text().withDefault(const Constant('pricecharting'))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {cardId, gradingCompany, grade},
  ];
}

/// User physical card inventory (source of truth for owned physical cards).
class UserCardsTable extends Table {
  @override
  String get tableName => 'user_cards';

  TextColumn get id => text()();
  TextColumn get userId => text().withDefault(const Constant('local_user'))();
  TextColumn get cardId => text().references(CardsTable, #id)();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  TextColumn get condition => text().withDefault(const Constant('raw'))();
  TextColumn get gradingCompany => text().nullable()();
  TextColumn get grade => text().nullable()();
  TextColumn get certNumber => text().nullable()();
  RealColumn get purchasePrice => real().nullable()();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Organizational collections table.
class CollectionsTable extends Table {
  @override
  String get tableName => 'collections';

  TextColumn get id => text()();
  TextColumn get userId => text().withDefault(const Constant('local_user'))();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get type =>
      text()(); // 'general', 'master_set', 'artist', 'pokemon', 'custom'
  TextColumn get targetSetId => text().nullable().references(SetsTable, #id)();
  TextColumn get targetArtist => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Junction table for collection membership.
class CollectionItemsTable extends Table {
  @override
  String get tableName => 'collection_items';

  TextColumn get id => text()();
  TextColumn get collectionId => text().references(CollectionsTable, #id)();
  TextColumn get userCardId => text().references(UserCardsTable, #id)();
  DateTimeColumn get addedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {collectionId, userCardId},
  ];
}
