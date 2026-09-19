import 'dart:convert';

import 'package:drift/drift.dart';

import '../../domain/models/card_models.dart';
import '../../domain/repositories/card_repository.dart';
import '../database/app_database.dart';

class DriftCardRepository implements CardRepository {
  final AppDatabase _db;

  DriftCardRepository(this._db);

  @override
  Future<CardModel?> getCardById(String id) async {
    final query = _db.select(_db.cardsTable).join([
      leftOuterJoin(_db.setsTable, _db.setsTable.id.equalsExp(_db.cardsTable.setId)),
    ])..where(_db.cardsTable.id.equals(id));
    
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    
    final cardData = row.readTable(_db.cardsTable);
    final setData = row.readTableOrNull(_db.setsTable);
    
    final model = _mapCardRowToModel(cardData, setSymbolUrl: setData?.symbolUrl);
    return model;
  }

  @override
  Future<List<CardModel>> findCardsByNumber(String cardNumber) async {
    final cleanNum = _cleanCardNumber(cardNumber);
    final query = _db.select(_db.cardsTable)
      ..where(
        (tbl) =>
            tbl.cardNumber.equals(cardNumber) |
            tbl.numberClean.equals(cleanNum) |
            tbl.cardNumber.like('%$cardNumber%'),
      );
    final rows = await query.get();
    return rows.map(_mapCardRowToModel).toList();
  }

  @override
  Future<List<CardModel>> searchCards({
    String? query,
    String? setId,
    String? artist,
    int limit = 50,
  }) async {
    final select = _db.select(_db.cardsTable);
    if (setId != null && setId.isNotEmpty) {
      select.where((tbl) => tbl.setId.equals(setId));
    }
    if (artist != null && artist.isNotEmpty) {
      final cleanArtist = _cleanSearchTerm(artist);
      select.where((tbl) => tbl.artistClean.like('%$cleanArtist%'));
    }
    if (query != null && query.trim().isNotEmpty) {
      final cleanQ = _cleanSearchTerm(query);
      select.where(
        (tbl) =>
            tbl.cleanName.like('%$cleanQ%') |
            tbl.numberClean.equals(cleanQ) |
            tbl.cardNumber.like('%$query%'),
      );
    }
    select.limit(limit);
    final rows = await select.get();
    return rows.map(_mapCardRowToModel).toList();
  }

  @override
  Future<List<CardModel>> getCardsBySet(String setId) async {
    final query = _db.select(_db.cardsTable)
      ..where((tbl) => tbl.setId.equals(setId));
    final rows = await query.get();
    return rows.map(_mapCardRowToModel).toList();
  }

  @override
  Future<List<CardModel>> getCardsByArtist(String artistName) async {
    final cleanArtist = _cleanSearchTerm(artistName);
    final query = _db.select(_db.cardsTable)
      ..where((tbl) => tbl.artistClean.like('%$cleanArtist%'));
    final rows = await query.get();
    return rows.map(_mapCardRowToModel).toList();
  }

  @override
  Future<List<SetModel>> getAllSets() async {
    final rows = await _db.select(_db.setsTable).get();
    return rows.map(_mapSetRowToModel).toList();
  }

  @override
  Future<void> upsertCards(List<CardModel> cards) async {
    await _db.batch((batch) {
      for (final card in cards) {
        batch.insert(
          _db.cardsTable,
          CardsTableCompanion(
            id: Value(card.id),
            name: Value(card.name),
            localName: Value(card.localName),
            cleanName: Value(card.cleanName),
            language: Value(card.language),
            region: Value(card.region),
            cardNumber: Value(card.cardNumber),
            numberClean: Value(card.numberClean),
            numberDenominator: Value(card.numberDenominator),
            setId: Value(card.setId),
            setCode: Value(card.setCode),
            rarity: Value(card.rarity),
            supertype: Value(card.supertype),
            subtypes: Value(jsonEncode(card.subtypes)),
            types: Value(jsonEncode(card.types)),
            hp: Value(card.hp),
            artist: Value(card.artist),
            artistClean: Value(card.artistClean),
            imageUrlSmall: Value(card.imageUrlSmall),
            imageUrlLarge: Value(card.imageUrlLarge),
            externalIds: Value(jsonEncode(card.externalIds)),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  @override
  Future<void> upsertSets(List<SetModel> sets) async {
    await _db.batch((batch) {
      for (final s in sets) {
        batch.insert(
          _db.setsTable,
          SetsTableCompanion(
            id: Value(s.id),
            name: Value(s.name),
            localName: Value(s.localName),
            setCode: Value(s.setCode),
            language: Value(s.language),
            region: Value(s.region),
            series: Value(s.series),
            releaseDate: Value(s.releaseDate),
            totalPrinted: Value(s.totalPrinted),
            symbolUrl: Value(s.symbolUrl),
            logoUrl: Value(s.logoUrl),
            externalIds: Value(jsonEncode(s.externalIds)),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  // Helper mappings
  CardModel _mapCardRowToModel(CardsTableData row, {String? setSymbolUrl}) {
    List<String> subtypes = [];
    List<String> types = [];
    Map<String, dynamic> externalIds = {};

    try {
      if (row.subtypes != null) {
        subtypes = List<String>.from(jsonDecode(row.subtypes!));
      }
      if (row.types != null) {
        types = List<String>.from(jsonDecode(row.types!));
      }
      if (row.externalIds != null) {
        externalIds = Map<String, dynamic>.from(jsonDecode(row.externalIds!));
      }
    } catch (_) {}

    return CardModel(
      id: row.id,
      name: row.name,
      localName: row.localName,
      cleanName: row.cleanName,
      language: row.language,
      region: row.region,
      cardNumber: row.cardNumber,
      numberClean: row.numberClean,
      numberDenominator: row.numberDenominator,
      setId: row.setId,
      setCode: row.setCode,
      setSymbolUrl: setSymbolUrl,
      rarity: row.rarity,
      supertype: row.supertype,
      subtypes: subtypes,
      types: types,
      hp: row.hp,
      artist: row.artist,
      artistClean: row.artistClean,
      imageUrlSmall: row.imageUrlSmall,
      imageUrlLarge: row.imageUrlLarge,
      externalIds: externalIds,
    );
  }

  SetModel _mapSetRowToModel(SetsTableData row) {
    Map<String, dynamic> externalIds = {};
    try {
      if (row.externalIds != null) {
        externalIds = Map<String, dynamic>.from(jsonDecode(row.externalIds!));
      }
    } catch (_) {}

    return SetModel(
      id: row.id,
      name: row.name,
      localName: row.localName,
      setCode: row.setCode,
      language: row.language,
      region: row.region,
      series: row.series,
      releaseDate: row.releaseDate,
      totalPrinted: row.totalPrinted,
      symbolUrl: row.symbolUrl,
      logoUrl: row.logoUrl,
      externalIds: externalIds,
    );
  }

  static String _cleanCardNumber(String input) {
    final numerator = input.split('/').first;
    return numerator.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
  }

  static String _cleanSearchTerm(String input) {
    return input.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
  }
}
