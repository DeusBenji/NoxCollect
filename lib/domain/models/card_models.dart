/// Domain model representing a Pokémon card set.
/// Note: language and region are intentionally separate concepts.
/// For example, language='en' does not inherently imply region='US'.
class SetModel {
  final String id;
  final String name;
  final String? localName; // Native-script name (e.g. メガブレイブ)
  final String? setCode; // First-class set code (e.g. M1L, SVI)
  final String language; // ISO 639-1 (en, ja, etc.)
  final String region; // Market/region identity (e.g. US, JP)
  final String? series;
  final String? releaseDate;
  final int? totalPrinted;
  final String? symbolUrl;
  final String? logoUrl;
  final Map<String, dynamic> externalIds;

  const SetModel({
    required this.id,
    required this.name,
    this.localName,
    this.setCode,
    this.language = 'en',
    this.region = 'US',
    this.series,
    this.releaseDate,
    this.totalPrinted,
    this.symbolUrl,
    this.logoUrl,
    this.externalIds = const {},
  });
}

/// Domain model representing a Pokémon card.
class CardModel {
  final String id;
  final String name;
  final String? localName; // Native-script name (e.g. メガルカリオex)
  final String cleanName;
  final String language; // ISO 639-1 (en, ja, etc.)
  final String region; // Market/region identity (e.g. US, JP)
  final String cardNumber;
  final String numberClean;
  final String? numberDenominator;
  final String setId;
  final String? setCode;
  final String? rarity;
  final String? supertype;
  final List<String> subtypes;
  final List<String> types;
  final String? hp;
  final String? artist;
  final String? artistClean;
  final String? imageUrlSmall;
  final String? imageUrlLarge;
  final Map<String, dynamic> externalIds;

  const CardModel({
    required this.id,
    required this.name,
    this.localName,
    required this.cleanName,
    this.language = 'en',
    this.region = 'US',
    required this.cardNumber,
    required this.numberClean,
    this.numberDenominator,
    required this.setId,
    this.setCode,
    this.rarity,
    this.supertype,
    this.subtypes = const [],
    this.types = const [],
    this.hp,
    this.artist,
    this.artistClean,
    this.imageUrlSmall,
    this.imageUrlLarge,
    this.externalIds = const {},
  });
}

/// Domain model for raw / ungraded market pricing.
class RawPriceModel {
  final String cardId;
  final double? marketPrice;
  final double? lowPrice;
  final double? midPrice;
  final double? highPrice;
  final String currency;
  final String source;
  final DateTime updatedAt;

  const RawPriceModel({
    required this.cardId,
    this.marketPrice,
    this.lowPrice,
    this.midPrice,
    this.highPrice,
    this.currency = 'USD',
    this.source = 'tcgplayer',
    required this.updatedAt,
  });
}

/// Domain model for normalized & extensible graded pricing.
/// Supports arbitrary grading companies (PSA, CGC, BGS, SGC, etc.) and grades.
class GradedPriceModel {
  final String id;
  final String cardId;
  final String gradingCompany;
  final String grade;
  final double marketPrice;
  final double? lowPrice;
  final double? highPrice;
  final String currency;
  final String source;
  final DateTime updatedAt;

  const GradedPriceModel({
    required this.id,
    required this.cardId,
    required this.gradingCompany,
    required this.grade,
    required this.marketPrice,
    this.lowPrice,
    this.highPrice,
    this.currency = 'USD',
    this.source = 'pricecharting',
    required this.updatedAt,
  });
}

/// Domain model representing a physical card owned by the user (source of truth).
class UserCardModel {
  final String id;
  final String userId;
  final String cardId;
  final int quantity;
  final String condition; // 'raw' or 'graded'
  final String? gradingCompany; // 'PSA', 'CGC', 'BGS', etc.
  final String? grade; // '10', '9.5', '9', etc.
  final String? certNumber;
  final double? purchasePrice;
  final DateTime? purchaseDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserCardModel({
    required this.id,
    this.userId = 'local_user',
    required this.cardId,
    this.quantity = 1,
    this.condition = 'raw',
    this.gradingCompany,
    this.grade,
    this.certNumber,
    this.purchasePrice,
    this.purchaseDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isGraded => condition.toLowerCase() == 'graded';
}
