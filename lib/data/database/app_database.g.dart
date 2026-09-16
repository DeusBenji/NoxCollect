// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SetsTableTable extends SetsTable
    with TableInfo<$SetsTableTable, SetsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localNameMeta = const VerificationMeta(
    'localName',
  );
  @override
  late final GeneratedColumn<String> localName = GeneratedColumn<String>(
    'local_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _setCodeMeta = const VerificationMeta(
    'setCode',
  );
  @override
  late final GeneratedColumn<String> setCode = GeneratedColumn<String>(
    'set_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('US'),
  );
  static const VerificationMeta _seriesMeta = const VerificationMeta('series');
  @override
  late final GeneratedColumn<String> series = GeneratedColumn<String>(
    'series',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _releaseDateMeta = const VerificationMeta(
    'releaseDate',
  );
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
    'release_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPrintedMeta = const VerificationMeta(
    'totalPrinted',
  );
  @override
  late final GeneratedColumn<int> totalPrinted = GeneratedColumn<int>(
    'total_printed',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _symbolUrlMeta = const VerificationMeta(
    'symbolUrl',
  );
  @override
  late final GeneratedColumn<String> symbolUrl = GeneratedColumn<String>(
    'symbol_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _logoUrlMeta = const VerificationMeta(
    'logoUrl',
  );
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
    'logo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _externalIdsMeta = const VerificationMeta(
    'externalIds',
  );
  @override
  late final GeneratedColumn<String> externalIds = GeneratedColumn<String>(
    'external_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    localName,
    setCode,
    language,
    region,
    series,
    releaseDate,
    totalPrinted,
    symbolUrl,
    logoUrl,
    externalIds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<SetsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('local_name')) {
      context.handle(
        _localNameMeta,
        localName.isAcceptableOrUnknown(data['local_name']!, _localNameMeta),
      );
    }
    if (data.containsKey('set_code')) {
      context.handle(
        _setCodeMeta,
        setCode.isAcceptableOrUnknown(data['set_code']!, _setCodeMeta),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('series')) {
      context.handle(
        _seriesMeta,
        series.isAcceptableOrUnknown(data['series']!, _seriesMeta),
      );
    }
    if (data.containsKey('release_date')) {
      context.handle(
        _releaseDateMeta,
        releaseDate.isAcceptableOrUnknown(
          data['release_date']!,
          _releaseDateMeta,
        ),
      );
    }
    if (data.containsKey('total_printed')) {
      context.handle(
        _totalPrintedMeta,
        totalPrinted.isAcceptableOrUnknown(
          data['total_printed']!,
          _totalPrintedMeta,
        ),
      );
    }
    if (data.containsKey('symbol_url')) {
      context.handle(
        _symbolUrlMeta,
        symbolUrl.isAcceptableOrUnknown(data['symbol_url']!, _symbolUrlMeta),
      );
    }
    if (data.containsKey('logo_url')) {
      context.handle(
        _logoUrlMeta,
        logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta),
      );
    }
    if (data.containsKey('external_ids')) {
      context.handle(
        _externalIdsMeta,
        externalIds.isAcceptableOrUnknown(
          data['external_ids']!,
          _externalIdsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SetsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      localName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_name'],
      ),
      setCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_code'],
      ),
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      )!,
      series: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}series'],
      ),
      releaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}release_date'],
      ),
      totalPrinted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_printed'],
      ),
      symbolUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symbol_url'],
      ),
      logoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_url'],
      ),
      externalIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_ids'],
      ),
    );
  }

  @override
  $SetsTableTable createAlias(String alias) {
    return $SetsTableTable(attachedDatabase, alias);
  }
}

class SetsTableData extends DataClass implements Insertable<SetsTableData> {
  final String id;
  final String name;
  final String? localName;
  final String? setCode;
  final String language;
  final String region;
  final String? series;
  final String? releaseDate;
  final int? totalPrinted;
  final String? symbolUrl;
  final String? logoUrl;
  final String? externalIds;
  const SetsTableData({
    required this.id,
    required this.name,
    this.localName,
    this.setCode,
    required this.language,
    required this.region,
    this.series,
    this.releaseDate,
    this.totalPrinted,
    this.symbolUrl,
    this.logoUrl,
    this.externalIds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || localName != null) {
      map['local_name'] = Variable<String>(localName);
    }
    if (!nullToAbsent || setCode != null) {
      map['set_code'] = Variable<String>(setCode);
    }
    map['language'] = Variable<String>(language);
    map['region'] = Variable<String>(region);
    if (!nullToAbsent || series != null) {
      map['series'] = Variable<String>(series);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String>(releaseDate);
    }
    if (!nullToAbsent || totalPrinted != null) {
      map['total_printed'] = Variable<int>(totalPrinted);
    }
    if (!nullToAbsent || symbolUrl != null) {
      map['symbol_url'] = Variable<String>(symbolUrl);
    }
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || externalIds != null) {
      map['external_ids'] = Variable<String>(externalIds);
    }
    return map;
  }

  SetsTableCompanion toCompanion(bool nullToAbsent) {
    return SetsTableCompanion(
      id: Value(id),
      name: Value(name),
      localName: localName == null && nullToAbsent
          ? const Value.absent()
          : Value(localName),
      setCode: setCode == null && nullToAbsent
          ? const Value.absent()
          : Value(setCode),
      language: Value(language),
      region: Value(region),
      series: series == null && nullToAbsent
          ? const Value.absent()
          : Value(series),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      totalPrinted: totalPrinted == null && nullToAbsent
          ? const Value.absent()
          : Value(totalPrinted),
      symbolUrl: symbolUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(symbolUrl),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      externalIds: externalIds == null && nullToAbsent
          ? const Value.absent()
          : Value(externalIds),
    );
  }

  factory SetsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      localName: serializer.fromJson<String?>(json['localName']),
      setCode: serializer.fromJson<String?>(json['setCode']),
      language: serializer.fromJson<String>(json['language']),
      region: serializer.fromJson<String>(json['region']),
      series: serializer.fromJson<String?>(json['series']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      totalPrinted: serializer.fromJson<int?>(json['totalPrinted']),
      symbolUrl: serializer.fromJson<String?>(json['symbolUrl']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      externalIds: serializer.fromJson<String?>(json['externalIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'localName': serializer.toJson<String?>(localName),
      'setCode': serializer.toJson<String?>(setCode),
      'language': serializer.toJson<String>(language),
      'region': serializer.toJson<String>(region),
      'series': serializer.toJson<String?>(series),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'totalPrinted': serializer.toJson<int?>(totalPrinted),
      'symbolUrl': serializer.toJson<String?>(symbolUrl),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'externalIds': serializer.toJson<String?>(externalIds),
    };
  }

  SetsTableData copyWith({
    String? id,
    String? name,
    Value<String?> localName = const Value.absent(),
    Value<String?> setCode = const Value.absent(),
    String? language,
    String? region,
    Value<String?> series = const Value.absent(),
    Value<String?> releaseDate = const Value.absent(),
    Value<int?> totalPrinted = const Value.absent(),
    Value<String?> symbolUrl = const Value.absent(),
    Value<String?> logoUrl = const Value.absent(),
    Value<String?> externalIds = const Value.absent(),
  }) => SetsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    localName: localName.present ? localName.value : this.localName,
    setCode: setCode.present ? setCode.value : this.setCode,
    language: language ?? this.language,
    region: region ?? this.region,
    series: series.present ? series.value : this.series,
    releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
    totalPrinted: totalPrinted.present ? totalPrinted.value : this.totalPrinted,
    symbolUrl: symbolUrl.present ? symbolUrl.value : this.symbolUrl,
    logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
    externalIds: externalIds.present ? externalIds.value : this.externalIds,
  );
  SetsTableData copyWithCompanion(SetsTableCompanion data) {
    return SetsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      localName: data.localName.present ? data.localName.value : this.localName,
      setCode: data.setCode.present ? data.setCode.value : this.setCode,
      language: data.language.present ? data.language.value : this.language,
      region: data.region.present ? data.region.value : this.region,
      series: data.series.present ? data.series.value : this.series,
      releaseDate: data.releaseDate.present
          ? data.releaseDate.value
          : this.releaseDate,
      totalPrinted: data.totalPrinted.present
          ? data.totalPrinted.value
          : this.totalPrinted,
      symbolUrl: data.symbolUrl.present ? data.symbolUrl.value : this.symbolUrl,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      externalIds: data.externalIds.present
          ? data.externalIds.value
          : this.externalIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('localName: $localName, ')
          ..write('setCode: $setCode, ')
          ..write('language: $language, ')
          ..write('region: $region, ')
          ..write('series: $series, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('totalPrinted: $totalPrinted, ')
          ..write('symbolUrl: $symbolUrl, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('externalIds: $externalIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    localName,
    setCode,
    language,
    region,
    series,
    releaseDate,
    totalPrinted,
    symbolUrl,
    logoUrl,
    externalIds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.localName == this.localName &&
          other.setCode == this.setCode &&
          other.language == this.language &&
          other.region == this.region &&
          other.series == this.series &&
          other.releaseDate == this.releaseDate &&
          other.totalPrinted == this.totalPrinted &&
          other.symbolUrl == this.symbolUrl &&
          other.logoUrl == this.logoUrl &&
          other.externalIds == this.externalIds);
}

class SetsTableCompanion extends UpdateCompanion<SetsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> localName;
  final Value<String?> setCode;
  final Value<String> language;
  final Value<String> region;
  final Value<String?> series;
  final Value<String?> releaseDate;
  final Value<int?> totalPrinted;
  final Value<String?> symbolUrl;
  final Value<String?> logoUrl;
  final Value<String?> externalIds;
  final Value<int> rowid;
  const SetsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.localName = const Value.absent(),
    this.setCode = const Value.absent(),
    this.language = const Value.absent(),
    this.region = const Value.absent(),
    this.series = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.totalPrinted = const Value.absent(),
    this.symbolUrl = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.externalIds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetsTableCompanion.insert({
    required String id,
    required String name,
    this.localName = const Value.absent(),
    this.setCode = const Value.absent(),
    this.language = const Value.absent(),
    this.region = const Value.absent(),
    this.series = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.totalPrinted = const Value.absent(),
    this.symbolUrl = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.externalIds = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<SetsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? localName,
    Expression<String>? setCode,
    Expression<String>? language,
    Expression<String>? region,
    Expression<String>? series,
    Expression<String>? releaseDate,
    Expression<int>? totalPrinted,
    Expression<String>? symbolUrl,
    Expression<String>? logoUrl,
    Expression<String>? externalIds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (localName != null) 'local_name': localName,
      if (setCode != null) 'set_code': setCode,
      if (language != null) 'language': language,
      if (region != null) 'region': region,
      if (series != null) 'series': series,
      if (releaseDate != null) 'release_date': releaseDate,
      if (totalPrinted != null) 'total_printed': totalPrinted,
      if (symbolUrl != null) 'symbol_url': symbolUrl,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (externalIds != null) 'external_ids': externalIds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? localName,
    Value<String?>? setCode,
    Value<String>? language,
    Value<String>? region,
    Value<String?>? series,
    Value<String?>? releaseDate,
    Value<int?>? totalPrinted,
    Value<String?>? symbolUrl,
    Value<String?>? logoUrl,
    Value<String?>? externalIds,
    Value<int>? rowid,
  }) {
    return SetsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      localName: localName ?? this.localName,
      setCode: setCode ?? this.setCode,
      language: language ?? this.language,
      region: region ?? this.region,
      series: series ?? this.series,
      releaseDate: releaseDate ?? this.releaseDate,
      totalPrinted: totalPrinted ?? this.totalPrinted,
      symbolUrl: symbolUrl ?? this.symbolUrl,
      logoUrl: logoUrl ?? this.logoUrl,
      externalIds: externalIds ?? this.externalIds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (localName.present) {
      map['local_name'] = Variable<String>(localName.value);
    }
    if (setCode.present) {
      map['set_code'] = Variable<String>(setCode.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (series.present) {
      map['series'] = Variable<String>(series.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (totalPrinted.present) {
      map['total_printed'] = Variable<int>(totalPrinted.value);
    }
    if (symbolUrl.present) {
      map['symbol_url'] = Variable<String>(symbolUrl.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (externalIds.present) {
      map['external_ids'] = Variable<String>(externalIds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('localName: $localName, ')
          ..write('setCode: $setCode, ')
          ..write('language: $language, ')
          ..write('region: $region, ')
          ..write('series: $series, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('totalPrinted: $totalPrinted, ')
          ..write('symbolUrl: $symbolUrl, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('externalIds: $externalIds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CardsTableTable extends CardsTable
    with TableInfo<$CardsTableTable, CardsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CardsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localNameMeta = const VerificationMeta(
    'localName',
  );
  @override
  late final GeneratedColumn<String> localName = GeneratedColumn<String>(
    'local_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cleanNameMeta = const VerificationMeta(
    'cleanName',
  );
  @override
  late final GeneratedColumn<String> cleanName = GeneratedColumn<String>(
    'clean_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('US'),
  );
  static const VerificationMeta _cardNumberMeta = const VerificationMeta(
    'cardNumber',
  );
  @override
  late final GeneratedColumn<String> cardNumber = GeneratedColumn<String>(
    'card_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberCleanMeta = const VerificationMeta(
    'numberClean',
  );
  @override
  late final GeneratedColumn<String> numberClean = GeneratedColumn<String>(
    'number_clean',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberDenominatorMeta = const VerificationMeta(
    'numberDenominator',
  );
  @override
  late final GeneratedColumn<String> numberDenominator =
      GeneratedColumn<String>(
        'number_denominator',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _setIdMeta = const VerificationMeta('setId');
  @override
  late final GeneratedColumn<String> setId = GeneratedColumn<String>(
    'set_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sets (id)',
    ),
  );
  static const VerificationMeta _setCodeMeta = const VerificationMeta(
    'setCode',
  );
  @override
  late final GeneratedColumn<String> setCode = GeneratedColumn<String>(
    'set_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rarityMeta = const VerificationMeta('rarity');
  @override
  late final GeneratedColumn<String> rarity = GeneratedColumn<String>(
    'rarity',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supertypeMeta = const VerificationMeta(
    'supertype',
  );
  @override
  late final GeneratedColumn<String> supertype = GeneratedColumn<String>(
    'supertype',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtypesMeta = const VerificationMeta(
    'subtypes',
  );
  @override
  late final GeneratedColumn<String> subtypes = GeneratedColumn<String>(
    'subtypes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typesMeta = const VerificationMeta('types');
  @override
  late final GeneratedColumn<String> types = GeneratedColumn<String>(
    'types',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hpMeta = const VerificationMeta('hp');
  @override
  late final GeneratedColumn<String> hp = GeneratedColumn<String>(
    'hp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artistMeta = const VerificationMeta('artist');
  @override
  late final GeneratedColumn<String> artist = GeneratedColumn<String>(
    'artist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _artistCleanMeta = const VerificationMeta(
    'artistClean',
  );
  @override
  late final GeneratedColumn<String> artistClean = GeneratedColumn<String>(
    'artist_clean',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlSmallMeta = const VerificationMeta(
    'imageUrlSmall',
  );
  @override
  late final GeneratedColumn<String> imageUrlSmall = GeneratedColumn<String>(
    'image_url_small',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlLargeMeta = const VerificationMeta(
    'imageUrlLarge',
  );
  @override
  late final GeneratedColumn<String> imageUrlLarge = GeneratedColumn<String>(
    'image_url_large',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _externalIdsMeta = const VerificationMeta(
    'externalIds',
  );
  @override
  late final GeneratedColumn<String> externalIds = GeneratedColumn<String>(
    'external_ids',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    localName,
    cleanName,
    language,
    region,
    cardNumber,
    numberClean,
    numberDenominator,
    setId,
    setCode,
    rarity,
    supertype,
    subtypes,
    types,
    hp,
    artist,
    artistClean,
    imageUrlSmall,
    imageUrlLarge,
    externalIds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<CardsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('local_name')) {
      context.handle(
        _localNameMeta,
        localName.isAcceptableOrUnknown(data['local_name']!, _localNameMeta),
      );
    }
    if (data.containsKey('clean_name')) {
      context.handle(
        _cleanNameMeta,
        cleanName.isAcceptableOrUnknown(data['clean_name']!, _cleanNameMeta),
      );
    } else if (isInserting) {
      context.missing(_cleanNameMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('card_number')) {
      context.handle(
        _cardNumberMeta,
        cardNumber.isAcceptableOrUnknown(data['card_number']!, _cardNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_cardNumberMeta);
    }
    if (data.containsKey('number_clean')) {
      context.handle(
        _numberCleanMeta,
        numberClean.isAcceptableOrUnknown(
          data['number_clean']!,
          _numberCleanMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numberCleanMeta);
    }
    if (data.containsKey('number_denominator')) {
      context.handle(
        _numberDenominatorMeta,
        numberDenominator.isAcceptableOrUnknown(
          data['number_denominator']!,
          _numberDenominatorMeta,
        ),
      );
    }
    if (data.containsKey('set_id')) {
      context.handle(
        _setIdMeta,
        setId.isAcceptableOrUnknown(data['set_id']!, _setIdMeta),
      );
    } else if (isInserting) {
      context.missing(_setIdMeta);
    }
    if (data.containsKey('set_code')) {
      context.handle(
        _setCodeMeta,
        setCode.isAcceptableOrUnknown(data['set_code']!, _setCodeMeta),
      );
    }
    if (data.containsKey('rarity')) {
      context.handle(
        _rarityMeta,
        rarity.isAcceptableOrUnknown(data['rarity']!, _rarityMeta),
      );
    }
    if (data.containsKey('supertype')) {
      context.handle(
        _supertypeMeta,
        supertype.isAcceptableOrUnknown(data['supertype']!, _supertypeMeta),
      );
    }
    if (data.containsKey('subtypes')) {
      context.handle(
        _subtypesMeta,
        subtypes.isAcceptableOrUnknown(data['subtypes']!, _subtypesMeta),
      );
    }
    if (data.containsKey('types')) {
      context.handle(
        _typesMeta,
        types.isAcceptableOrUnknown(data['types']!, _typesMeta),
      );
    }
    if (data.containsKey('hp')) {
      context.handle(_hpMeta, hp.isAcceptableOrUnknown(data['hp']!, _hpMeta));
    }
    if (data.containsKey('artist')) {
      context.handle(
        _artistMeta,
        artist.isAcceptableOrUnknown(data['artist']!, _artistMeta),
      );
    }
    if (data.containsKey('artist_clean')) {
      context.handle(
        _artistCleanMeta,
        artistClean.isAcceptableOrUnknown(
          data['artist_clean']!,
          _artistCleanMeta,
        ),
      );
    }
    if (data.containsKey('image_url_small')) {
      context.handle(
        _imageUrlSmallMeta,
        imageUrlSmall.isAcceptableOrUnknown(
          data['image_url_small']!,
          _imageUrlSmallMeta,
        ),
      );
    }
    if (data.containsKey('image_url_large')) {
      context.handle(
        _imageUrlLargeMeta,
        imageUrlLarge.isAcceptableOrUnknown(
          data['image_url_large']!,
          _imageUrlLargeMeta,
        ),
      );
    }
    if (data.containsKey('external_ids')) {
      context.handle(
        _externalIdsMeta,
        externalIds.isAcceptableOrUnknown(
          data['external_ids']!,
          _externalIdsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {cardNumber, setId},
  ];
  @override
  CardsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CardsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      localName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_name'],
      ),
      cleanName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clean_name'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      )!,
      cardNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_number'],
      )!,
      numberClean: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number_clean'],
      )!,
      numberDenominator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number_denominator'],
      ),
      setId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_id'],
      )!,
      setCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_code'],
      ),
      rarity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rarity'],
      ),
      supertype: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supertype'],
      ),
      subtypes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtypes'],
      ),
      types: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}types'],
      ),
      hp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hp'],
      ),
      artist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist'],
      ),
      artistClean: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}artist_clean'],
      ),
      imageUrlSmall: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url_small'],
      ),
      imageUrlLarge: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url_large'],
      ),
      externalIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_ids'],
      ),
    );
  }

  @override
  $CardsTableTable createAlias(String alias) {
    return $CardsTableTable(attachedDatabase, alias);
  }
}

class CardsTableData extends DataClass implements Insertable<CardsTableData> {
  final String id;
  final String name;
  final String? localName;
  final String cleanName;
  final String language;
  final String region;
  final String cardNumber;
  final String numberClean;
  final String? numberDenominator;
  final String setId;
  final String? setCode;
  final String? rarity;
  final String? supertype;
  final String? subtypes;
  final String? types;
  final String? hp;
  final String? artist;
  final String? artistClean;
  final String? imageUrlSmall;
  final String? imageUrlLarge;
  final String? externalIds;
  const CardsTableData({
    required this.id,
    required this.name,
    this.localName,
    required this.cleanName,
    required this.language,
    required this.region,
    required this.cardNumber,
    required this.numberClean,
    this.numberDenominator,
    required this.setId,
    this.setCode,
    this.rarity,
    this.supertype,
    this.subtypes,
    this.types,
    this.hp,
    this.artist,
    this.artistClean,
    this.imageUrlSmall,
    this.imageUrlLarge,
    this.externalIds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || localName != null) {
      map['local_name'] = Variable<String>(localName);
    }
    map['clean_name'] = Variable<String>(cleanName);
    map['language'] = Variable<String>(language);
    map['region'] = Variable<String>(region);
    map['card_number'] = Variable<String>(cardNumber);
    map['number_clean'] = Variable<String>(numberClean);
    if (!nullToAbsent || numberDenominator != null) {
      map['number_denominator'] = Variable<String>(numberDenominator);
    }
    map['set_id'] = Variable<String>(setId);
    if (!nullToAbsent || setCode != null) {
      map['set_code'] = Variable<String>(setCode);
    }
    if (!nullToAbsent || rarity != null) {
      map['rarity'] = Variable<String>(rarity);
    }
    if (!nullToAbsent || supertype != null) {
      map['supertype'] = Variable<String>(supertype);
    }
    if (!nullToAbsent || subtypes != null) {
      map['subtypes'] = Variable<String>(subtypes);
    }
    if (!nullToAbsent || types != null) {
      map['types'] = Variable<String>(types);
    }
    if (!nullToAbsent || hp != null) {
      map['hp'] = Variable<String>(hp);
    }
    if (!nullToAbsent || artist != null) {
      map['artist'] = Variable<String>(artist);
    }
    if (!nullToAbsent || artistClean != null) {
      map['artist_clean'] = Variable<String>(artistClean);
    }
    if (!nullToAbsent || imageUrlSmall != null) {
      map['image_url_small'] = Variable<String>(imageUrlSmall);
    }
    if (!nullToAbsent || imageUrlLarge != null) {
      map['image_url_large'] = Variable<String>(imageUrlLarge);
    }
    if (!nullToAbsent || externalIds != null) {
      map['external_ids'] = Variable<String>(externalIds);
    }
    return map;
  }

  CardsTableCompanion toCompanion(bool nullToAbsent) {
    return CardsTableCompanion(
      id: Value(id),
      name: Value(name),
      localName: localName == null && nullToAbsent
          ? const Value.absent()
          : Value(localName),
      cleanName: Value(cleanName),
      language: Value(language),
      region: Value(region),
      cardNumber: Value(cardNumber),
      numberClean: Value(numberClean),
      numberDenominator: numberDenominator == null && nullToAbsent
          ? const Value.absent()
          : Value(numberDenominator),
      setId: Value(setId),
      setCode: setCode == null && nullToAbsent
          ? const Value.absent()
          : Value(setCode),
      rarity: rarity == null && nullToAbsent
          ? const Value.absent()
          : Value(rarity),
      supertype: supertype == null && nullToAbsent
          ? const Value.absent()
          : Value(supertype),
      subtypes: subtypes == null && nullToAbsent
          ? const Value.absent()
          : Value(subtypes),
      types: types == null && nullToAbsent
          ? const Value.absent()
          : Value(types),
      hp: hp == null && nullToAbsent ? const Value.absent() : Value(hp),
      artist: artist == null && nullToAbsent
          ? const Value.absent()
          : Value(artist),
      artistClean: artistClean == null && nullToAbsent
          ? const Value.absent()
          : Value(artistClean),
      imageUrlSmall: imageUrlSmall == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrlSmall),
      imageUrlLarge: imageUrlLarge == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrlLarge),
      externalIds: externalIds == null && nullToAbsent
          ? const Value.absent()
          : Value(externalIds),
    );
  }

  factory CardsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CardsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      localName: serializer.fromJson<String?>(json['localName']),
      cleanName: serializer.fromJson<String>(json['cleanName']),
      language: serializer.fromJson<String>(json['language']),
      region: serializer.fromJson<String>(json['region']),
      cardNumber: serializer.fromJson<String>(json['cardNumber']),
      numberClean: serializer.fromJson<String>(json['numberClean']),
      numberDenominator: serializer.fromJson<String?>(
        json['numberDenominator'],
      ),
      setId: serializer.fromJson<String>(json['setId']),
      setCode: serializer.fromJson<String?>(json['setCode']),
      rarity: serializer.fromJson<String?>(json['rarity']),
      supertype: serializer.fromJson<String?>(json['supertype']),
      subtypes: serializer.fromJson<String?>(json['subtypes']),
      types: serializer.fromJson<String?>(json['types']),
      hp: serializer.fromJson<String?>(json['hp']),
      artist: serializer.fromJson<String?>(json['artist']),
      artistClean: serializer.fromJson<String?>(json['artistClean']),
      imageUrlSmall: serializer.fromJson<String?>(json['imageUrlSmall']),
      imageUrlLarge: serializer.fromJson<String?>(json['imageUrlLarge']),
      externalIds: serializer.fromJson<String?>(json['externalIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'localName': serializer.toJson<String?>(localName),
      'cleanName': serializer.toJson<String>(cleanName),
      'language': serializer.toJson<String>(language),
      'region': serializer.toJson<String>(region),
      'cardNumber': serializer.toJson<String>(cardNumber),
      'numberClean': serializer.toJson<String>(numberClean),
      'numberDenominator': serializer.toJson<String?>(numberDenominator),
      'setId': serializer.toJson<String>(setId),
      'setCode': serializer.toJson<String?>(setCode),
      'rarity': serializer.toJson<String?>(rarity),
      'supertype': serializer.toJson<String?>(supertype),
      'subtypes': serializer.toJson<String?>(subtypes),
      'types': serializer.toJson<String?>(types),
      'hp': serializer.toJson<String?>(hp),
      'artist': serializer.toJson<String?>(artist),
      'artistClean': serializer.toJson<String?>(artistClean),
      'imageUrlSmall': serializer.toJson<String?>(imageUrlSmall),
      'imageUrlLarge': serializer.toJson<String?>(imageUrlLarge),
      'externalIds': serializer.toJson<String?>(externalIds),
    };
  }

  CardsTableData copyWith({
    String? id,
    String? name,
    Value<String?> localName = const Value.absent(),
    String? cleanName,
    String? language,
    String? region,
    String? cardNumber,
    String? numberClean,
    Value<String?> numberDenominator = const Value.absent(),
    String? setId,
    Value<String?> setCode = const Value.absent(),
    Value<String?> rarity = const Value.absent(),
    Value<String?> supertype = const Value.absent(),
    Value<String?> subtypes = const Value.absent(),
    Value<String?> types = const Value.absent(),
    Value<String?> hp = const Value.absent(),
    Value<String?> artist = const Value.absent(),
    Value<String?> artistClean = const Value.absent(),
    Value<String?> imageUrlSmall = const Value.absent(),
    Value<String?> imageUrlLarge = const Value.absent(),
    Value<String?> externalIds = const Value.absent(),
  }) => CardsTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    localName: localName.present ? localName.value : this.localName,
    cleanName: cleanName ?? this.cleanName,
    language: language ?? this.language,
    region: region ?? this.region,
    cardNumber: cardNumber ?? this.cardNumber,
    numberClean: numberClean ?? this.numberClean,
    numberDenominator: numberDenominator.present
        ? numberDenominator.value
        : this.numberDenominator,
    setId: setId ?? this.setId,
    setCode: setCode.present ? setCode.value : this.setCode,
    rarity: rarity.present ? rarity.value : this.rarity,
    supertype: supertype.present ? supertype.value : this.supertype,
    subtypes: subtypes.present ? subtypes.value : this.subtypes,
    types: types.present ? types.value : this.types,
    hp: hp.present ? hp.value : this.hp,
    artist: artist.present ? artist.value : this.artist,
    artistClean: artistClean.present ? artistClean.value : this.artistClean,
    imageUrlSmall: imageUrlSmall.present
        ? imageUrlSmall.value
        : this.imageUrlSmall,
    imageUrlLarge: imageUrlLarge.present
        ? imageUrlLarge.value
        : this.imageUrlLarge,
    externalIds: externalIds.present ? externalIds.value : this.externalIds,
  );
  CardsTableData copyWithCompanion(CardsTableCompanion data) {
    return CardsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      localName: data.localName.present ? data.localName.value : this.localName,
      cleanName: data.cleanName.present ? data.cleanName.value : this.cleanName,
      language: data.language.present ? data.language.value : this.language,
      region: data.region.present ? data.region.value : this.region,
      cardNumber: data.cardNumber.present
          ? data.cardNumber.value
          : this.cardNumber,
      numberClean: data.numberClean.present
          ? data.numberClean.value
          : this.numberClean,
      numberDenominator: data.numberDenominator.present
          ? data.numberDenominator.value
          : this.numberDenominator,
      setId: data.setId.present ? data.setId.value : this.setId,
      setCode: data.setCode.present ? data.setCode.value : this.setCode,
      rarity: data.rarity.present ? data.rarity.value : this.rarity,
      supertype: data.supertype.present ? data.supertype.value : this.supertype,
      subtypes: data.subtypes.present ? data.subtypes.value : this.subtypes,
      types: data.types.present ? data.types.value : this.types,
      hp: data.hp.present ? data.hp.value : this.hp,
      artist: data.artist.present ? data.artist.value : this.artist,
      artistClean: data.artistClean.present
          ? data.artistClean.value
          : this.artistClean,
      imageUrlSmall: data.imageUrlSmall.present
          ? data.imageUrlSmall.value
          : this.imageUrlSmall,
      imageUrlLarge: data.imageUrlLarge.present
          ? data.imageUrlLarge.value
          : this.imageUrlLarge,
      externalIds: data.externalIds.present
          ? data.externalIds.value
          : this.externalIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CardsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('localName: $localName, ')
          ..write('cleanName: $cleanName, ')
          ..write('language: $language, ')
          ..write('region: $region, ')
          ..write('cardNumber: $cardNumber, ')
          ..write('numberClean: $numberClean, ')
          ..write('numberDenominator: $numberDenominator, ')
          ..write('setId: $setId, ')
          ..write('setCode: $setCode, ')
          ..write('rarity: $rarity, ')
          ..write('supertype: $supertype, ')
          ..write('subtypes: $subtypes, ')
          ..write('types: $types, ')
          ..write('hp: $hp, ')
          ..write('artist: $artist, ')
          ..write('artistClean: $artistClean, ')
          ..write('imageUrlSmall: $imageUrlSmall, ')
          ..write('imageUrlLarge: $imageUrlLarge, ')
          ..write('externalIds: $externalIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    localName,
    cleanName,
    language,
    region,
    cardNumber,
    numberClean,
    numberDenominator,
    setId,
    setCode,
    rarity,
    supertype,
    subtypes,
    types,
    hp,
    artist,
    artistClean,
    imageUrlSmall,
    imageUrlLarge,
    externalIds,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CardsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.localName == this.localName &&
          other.cleanName == this.cleanName &&
          other.language == this.language &&
          other.region == this.region &&
          other.cardNumber == this.cardNumber &&
          other.numberClean == this.numberClean &&
          other.numberDenominator == this.numberDenominator &&
          other.setId == this.setId &&
          other.setCode == this.setCode &&
          other.rarity == this.rarity &&
          other.supertype == this.supertype &&
          other.subtypes == this.subtypes &&
          other.types == this.types &&
          other.hp == this.hp &&
          other.artist == this.artist &&
          other.artistClean == this.artistClean &&
          other.imageUrlSmall == this.imageUrlSmall &&
          other.imageUrlLarge == this.imageUrlLarge &&
          other.externalIds == this.externalIds);
}

class CardsTableCompanion extends UpdateCompanion<CardsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> localName;
  final Value<String> cleanName;
  final Value<String> language;
  final Value<String> region;
  final Value<String> cardNumber;
  final Value<String> numberClean;
  final Value<String?> numberDenominator;
  final Value<String> setId;
  final Value<String?> setCode;
  final Value<String?> rarity;
  final Value<String?> supertype;
  final Value<String?> subtypes;
  final Value<String?> types;
  final Value<String?> hp;
  final Value<String?> artist;
  final Value<String?> artistClean;
  final Value<String?> imageUrlSmall;
  final Value<String?> imageUrlLarge;
  final Value<String?> externalIds;
  final Value<int> rowid;
  const CardsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.localName = const Value.absent(),
    this.cleanName = const Value.absent(),
    this.language = const Value.absent(),
    this.region = const Value.absent(),
    this.cardNumber = const Value.absent(),
    this.numberClean = const Value.absent(),
    this.numberDenominator = const Value.absent(),
    this.setId = const Value.absent(),
    this.setCode = const Value.absent(),
    this.rarity = const Value.absent(),
    this.supertype = const Value.absent(),
    this.subtypes = const Value.absent(),
    this.types = const Value.absent(),
    this.hp = const Value.absent(),
    this.artist = const Value.absent(),
    this.artistClean = const Value.absent(),
    this.imageUrlSmall = const Value.absent(),
    this.imageUrlLarge = const Value.absent(),
    this.externalIds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CardsTableCompanion.insert({
    required String id,
    required String name,
    this.localName = const Value.absent(),
    required String cleanName,
    this.language = const Value.absent(),
    this.region = const Value.absent(),
    required String cardNumber,
    required String numberClean,
    this.numberDenominator = const Value.absent(),
    required String setId,
    this.setCode = const Value.absent(),
    this.rarity = const Value.absent(),
    this.supertype = const Value.absent(),
    this.subtypes = const Value.absent(),
    this.types = const Value.absent(),
    this.hp = const Value.absent(),
    this.artist = const Value.absent(),
    this.artistClean = const Value.absent(),
    this.imageUrlSmall = const Value.absent(),
    this.imageUrlLarge = const Value.absent(),
    this.externalIds = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       cleanName = Value(cleanName),
       cardNumber = Value(cardNumber),
       numberClean = Value(numberClean),
       setId = Value(setId);
  static Insertable<CardsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? localName,
    Expression<String>? cleanName,
    Expression<String>? language,
    Expression<String>? region,
    Expression<String>? cardNumber,
    Expression<String>? numberClean,
    Expression<String>? numberDenominator,
    Expression<String>? setId,
    Expression<String>? setCode,
    Expression<String>? rarity,
    Expression<String>? supertype,
    Expression<String>? subtypes,
    Expression<String>? types,
    Expression<String>? hp,
    Expression<String>? artist,
    Expression<String>? artistClean,
    Expression<String>? imageUrlSmall,
    Expression<String>? imageUrlLarge,
    Expression<String>? externalIds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (localName != null) 'local_name': localName,
      if (cleanName != null) 'clean_name': cleanName,
      if (language != null) 'language': language,
      if (region != null) 'region': region,
      if (cardNumber != null) 'card_number': cardNumber,
      if (numberClean != null) 'number_clean': numberClean,
      if (numberDenominator != null) 'number_denominator': numberDenominator,
      if (setId != null) 'set_id': setId,
      if (setCode != null) 'set_code': setCode,
      if (rarity != null) 'rarity': rarity,
      if (supertype != null) 'supertype': supertype,
      if (subtypes != null) 'subtypes': subtypes,
      if (types != null) 'types': types,
      if (hp != null) 'hp': hp,
      if (artist != null) 'artist': artist,
      if (artistClean != null) 'artist_clean': artistClean,
      if (imageUrlSmall != null) 'image_url_small': imageUrlSmall,
      if (imageUrlLarge != null) 'image_url_large': imageUrlLarge,
      if (externalIds != null) 'external_ids': externalIds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CardsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? localName,
    Value<String>? cleanName,
    Value<String>? language,
    Value<String>? region,
    Value<String>? cardNumber,
    Value<String>? numberClean,
    Value<String?>? numberDenominator,
    Value<String>? setId,
    Value<String?>? setCode,
    Value<String?>? rarity,
    Value<String?>? supertype,
    Value<String?>? subtypes,
    Value<String?>? types,
    Value<String?>? hp,
    Value<String?>? artist,
    Value<String?>? artistClean,
    Value<String?>? imageUrlSmall,
    Value<String?>? imageUrlLarge,
    Value<String?>? externalIds,
    Value<int>? rowid,
  }) {
    return CardsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      localName: localName ?? this.localName,
      cleanName: cleanName ?? this.cleanName,
      language: language ?? this.language,
      region: region ?? this.region,
      cardNumber: cardNumber ?? this.cardNumber,
      numberClean: numberClean ?? this.numberClean,
      numberDenominator: numberDenominator ?? this.numberDenominator,
      setId: setId ?? this.setId,
      setCode: setCode ?? this.setCode,
      rarity: rarity ?? this.rarity,
      supertype: supertype ?? this.supertype,
      subtypes: subtypes ?? this.subtypes,
      types: types ?? this.types,
      hp: hp ?? this.hp,
      artist: artist ?? this.artist,
      artistClean: artistClean ?? this.artistClean,
      imageUrlSmall: imageUrlSmall ?? this.imageUrlSmall,
      imageUrlLarge: imageUrlLarge ?? this.imageUrlLarge,
      externalIds: externalIds ?? this.externalIds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (localName.present) {
      map['local_name'] = Variable<String>(localName.value);
    }
    if (cleanName.present) {
      map['clean_name'] = Variable<String>(cleanName.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (cardNumber.present) {
      map['card_number'] = Variable<String>(cardNumber.value);
    }
    if (numberClean.present) {
      map['number_clean'] = Variable<String>(numberClean.value);
    }
    if (numberDenominator.present) {
      map['number_denominator'] = Variable<String>(numberDenominator.value);
    }
    if (setId.present) {
      map['set_id'] = Variable<String>(setId.value);
    }
    if (setCode.present) {
      map['set_code'] = Variable<String>(setCode.value);
    }
    if (rarity.present) {
      map['rarity'] = Variable<String>(rarity.value);
    }
    if (supertype.present) {
      map['supertype'] = Variable<String>(supertype.value);
    }
    if (subtypes.present) {
      map['subtypes'] = Variable<String>(subtypes.value);
    }
    if (types.present) {
      map['types'] = Variable<String>(types.value);
    }
    if (hp.present) {
      map['hp'] = Variable<String>(hp.value);
    }
    if (artist.present) {
      map['artist'] = Variable<String>(artist.value);
    }
    if (artistClean.present) {
      map['artist_clean'] = Variable<String>(artistClean.value);
    }
    if (imageUrlSmall.present) {
      map['image_url_small'] = Variable<String>(imageUrlSmall.value);
    }
    if (imageUrlLarge.present) {
      map['image_url_large'] = Variable<String>(imageUrlLarge.value);
    }
    if (externalIds.present) {
      map['external_ids'] = Variable<String>(externalIds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CardsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('localName: $localName, ')
          ..write('cleanName: $cleanName, ')
          ..write('language: $language, ')
          ..write('region: $region, ')
          ..write('cardNumber: $cardNumber, ')
          ..write('numberClean: $numberClean, ')
          ..write('numberDenominator: $numberDenominator, ')
          ..write('setId: $setId, ')
          ..write('setCode: $setCode, ')
          ..write('rarity: $rarity, ')
          ..write('supertype: $supertype, ')
          ..write('subtypes: $subtypes, ')
          ..write('types: $types, ')
          ..write('hp: $hp, ')
          ..write('artist: $artist, ')
          ..write('artistClean: $artistClean, ')
          ..write('imageUrlSmall: $imageUrlSmall, ')
          ..write('imageUrlLarge: $imageUrlLarge, ')
          ..write('externalIds: $externalIds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RawPricesTableTable extends RawPricesTable
    with TableInfo<$RawPricesTableTable, RawPricesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RawPricesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cards (id)',
    ),
  );
  static const VerificationMeta _marketPriceMeta = const VerificationMeta(
    'marketPrice',
  );
  @override
  late final GeneratedColumn<double> marketPrice = GeneratedColumn<double>(
    'market_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lowPriceMeta = const VerificationMeta(
    'lowPrice',
  );
  @override
  late final GeneratedColumn<double> lowPrice = GeneratedColumn<double>(
    'low_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _midPriceMeta = const VerificationMeta(
    'midPrice',
  );
  @override
  late final GeneratedColumn<double> midPrice = GeneratedColumn<double>(
    'mid_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _highPriceMeta = const VerificationMeta(
    'highPrice',
  );
  @override
  late final GeneratedColumn<double> highPrice = GeneratedColumn<double>(
    'high_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('tcgplayer'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    cardId,
    marketPrice,
    lowPrice,
    midPrice,
    highPrice,
    currency,
    source,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'raw_prices';
  @override
  VerificationContext validateIntegrity(
    Insertable<RawPricesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('market_price')) {
      context.handle(
        _marketPriceMeta,
        marketPrice.isAcceptableOrUnknown(
          data['market_price']!,
          _marketPriceMeta,
        ),
      );
    }
    if (data.containsKey('low_price')) {
      context.handle(
        _lowPriceMeta,
        lowPrice.isAcceptableOrUnknown(data['low_price']!, _lowPriceMeta),
      );
    }
    if (data.containsKey('mid_price')) {
      context.handle(
        _midPriceMeta,
        midPrice.isAcceptableOrUnknown(data['mid_price']!, _midPriceMeta),
      );
    }
    if (data.containsKey('high_price')) {
      context.handle(
        _highPriceMeta,
        highPrice.isAcceptableOrUnknown(data['high_price']!, _highPriceMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cardId};
  @override
  RawPricesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RawPricesTableData(
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      marketPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}market_price'],
      ),
      lowPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}low_price'],
      ),
      midPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mid_price'],
      ),
      highPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}high_price'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RawPricesTableTable createAlias(String alias) {
    return $RawPricesTableTable(attachedDatabase, alias);
  }
}

class RawPricesTableData extends DataClass
    implements Insertable<RawPricesTableData> {
  final String cardId;
  final double? marketPrice;
  final double? lowPrice;
  final double? midPrice;
  final double? highPrice;
  final String currency;
  final String source;
  final DateTime updatedAt;
  const RawPricesTableData({
    required this.cardId,
    this.marketPrice,
    this.lowPrice,
    this.midPrice,
    this.highPrice,
    required this.currency,
    required this.source,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['card_id'] = Variable<String>(cardId);
    if (!nullToAbsent || marketPrice != null) {
      map['market_price'] = Variable<double>(marketPrice);
    }
    if (!nullToAbsent || lowPrice != null) {
      map['low_price'] = Variable<double>(lowPrice);
    }
    if (!nullToAbsent || midPrice != null) {
      map['mid_price'] = Variable<double>(midPrice);
    }
    if (!nullToAbsent || highPrice != null) {
      map['high_price'] = Variable<double>(highPrice);
    }
    map['currency'] = Variable<String>(currency);
    map['source'] = Variable<String>(source);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RawPricesTableCompanion toCompanion(bool nullToAbsent) {
    return RawPricesTableCompanion(
      cardId: Value(cardId),
      marketPrice: marketPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(marketPrice),
      lowPrice: lowPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(lowPrice),
      midPrice: midPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(midPrice),
      highPrice: highPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(highPrice),
      currency: Value(currency),
      source: Value(source),
      updatedAt: Value(updatedAt),
    );
  }

  factory RawPricesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RawPricesTableData(
      cardId: serializer.fromJson<String>(json['cardId']),
      marketPrice: serializer.fromJson<double?>(json['marketPrice']),
      lowPrice: serializer.fromJson<double?>(json['lowPrice']),
      midPrice: serializer.fromJson<double?>(json['midPrice']),
      highPrice: serializer.fromJson<double?>(json['highPrice']),
      currency: serializer.fromJson<String>(json['currency']),
      source: serializer.fromJson<String>(json['source']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cardId': serializer.toJson<String>(cardId),
      'marketPrice': serializer.toJson<double?>(marketPrice),
      'lowPrice': serializer.toJson<double?>(lowPrice),
      'midPrice': serializer.toJson<double?>(midPrice),
      'highPrice': serializer.toJson<double?>(highPrice),
      'currency': serializer.toJson<String>(currency),
      'source': serializer.toJson<String>(source),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RawPricesTableData copyWith({
    String? cardId,
    Value<double?> marketPrice = const Value.absent(),
    Value<double?> lowPrice = const Value.absent(),
    Value<double?> midPrice = const Value.absent(),
    Value<double?> highPrice = const Value.absent(),
    String? currency,
    String? source,
    DateTime? updatedAt,
  }) => RawPricesTableData(
    cardId: cardId ?? this.cardId,
    marketPrice: marketPrice.present ? marketPrice.value : this.marketPrice,
    lowPrice: lowPrice.present ? lowPrice.value : this.lowPrice,
    midPrice: midPrice.present ? midPrice.value : this.midPrice,
    highPrice: highPrice.present ? highPrice.value : this.highPrice,
    currency: currency ?? this.currency,
    source: source ?? this.source,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RawPricesTableData copyWithCompanion(RawPricesTableCompanion data) {
    return RawPricesTableData(
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      marketPrice: data.marketPrice.present
          ? data.marketPrice.value
          : this.marketPrice,
      lowPrice: data.lowPrice.present ? data.lowPrice.value : this.lowPrice,
      midPrice: data.midPrice.present ? data.midPrice.value : this.midPrice,
      highPrice: data.highPrice.present ? data.highPrice.value : this.highPrice,
      currency: data.currency.present ? data.currency.value : this.currency,
      source: data.source.present ? data.source.value : this.source,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RawPricesTableData(')
          ..write('cardId: $cardId, ')
          ..write('marketPrice: $marketPrice, ')
          ..write('lowPrice: $lowPrice, ')
          ..write('midPrice: $midPrice, ')
          ..write('highPrice: $highPrice, ')
          ..write('currency: $currency, ')
          ..write('source: $source, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    cardId,
    marketPrice,
    lowPrice,
    midPrice,
    highPrice,
    currency,
    source,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RawPricesTableData &&
          other.cardId == this.cardId &&
          other.marketPrice == this.marketPrice &&
          other.lowPrice == this.lowPrice &&
          other.midPrice == this.midPrice &&
          other.highPrice == this.highPrice &&
          other.currency == this.currency &&
          other.source == this.source &&
          other.updatedAt == this.updatedAt);
}

class RawPricesTableCompanion extends UpdateCompanion<RawPricesTableData> {
  final Value<String> cardId;
  final Value<double?> marketPrice;
  final Value<double?> lowPrice;
  final Value<double?> midPrice;
  final Value<double?> highPrice;
  final Value<String> currency;
  final Value<String> source;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RawPricesTableCompanion({
    this.cardId = const Value.absent(),
    this.marketPrice = const Value.absent(),
    this.lowPrice = const Value.absent(),
    this.midPrice = const Value.absent(),
    this.highPrice = const Value.absent(),
    this.currency = const Value.absent(),
    this.source = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RawPricesTableCompanion.insert({
    required String cardId,
    this.marketPrice = const Value.absent(),
    this.lowPrice = const Value.absent(),
    this.midPrice = const Value.absent(),
    this.highPrice = const Value.absent(),
    this.currency = const Value.absent(),
    this.source = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : cardId = Value(cardId),
       updatedAt = Value(updatedAt);
  static Insertable<RawPricesTableData> custom({
    Expression<String>? cardId,
    Expression<double>? marketPrice,
    Expression<double>? lowPrice,
    Expression<double>? midPrice,
    Expression<double>? highPrice,
    Expression<String>? currency,
    Expression<String>? source,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cardId != null) 'card_id': cardId,
      if (marketPrice != null) 'market_price': marketPrice,
      if (lowPrice != null) 'low_price': lowPrice,
      if (midPrice != null) 'mid_price': midPrice,
      if (highPrice != null) 'high_price': highPrice,
      if (currency != null) 'currency': currency,
      if (source != null) 'source': source,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RawPricesTableCompanion copyWith({
    Value<String>? cardId,
    Value<double?>? marketPrice,
    Value<double?>? lowPrice,
    Value<double?>? midPrice,
    Value<double?>? highPrice,
    Value<String>? currency,
    Value<String>? source,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RawPricesTableCompanion(
      cardId: cardId ?? this.cardId,
      marketPrice: marketPrice ?? this.marketPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      midPrice: midPrice ?? this.midPrice,
      highPrice: highPrice ?? this.highPrice,
      currency: currency ?? this.currency,
      source: source ?? this.source,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (marketPrice.present) {
      map['market_price'] = Variable<double>(marketPrice.value);
    }
    if (lowPrice.present) {
      map['low_price'] = Variable<double>(lowPrice.value);
    }
    if (midPrice.present) {
      map['mid_price'] = Variable<double>(midPrice.value);
    }
    if (highPrice.present) {
      map['high_price'] = Variable<double>(highPrice.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RawPricesTableCompanion(')
          ..write('cardId: $cardId, ')
          ..write('marketPrice: $marketPrice, ')
          ..write('lowPrice: $lowPrice, ')
          ..write('midPrice: $midPrice, ')
          ..write('highPrice: $highPrice, ')
          ..write('currency: $currency, ')
          ..write('source: $source, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GradedPricesTableTable extends GradedPricesTable
    with TableInfo<$GradedPricesTableTable, GradedPricesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GradedPricesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cards (id)',
    ),
  );
  static const VerificationMeta _gradingCompanyMeta = const VerificationMeta(
    'gradingCompany',
  );
  @override
  late final GeneratedColumn<String> gradingCompany = GeneratedColumn<String>(
    'grading_company',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marketPriceMeta = const VerificationMeta(
    'marketPrice',
  );
  @override
  late final GeneratedColumn<double> marketPrice = GeneratedColumn<double>(
    'market_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lowPriceMeta = const VerificationMeta(
    'lowPrice',
  );
  @override
  late final GeneratedColumn<double> lowPrice = GeneratedColumn<double>(
    'low_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _highPriceMeta = const VerificationMeta(
    'highPrice',
  );
  @override
  late final GeneratedColumn<double> highPrice = GeneratedColumn<double>(
    'high_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pricecharting'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cardId,
    gradingCompany,
    grade,
    marketPrice,
    lowPrice,
    highPrice,
    currency,
    source,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'graded_prices';
  @override
  VerificationContext validateIntegrity(
    Insertable<GradedPricesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('grading_company')) {
      context.handle(
        _gradingCompanyMeta,
        gradingCompany.isAcceptableOrUnknown(
          data['grading_company']!,
          _gradingCompanyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gradingCompanyMeta);
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    } else if (isInserting) {
      context.missing(_gradeMeta);
    }
    if (data.containsKey('market_price')) {
      context.handle(
        _marketPriceMeta,
        marketPrice.isAcceptableOrUnknown(
          data['market_price']!,
          _marketPriceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_marketPriceMeta);
    }
    if (data.containsKey('low_price')) {
      context.handle(
        _lowPriceMeta,
        lowPrice.isAcceptableOrUnknown(data['low_price']!, _lowPriceMeta),
      );
    }
    if (data.containsKey('high_price')) {
      context.handle(
        _highPriceMeta,
        highPrice.isAcceptableOrUnknown(data['high_price']!, _highPriceMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {cardId, gradingCompany, grade},
  ];
  @override
  GradedPricesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GradedPricesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      gradingCompany: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grading_company'],
      )!,
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      )!,
      marketPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}market_price'],
      )!,
      lowPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}low_price'],
      ),
      highPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}high_price'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GradedPricesTableTable createAlias(String alias) {
    return $GradedPricesTableTable(attachedDatabase, alias);
  }
}

class GradedPricesTableData extends DataClass
    implements Insertable<GradedPricesTableData> {
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
  const GradedPricesTableData({
    required this.id,
    required this.cardId,
    required this.gradingCompany,
    required this.grade,
    required this.marketPrice,
    this.lowPrice,
    this.highPrice,
    required this.currency,
    required this.source,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['card_id'] = Variable<String>(cardId);
    map['grading_company'] = Variable<String>(gradingCompany);
    map['grade'] = Variable<String>(grade);
    map['market_price'] = Variable<double>(marketPrice);
    if (!nullToAbsent || lowPrice != null) {
      map['low_price'] = Variable<double>(lowPrice);
    }
    if (!nullToAbsent || highPrice != null) {
      map['high_price'] = Variable<double>(highPrice);
    }
    map['currency'] = Variable<String>(currency);
    map['source'] = Variable<String>(source);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GradedPricesTableCompanion toCompanion(bool nullToAbsent) {
    return GradedPricesTableCompanion(
      id: Value(id),
      cardId: Value(cardId),
      gradingCompany: Value(gradingCompany),
      grade: Value(grade),
      marketPrice: Value(marketPrice),
      lowPrice: lowPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(lowPrice),
      highPrice: highPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(highPrice),
      currency: Value(currency),
      source: Value(source),
      updatedAt: Value(updatedAt),
    );
  }

  factory GradedPricesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GradedPricesTableData(
      id: serializer.fromJson<String>(json['id']),
      cardId: serializer.fromJson<String>(json['cardId']),
      gradingCompany: serializer.fromJson<String>(json['gradingCompany']),
      grade: serializer.fromJson<String>(json['grade']),
      marketPrice: serializer.fromJson<double>(json['marketPrice']),
      lowPrice: serializer.fromJson<double?>(json['lowPrice']),
      highPrice: serializer.fromJson<double?>(json['highPrice']),
      currency: serializer.fromJson<String>(json['currency']),
      source: serializer.fromJson<String>(json['source']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cardId': serializer.toJson<String>(cardId),
      'gradingCompany': serializer.toJson<String>(gradingCompany),
      'grade': serializer.toJson<String>(grade),
      'marketPrice': serializer.toJson<double>(marketPrice),
      'lowPrice': serializer.toJson<double?>(lowPrice),
      'highPrice': serializer.toJson<double?>(highPrice),
      'currency': serializer.toJson<String>(currency),
      'source': serializer.toJson<String>(source),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GradedPricesTableData copyWith({
    String? id,
    String? cardId,
    String? gradingCompany,
    String? grade,
    double? marketPrice,
    Value<double?> lowPrice = const Value.absent(),
    Value<double?> highPrice = const Value.absent(),
    String? currency,
    String? source,
    DateTime? updatedAt,
  }) => GradedPricesTableData(
    id: id ?? this.id,
    cardId: cardId ?? this.cardId,
    gradingCompany: gradingCompany ?? this.gradingCompany,
    grade: grade ?? this.grade,
    marketPrice: marketPrice ?? this.marketPrice,
    lowPrice: lowPrice.present ? lowPrice.value : this.lowPrice,
    highPrice: highPrice.present ? highPrice.value : this.highPrice,
    currency: currency ?? this.currency,
    source: source ?? this.source,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GradedPricesTableData copyWithCompanion(GradedPricesTableCompanion data) {
    return GradedPricesTableData(
      id: data.id.present ? data.id.value : this.id,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      gradingCompany: data.gradingCompany.present
          ? data.gradingCompany.value
          : this.gradingCompany,
      grade: data.grade.present ? data.grade.value : this.grade,
      marketPrice: data.marketPrice.present
          ? data.marketPrice.value
          : this.marketPrice,
      lowPrice: data.lowPrice.present ? data.lowPrice.value : this.lowPrice,
      highPrice: data.highPrice.present ? data.highPrice.value : this.highPrice,
      currency: data.currency.present ? data.currency.value : this.currency,
      source: data.source.present ? data.source.value : this.source,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GradedPricesTableData(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('gradingCompany: $gradingCompany, ')
          ..write('grade: $grade, ')
          ..write('marketPrice: $marketPrice, ')
          ..write('lowPrice: $lowPrice, ')
          ..write('highPrice: $highPrice, ')
          ..write('currency: $currency, ')
          ..write('source: $source, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cardId,
    gradingCompany,
    grade,
    marketPrice,
    lowPrice,
    highPrice,
    currency,
    source,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GradedPricesTableData &&
          other.id == this.id &&
          other.cardId == this.cardId &&
          other.gradingCompany == this.gradingCompany &&
          other.grade == this.grade &&
          other.marketPrice == this.marketPrice &&
          other.lowPrice == this.lowPrice &&
          other.highPrice == this.highPrice &&
          other.currency == this.currency &&
          other.source == this.source &&
          other.updatedAt == this.updatedAt);
}

class GradedPricesTableCompanion
    extends UpdateCompanion<GradedPricesTableData> {
  final Value<String> id;
  final Value<String> cardId;
  final Value<String> gradingCompany;
  final Value<String> grade;
  final Value<double> marketPrice;
  final Value<double?> lowPrice;
  final Value<double?> highPrice;
  final Value<String> currency;
  final Value<String> source;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GradedPricesTableCompanion({
    this.id = const Value.absent(),
    this.cardId = const Value.absent(),
    this.gradingCompany = const Value.absent(),
    this.grade = const Value.absent(),
    this.marketPrice = const Value.absent(),
    this.lowPrice = const Value.absent(),
    this.highPrice = const Value.absent(),
    this.currency = const Value.absent(),
    this.source = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GradedPricesTableCompanion.insert({
    required String id,
    required String cardId,
    required String gradingCompany,
    required String grade,
    required double marketPrice,
    this.lowPrice = const Value.absent(),
    this.highPrice = const Value.absent(),
    this.currency = const Value.absent(),
    this.source = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cardId = Value(cardId),
       gradingCompany = Value(gradingCompany),
       grade = Value(grade),
       marketPrice = Value(marketPrice),
       updatedAt = Value(updatedAt);
  static Insertable<GradedPricesTableData> custom({
    Expression<String>? id,
    Expression<String>? cardId,
    Expression<String>? gradingCompany,
    Expression<String>? grade,
    Expression<double>? marketPrice,
    Expression<double>? lowPrice,
    Expression<double>? highPrice,
    Expression<String>? currency,
    Expression<String>? source,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cardId != null) 'card_id': cardId,
      if (gradingCompany != null) 'grading_company': gradingCompany,
      if (grade != null) 'grade': grade,
      if (marketPrice != null) 'market_price': marketPrice,
      if (lowPrice != null) 'low_price': lowPrice,
      if (highPrice != null) 'high_price': highPrice,
      if (currency != null) 'currency': currency,
      if (source != null) 'source': source,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GradedPricesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? cardId,
    Value<String>? gradingCompany,
    Value<String>? grade,
    Value<double>? marketPrice,
    Value<double?>? lowPrice,
    Value<double?>? highPrice,
    Value<String>? currency,
    Value<String>? source,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GradedPricesTableCompanion(
      id: id ?? this.id,
      cardId: cardId ?? this.cardId,
      gradingCompany: gradingCompany ?? this.gradingCompany,
      grade: grade ?? this.grade,
      marketPrice: marketPrice ?? this.marketPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      highPrice: highPrice ?? this.highPrice,
      currency: currency ?? this.currency,
      source: source ?? this.source,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (gradingCompany.present) {
      map['grading_company'] = Variable<String>(gradingCompany.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (marketPrice.present) {
      map['market_price'] = Variable<double>(marketPrice.value);
    }
    if (lowPrice.present) {
      map['low_price'] = Variable<double>(lowPrice.value);
    }
    if (highPrice.present) {
      map['high_price'] = Variable<double>(highPrice.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GradedPricesTableCompanion(')
          ..write('id: $id, ')
          ..write('cardId: $cardId, ')
          ..write('gradingCompany: $gradingCompany, ')
          ..write('grade: $grade, ')
          ..write('marketPrice: $marketPrice, ')
          ..write('lowPrice: $lowPrice, ')
          ..write('highPrice: $highPrice, ')
          ..write('currency: $currency, ')
          ..write('source: $source, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserCardsTableTable extends UserCardsTable
    with TableInfo<$UserCardsTableTable, UserCardsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserCardsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local_user'),
  );
  static const VerificationMeta _cardIdMeta = const VerificationMeta('cardId');
  @override
  late final GeneratedColumn<String> cardId = GeneratedColumn<String>(
    'card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cards (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('raw'),
  );
  static const VerificationMeta _gradingCompanyMeta = const VerificationMeta(
    'gradingCompany',
  );
  @override
  late final GeneratedColumn<String> gradingCompany = GeneratedColumn<String>(
    'grading_company',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
    'grade',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _certNumberMeta = const VerificationMeta(
    'certNumber',
  );
  @override
  late final GeneratedColumn<String> certNumber = GeneratedColumn<String>(
    'cert_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchasePriceMeta = const VerificationMeta(
    'purchasePrice',
  );
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
    'purchase_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    cardId,
    quantity,
    condition,
    gradingCompany,
    grade,
    certNumber,
    purchasePrice,
    purchaseDate,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_cards';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserCardsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('card_id')) {
      context.handle(
        _cardIdMeta,
        cardId.isAcceptableOrUnknown(data['card_id']!, _cardIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cardIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    }
    if (data.containsKey('grading_company')) {
      context.handle(
        _gradingCompanyMeta,
        gradingCompany.isAcceptableOrUnknown(
          data['grading_company']!,
          _gradingCompanyMeta,
        ),
      );
    }
    if (data.containsKey('grade')) {
      context.handle(
        _gradeMeta,
        grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta),
      );
    }
    if (data.containsKey('cert_number')) {
      context.handle(
        _certNumberMeta,
        certNumber.isAcceptableOrUnknown(data['cert_number']!, _certNumberMeta),
      );
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
        _purchasePriceMeta,
        purchasePrice.isAcceptableOrUnknown(
          data['purchase_price']!,
          _purchasePriceMeta,
        ),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserCardsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserCardsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      cardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}card_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      )!,
      gradingCompany: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grading_company'],
      ),
      grade: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grade'],
      ),
      certNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cert_number'],
      ),
      purchasePrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}purchase_price'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserCardsTableTable createAlias(String alias) {
    return $UserCardsTableTable(attachedDatabase, alias);
  }
}

class UserCardsTableData extends DataClass
    implements Insertable<UserCardsTableData> {
  final String id;
  final String userId;
  final String cardId;
  final int quantity;
  final String condition;
  final String? gradingCompany;
  final String? grade;
  final String? certNumber;
  final double? purchasePrice;
  final DateTime? purchaseDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserCardsTableData({
    required this.id,
    required this.userId,
    required this.cardId,
    required this.quantity,
    required this.condition,
    this.gradingCompany,
    this.grade,
    this.certNumber,
    this.purchasePrice,
    this.purchaseDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['card_id'] = Variable<String>(cardId);
    map['quantity'] = Variable<int>(quantity);
    map['condition'] = Variable<String>(condition);
    if (!nullToAbsent || gradingCompany != null) {
      map['grading_company'] = Variable<String>(gradingCompany);
    }
    if (!nullToAbsent || grade != null) {
      map['grade'] = Variable<String>(grade);
    }
    if (!nullToAbsent || certNumber != null) {
      map['cert_number'] = Variable<String>(certNumber);
    }
    if (!nullToAbsent || purchasePrice != null) {
      map['purchase_price'] = Variable<double>(purchasePrice);
    }
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserCardsTableCompanion toCompanion(bool nullToAbsent) {
    return UserCardsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      cardId: Value(cardId),
      quantity: Value(quantity),
      condition: Value(condition),
      gradingCompany: gradingCompany == null && nullToAbsent
          ? const Value.absent()
          : Value(gradingCompany),
      grade: grade == null && nullToAbsent
          ? const Value.absent()
          : Value(grade),
      certNumber: certNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(certNumber),
      purchasePrice: purchasePrice == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasePrice),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserCardsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserCardsTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      cardId: serializer.fromJson<String>(json['cardId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      condition: serializer.fromJson<String>(json['condition']),
      gradingCompany: serializer.fromJson<String?>(json['gradingCompany']),
      grade: serializer.fromJson<String?>(json['grade']),
      certNumber: serializer.fromJson<String?>(json['certNumber']),
      purchasePrice: serializer.fromJson<double?>(json['purchasePrice']),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'cardId': serializer.toJson<String>(cardId),
      'quantity': serializer.toJson<int>(quantity),
      'condition': serializer.toJson<String>(condition),
      'gradingCompany': serializer.toJson<String?>(gradingCompany),
      'grade': serializer.toJson<String?>(grade),
      'certNumber': serializer.toJson<String?>(certNumber),
      'purchasePrice': serializer.toJson<double?>(purchasePrice),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserCardsTableData copyWith({
    String? id,
    String? userId,
    String? cardId,
    int? quantity,
    String? condition,
    Value<String?> gradingCompany = const Value.absent(),
    Value<String?> grade = const Value.absent(),
    Value<String?> certNumber = const Value.absent(),
    Value<double?> purchasePrice = const Value.absent(),
    Value<DateTime?> purchaseDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserCardsTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    cardId: cardId ?? this.cardId,
    quantity: quantity ?? this.quantity,
    condition: condition ?? this.condition,
    gradingCompany: gradingCompany.present
        ? gradingCompany.value
        : this.gradingCompany,
    grade: grade.present ? grade.value : this.grade,
    certNumber: certNumber.present ? certNumber.value : this.certNumber,
    purchasePrice: purchasePrice.present
        ? purchasePrice.value
        : this.purchasePrice,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserCardsTableData copyWithCompanion(UserCardsTableCompanion data) {
    return UserCardsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      cardId: data.cardId.present ? data.cardId.value : this.cardId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      condition: data.condition.present ? data.condition.value : this.condition,
      gradingCompany: data.gradingCompany.present
          ? data.gradingCompany.value
          : this.gradingCompany,
      grade: data.grade.present ? data.grade.value : this.grade,
      certNumber: data.certNumber.present
          ? data.certNumber.value
          : this.certNumber,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserCardsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('cardId: $cardId, ')
          ..write('quantity: $quantity, ')
          ..write('condition: $condition, ')
          ..write('gradingCompany: $gradingCompany, ')
          ..write('grade: $grade, ')
          ..write('certNumber: $certNumber, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    cardId,
    quantity,
    condition,
    gradingCompany,
    grade,
    certNumber,
    purchasePrice,
    purchaseDate,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserCardsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.cardId == this.cardId &&
          other.quantity == this.quantity &&
          other.condition == this.condition &&
          other.gradingCompany == this.gradingCompany &&
          other.grade == this.grade &&
          other.certNumber == this.certNumber &&
          other.purchasePrice == this.purchasePrice &&
          other.purchaseDate == this.purchaseDate &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserCardsTableCompanion extends UpdateCompanion<UserCardsTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> cardId;
  final Value<int> quantity;
  final Value<String> condition;
  final Value<String?> gradingCompany;
  final Value<String?> grade;
  final Value<String?> certNumber;
  final Value<double?> purchasePrice;
  final Value<DateTime?> purchaseDate;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserCardsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.cardId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.condition = const Value.absent(),
    this.gradingCompany = const Value.absent(),
    this.grade = const Value.absent(),
    this.certNumber = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserCardsTableCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required String cardId,
    this.quantity = const Value.absent(),
    this.condition = const Value.absent(),
    this.gradingCompany = const Value.absent(),
    this.grade = const Value.absent(),
    this.certNumber = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cardId = Value(cardId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserCardsTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? cardId,
    Expression<int>? quantity,
    Expression<String>? condition,
    Expression<String>? gradingCompany,
    Expression<String>? grade,
    Expression<String>? certNumber,
    Expression<double>? purchasePrice,
    Expression<DateTime>? purchaseDate,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (cardId != null) 'card_id': cardId,
      if (quantity != null) 'quantity': quantity,
      if (condition != null) 'condition': condition,
      if (gradingCompany != null) 'grading_company': gradingCompany,
      if (grade != null) 'grade': grade,
      if (certNumber != null) 'cert_number': certNumber,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserCardsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? cardId,
    Value<int>? quantity,
    Value<String>? condition,
    Value<String?>? gradingCompany,
    Value<String?>? grade,
    Value<String?>? certNumber,
    Value<double?>? purchasePrice,
    Value<DateTime?>? purchaseDate,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserCardsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cardId: cardId ?? this.cardId,
      quantity: quantity ?? this.quantity,
      condition: condition ?? this.condition,
      gradingCompany: gradingCompany ?? this.gradingCompany,
      grade: grade ?? this.grade,
      certNumber: certNumber ?? this.certNumber,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (cardId.present) {
      map['card_id'] = Variable<String>(cardId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (gradingCompany.present) {
      map['grading_company'] = Variable<String>(gradingCompany.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (certNumber.present) {
      map['cert_number'] = Variable<String>(certNumber.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCardsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('cardId: $cardId, ')
          ..write('quantity: $quantity, ')
          ..write('condition: $condition, ')
          ..write('gradingCompany: $gradingCompany, ')
          ..write('grade: $grade, ')
          ..write('certNumber: $certNumber, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CollectionsTableTable extends CollectionsTable
    with TableInfo<$CollectionsTableTable, CollectionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local_user'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetSetIdMeta = const VerificationMeta(
    'targetSetId',
  );
  @override
  late final GeneratedColumn<String> targetSetId = GeneratedColumn<String>(
    'target_set_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sets (id)',
    ),
  );
  static const VerificationMeta _targetArtistMeta = const VerificationMeta(
    'targetArtist',
  );
  @override
  late final GeneratedColumn<String> targetArtist = GeneratedColumn<String>(
    'target_artist',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    description,
    type,
    targetSetId,
    targetArtist,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collections';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('target_set_id')) {
      context.handle(
        _targetSetIdMeta,
        targetSetId.isAcceptableOrUnknown(
          data['target_set_id']!,
          _targetSetIdMeta,
        ),
      );
    }
    if (data.containsKey('target_artist')) {
      context.handle(
        _targetArtistMeta,
        targetArtist.isAcceptableOrUnknown(
          data['target_artist']!,
          _targetArtistMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CollectionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      targetSetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_set_id'],
      ),
      targetArtist: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_artist'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CollectionsTableTable createAlias(String alias) {
    return $CollectionsTableTable(attachedDatabase, alias);
  }
}

class CollectionsTableData extends DataClass
    implements Insertable<CollectionsTableData> {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final String type;
  final String? targetSetId;
  final String? targetArtist;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CollectionsTableData({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.type,
    this.targetSetId,
    this.targetArtist,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || targetSetId != null) {
      map['target_set_id'] = Variable<String>(targetSetId);
    }
    if (!nullToAbsent || targetArtist != null) {
      map['target_artist'] = Variable<String>(targetArtist);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CollectionsTableCompanion toCompanion(bool nullToAbsent) {
    return CollectionsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
      targetSetId: targetSetId == null && nullToAbsent
          ? const Value.absent()
          : Value(targetSetId),
      targetArtist: targetArtist == null && nullToAbsent
          ? const Value.absent()
          : Value(targetArtist),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CollectionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionsTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      type: serializer.fromJson<String>(json['type']),
      targetSetId: serializer.fromJson<String?>(json['targetSetId']),
      targetArtist: serializer.fromJson<String?>(json['targetArtist']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'type': serializer.toJson<String>(type),
      'targetSetId': serializer.toJson<String?>(targetSetId),
      'targetArtist': serializer.toJson<String?>(targetArtist),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CollectionsTableData copyWith({
    String? id,
    String? userId,
    String? name,
    Value<String?> description = const Value.absent(),
    String? type,
    Value<String?> targetSetId = const Value.absent(),
    Value<String?> targetArtist = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CollectionsTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    type: type ?? this.type,
    targetSetId: targetSetId.present ? targetSetId.value : this.targetSetId,
    targetArtist: targetArtist.present ? targetArtist.value : this.targetArtist,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CollectionsTableData copyWithCompanion(CollectionsTableCompanion data) {
    return CollectionsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      type: data.type.present ? data.type.value : this.type,
      targetSetId: data.targetSetId.present
          ? data.targetSetId.value
          : this.targetSetId,
      targetArtist: data.targetArtist.present
          ? data.targetArtist.value
          : this.targetArtist,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('targetSetId: $targetSetId, ')
          ..write('targetArtist: $targetArtist, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    description,
    type,
    targetSetId,
    targetArtist,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.description == this.description &&
          other.type == this.type &&
          other.targetSetId == this.targetSetId &&
          other.targetArtist == this.targetArtist &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CollectionsTableCompanion extends UpdateCompanion<CollectionsTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> type;
  final Value<String?> targetSetId;
  final Value<String?> targetArtist;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CollectionsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.targetSetId = const Value.absent(),
    this.targetArtist = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionsTableCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String type,
    this.targetSetId = const Value.absent(),
    this.targetArtist = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CollectionsTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? type,
    Expression<String>? targetSetId,
    Expression<String>? targetArtist,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (targetSetId != null) 'target_set_id': targetSetId,
      if (targetArtist != null) 'target_artist': targetArtist,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CollectionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? type,
    Value<String?>? targetSetId,
    Value<String?>? targetArtist,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CollectionsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      targetSetId: targetSetId ?? this.targetSetId,
      targetArtist: targetArtist ?? this.targetArtist,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (targetSetId.present) {
      map['target_set_id'] = Variable<String>(targetSetId.value);
    }
    if (targetArtist.present) {
      map['target_artist'] = Variable<String>(targetArtist.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('targetSetId: $targetSetId, ')
          ..write('targetArtist: $targetArtist, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CollectionItemsTableTable extends CollectionItemsTable
    with TableInfo<$CollectionItemsTableTable, CollectionItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CollectionItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _collectionIdMeta = const VerificationMeta(
    'collectionId',
  );
  @override
  late final GeneratedColumn<String> collectionId = GeneratedColumn<String>(
    'collection_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES collections (id)',
    ),
  );
  static const VerificationMeta _userCardIdMeta = const VerificationMeta(
    'userCardId',
  );
  @override
  late final GeneratedColumn<String> userCardId = GeneratedColumn<String>(
    'user_card_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_cards (id)',
    ),
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, collectionId, userCardId, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'collection_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CollectionItemsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('collection_id')) {
      context.handle(
        _collectionIdMeta,
        collectionId.isAcceptableOrUnknown(
          data['collection_id']!,
          _collectionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_collectionIdMeta);
    }
    if (data.containsKey('user_card_id')) {
      context.handle(
        _userCardIdMeta,
        userCardId.isAcceptableOrUnknown(
          data['user_card_id']!,
          _userCardIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userCardIdMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {collectionId, userCardId},
  ];
  @override
  CollectionItemsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CollectionItemsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      collectionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_id'],
      )!,
      userCardId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_card_id'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $CollectionItemsTableTable createAlias(String alias) {
    return $CollectionItemsTableTable(attachedDatabase, alias);
  }
}

class CollectionItemsTableData extends DataClass
    implements Insertable<CollectionItemsTableData> {
  final String id;
  final String collectionId;
  final String userCardId;
  final DateTime addedAt;
  const CollectionItemsTableData({
    required this.id,
    required this.collectionId,
    required this.userCardId,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['collection_id'] = Variable<String>(collectionId);
    map['user_card_id'] = Variable<String>(userCardId);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  CollectionItemsTableCompanion toCompanion(bool nullToAbsent) {
    return CollectionItemsTableCompanion(
      id: Value(id),
      collectionId: Value(collectionId),
      userCardId: Value(userCardId),
      addedAt: Value(addedAt),
    );
  }

  factory CollectionItemsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CollectionItemsTableData(
      id: serializer.fromJson<String>(json['id']),
      collectionId: serializer.fromJson<String>(json['collectionId']),
      userCardId: serializer.fromJson<String>(json['userCardId']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'collectionId': serializer.toJson<String>(collectionId),
      'userCardId': serializer.toJson<String>(userCardId),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  CollectionItemsTableData copyWith({
    String? id,
    String? collectionId,
    String? userCardId,
    DateTime? addedAt,
  }) => CollectionItemsTableData(
    id: id ?? this.id,
    collectionId: collectionId ?? this.collectionId,
    userCardId: userCardId ?? this.userCardId,
    addedAt: addedAt ?? this.addedAt,
  );
  CollectionItemsTableData copyWithCompanion(
    CollectionItemsTableCompanion data,
  ) {
    return CollectionItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      collectionId: data.collectionId.present
          ? data.collectionId.value
          : this.collectionId,
      userCardId: data.userCardId.present
          ? data.userCardId.value
          : this.userCardId,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CollectionItemsTableData(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('userCardId: $userCardId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, collectionId, userCardId, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CollectionItemsTableData &&
          other.id == this.id &&
          other.collectionId == this.collectionId &&
          other.userCardId == this.userCardId &&
          other.addedAt == this.addedAt);
}

class CollectionItemsTableCompanion
    extends UpdateCompanion<CollectionItemsTableData> {
  final Value<String> id;
  final Value<String> collectionId;
  final Value<String> userCardId;
  final Value<DateTime> addedAt;
  final Value<int> rowid;
  const CollectionItemsTableCompanion({
    this.id = const Value.absent(),
    this.collectionId = const Value.absent(),
    this.userCardId = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CollectionItemsTableCompanion.insert({
    required String id,
    required String collectionId,
    required String userCardId,
    required DateTime addedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       collectionId = Value(collectionId),
       userCardId = Value(userCardId),
       addedAt = Value(addedAt);
  static Insertable<CollectionItemsTableData> custom({
    Expression<String>? id,
    Expression<String>? collectionId,
    Expression<String>? userCardId,
    Expression<DateTime>? addedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (collectionId != null) 'collection_id': collectionId,
      if (userCardId != null) 'user_card_id': userCardId,
      if (addedAt != null) 'added_at': addedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CollectionItemsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? collectionId,
    Value<String>? userCardId,
    Value<DateTime>? addedAt,
    Value<int>? rowid,
  }) {
    return CollectionItemsTableCompanion(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      userCardId: userCardId ?? this.userCardId,
      addedAt: addedAt ?? this.addedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (collectionId.present) {
      map['collection_id'] = Variable<String>(collectionId.value);
    }
    if (userCardId.present) {
      map['user_card_id'] = Variable<String>(userCardId.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CollectionItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('collectionId: $collectionId, ')
          ..write('userCardId: $userCardId, ')
          ..write('addedAt: $addedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SetsTableTable setsTable = $SetsTableTable(this);
  late final $CardsTableTable cardsTable = $CardsTableTable(this);
  late final $RawPricesTableTable rawPricesTable = $RawPricesTableTable(this);
  late final $GradedPricesTableTable gradedPricesTable =
      $GradedPricesTableTable(this);
  late final $UserCardsTableTable userCardsTable = $UserCardsTableTable(this);
  late final $CollectionsTableTable collectionsTable = $CollectionsTableTable(
    this,
  );
  late final $CollectionItemsTableTable collectionItemsTable =
      $CollectionItemsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    setsTable,
    cardsTable,
    rawPricesTable,
    gradedPricesTable,
    userCardsTable,
    collectionsTable,
    collectionItemsTable,
  ];
}

typedef $$SetsTableTableCreateCompanionBuilder = SetsTableCompanion Function({
  required String id,
  required String name,
  Value<String?> localName,
  Value<String?> setCode,
  Value<String> language,
  Value<String> region,
  Value<String?> series,
  Value<String?> releaseDate,
  Value<int?> totalPrinted,
  Value<String?> symbolUrl,
  Value<String?> logoUrl,
  Value<String?> externalIds,
  Value<int> rowid,
});
typedef $$SetsTableTableUpdateCompanionBuilder = SetsTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> localName,
  Value<String?> setCode,
  Value<String> language,
  Value<String> region,
  Value<String?> series,
  Value<String?> releaseDate,
  Value<int?> totalPrinted,
  Value<String?> symbolUrl,
  Value<String?> logoUrl,
  Value<String?> externalIds,
  Value<int> rowid,
});

final class $$SetsTableTableReferences
    extends BaseReferences<_$AppDatabase, $SetsTableTable, SetsTableData> {
  $$SetsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CardsTableTable, List<CardsTableData>>
  _cardsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.cardsTable,
    aliasName: 'sets__id__cards__set_id',
  );

  $$CardsTableTableProcessedTableManager get cardsTableRefs {
    final manager = $$CardsTableTableTableManager(
      $_db,
      $_db.cardsTable,
    ).filter((f) => f.setId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_cardsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CollectionsTableTable, List<CollectionsTableData>>
  _collectionsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.collectionsTable,
    aliasName: 'sets__id__collections__target_set_id',
  );

  $$CollectionsTableTableProcessedTableManager get collectionsTableRefs {
    final manager = $$CollectionsTableTableTableManager(
      $_db,
      $_db.collectionsTable,
    ).filter((f) => f.targetSetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SetsTableTable> {
  $$SetsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localName => $composableBuilder(
    column: $table.localName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setCode => $composableBuilder(
    column: $table.setCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get series => $composableBuilder(
    column: $table.series,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPrinted => $composableBuilder(
    column: $table.totalPrinted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symbolUrl => $composableBuilder(
    column: $table.symbolUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalIds => $composableBuilder(
    column: $table.externalIds,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> cardsTableRefs(
    Expression<bool> Function($$CardsTableTableFilterComposer f) f,
  ) {
    final $$CardsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.setId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableFilterComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> collectionsTableRefs(
    Expression<bool> Function($$CollectionsTableTableFilterComposer f) f,
  ) {
    final $$CollectionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectionsTable,
      getReferencedColumn: (t) => t.targetSetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableTableFilterComposer(
            $db: $db,
            $table: $db.collectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SetsTableTable> {
  $$SetsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localName => $composableBuilder(
    column: $table.localName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setCode => $composableBuilder(
    column: $table.setCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get series => $composableBuilder(
    column: $table.series,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPrinted => $composableBuilder(
    column: $table.totalPrinted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symbolUrl => $composableBuilder(
    column: $table.symbolUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoUrl => $composableBuilder(
    column: $table.logoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalIds => $composableBuilder(
    column: $table.externalIds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetsTableTable> {
  $$SetsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get localName =>
      $composableBuilder(column: $table.localName, builder: (column) => column);

  GeneratedColumn<String> get setCode =>
      $composableBuilder(column: $table.setCode, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get series =>
      $composableBuilder(column: $table.series, builder: (column) => column);

  GeneratedColumn<String> get releaseDate => $composableBuilder(
    column: $table.releaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPrinted => $composableBuilder(
    column: $table.totalPrinted,
    builder: (column) => column,
  );

  GeneratedColumn<String> get symbolUrl =>
      $composableBuilder(column: $table.symbolUrl, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get externalIds => $composableBuilder(
    column: $table.externalIds,
    builder: (column) => column,
  );

  Expression<T> cardsTableRefs<T extends Object>(
    Expression<T> Function($$CardsTableTableAnnotationComposer a) f,
  ) {
    final $$CardsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.setId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> collectionsTableRefs<T extends Object>(
    Expression<T> Function($$CollectionsTableTableAnnotationComposer a) f,
  ) {
    final $$CollectionsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectionsTable,
      getReferencedColumn: (t) => t.targetSetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.collectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SetsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SetsTableTable,
          SetsTableData,
          $$SetsTableTableFilterComposer,
          $$SetsTableTableOrderingComposer,
          $$SetsTableTableAnnotationComposer,
          $$SetsTableTableCreateCompanionBuilder,
          $$SetsTableTableUpdateCompanionBuilder,
          (SetsTableData, $$SetsTableTableReferences),
          SetsTableData,
          PrefetchHooks Function({
            bool cardsTableRefs,
            bool collectionsTableRefs,
          })
        > {
  $$SetsTableTableTableManager(_$AppDatabase db, $SetsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> localName = const Value.absent(),
                Value<String?> setCode = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> region = const Value.absent(),
                Value<String?> series = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<int?> totalPrinted = const Value.absent(),
                Value<String?> symbolUrl = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> externalIds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SetsTableCompanion(
                id: id,
                name: name,
                localName: localName,
                setCode: setCode,
                language: language,
                region: region,
                series: series,
                releaseDate: releaseDate,
                totalPrinted: totalPrinted,
                symbolUrl: symbolUrl,
                logoUrl: logoUrl,
                externalIds: externalIds,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> localName = const Value.absent(),
                Value<String?> setCode = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> region = const Value.absent(),
                Value<String?> series = const Value.absent(),
                Value<String?> releaseDate = const Value.absent(),
                Value<int?> totalPrinted = const Value.absent(),
                Value<String?> symbolUrl = const Value.absent(),
                Value<String?> logoUrl = const Value.absent(),
                Value<String?> externalIds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SetsTableCompanion.insert(
                id: id,
                name: name,
                localName: localName,
                setCode: setCode,
                language: language,
                region: region,
                series: series,
                releaseDate: releaseDate,
                totalPrinted: totalPrinted,
                symbolUrl: symbolUrl,
                logoUrl: logoUrl,
                externalIds: externalIds,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SetsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({cardsTableRefs = false, collectionsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (cardsTableRefs) db.cardsTable,
                    if (collectionsTableRefs) db.collectionsTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (cardsTableRefs)
                        await $_getPrefetchedData<
                          SetsTableData,
                          $SetsTableTable,
                          CardsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SetsTableTableReferences
                              ._cardsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SetsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).cardsTableRefs,
                          referencedItemsForCurrentItem: (
                            item,
                            referencedItems,
                          ) => referencedItems.where((e) => e.setId == item.id),
                          typedResults: items,
                        ),
                      if (collectionsTableRefs)
                        await $_getPrefetchedData<
                          SetsTableData,
                          $SetsTableTable,
                          CollectionsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$SetsTableTableReferences
                              ._collectionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SetsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.targetSetId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SetsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SetsTableTable,
      SetsTableData,
      $$SetsTableTableFilterComposer,
      $$SetsTableTableOrderingComposer,
      $$SetsTableTableAnnotationComposer,
      $$SetsTableTableCreateCompanionBuilder,
      $$SetsTableTableUpdateCompanionBuilder,
      (SetsTableData, $$SetsTableTableReferences),
      SetsTableData,
      PrefetchHooks Function({bool cardsTableRefs, bool collectionsTableRefs})
    >;
typedef $$CardsTableTableCreateCompanionBuilder = CardsTableCompanion Function({
  required String id,
  required String name,
  Value<String?> localName,
  required String cleanName,
  Value<String> language,
  Value<String> region,
  required String cardNumber,
  required String numberClean,
  Value<String?> numberDenominator,
  required String setId,
  Value<String?> setCode,
  Value<String?> rarity,
  Value<String?> supertype,
  Value<String?> subtypes,
  Value<String?> types,
  Value<String?> hp,
  Value<String?> artist,
  Value<String?> artistClean,
  Value<String?> imageUrlSmall,
  Value<String?> imageUrlLarge,
  Value<String?> externalIds,
  Value<int> rowid,
});
typedef $$CardsTableTableUpdateCompanionBuilder = CardsTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> localName,
  Value<String> cleanName,
  Value<String> language,
  Value<String> region,
  Value<String> cardNumber,
  Value<String> numberClean,
  Value<String?> numberDenominator,
  Value<String> setId,
  Value<String?> setCode,
  Value<String?> rarity,
  Value<String?> supertype,
  Value<String?> subtypes,
  Value<String?> types,
  Value<String?> hp,
  Value<String?> artist,
  Value<String?> artistClean,
  Value<String?> imageUrlSmall,
  Value<String?> imageUrlLarge,
  Value<String?> externalIds,
  Value<int> rowid,
});

final class $$CardsTableTableReferences
    extends BaseReferences<_$AppDatabase, $CardsTableTable, CardsTableData> {
  $$CardsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SetsTableTable _setIdTable(_$AppDatabase db) =>
      db.setsTable.createAlias('cards__set_id__sets__id');

  $$SetsTableTableProcessedTableManager get setId {
    final $_column = $_itemColumn<String>('set_id')!;

    final manager = $$SetsTableTableTableManager(
      $_db,
      $_db.setsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_setIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RawPricesTableTable, List<RawPricesTableData>>
  _rawPricesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rawPricesTable,
    aliasName: 'cards__id__raw_prices__card_id',
  );

  $$RawPricesTableTableProcessedTableManager get rawPricesTableRefs {
    final manager = $$RawPricesTableTableTableManager(
      $_db,
      $_db.rawPricesTable,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_rawPricesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $GradedPricesTableTable,
    List<GradedPricesTableData>
  >
  _gradedPricesTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gradedPricesTable,
        aliasName: 'cards__id__graded_prices__card_id',
      );

  $$GradedPricesTableTableProcessedTableManager get gradedPricesTableRefs {
    final manager = $$GradedPricesTableTableTableManager(
      $_db,
      $_db.gradedPricesTable,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _gradedPricesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserCardsTableTable, List<UserCardsTableData>>
  _userCardsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userCardsTable,
    aliasName: 'cards__id__user_cards__card_id',
  );

  $$UserCardsTableTableProcessedTableManager get userCardsTableRefs {
    final manager = $$UserCardsTableTableTableManager(
      $_db,
      $_db.userCardsTable,
    ).filter((f) => f.cardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userCardsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CardsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CardsTableTable> {
  $$CardsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localName => $composableBuilder(
    column: $table.localName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cleanName => $composableBuilder(
    column: $table.cleanName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cardNumber => $composableBuilder(
    column: $table.cardNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numberClean => $composableBuilder(
    column: $table.numberClean,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numberDenominator => $composableBuilder(
    column: $table.numberDenominator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get setCode => $composableBuilder(
    column: $table.setCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supertype => $composableBuilder(
    column: $table.supertype,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtypes => $composableBuilder(
    column: $table.subtypes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get types => $composableBuilder(
    column: $table.types,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hp => $composableBuilder(
    column: $table.hp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get artistClean => $composableBuilder(
    column: $table.artistClean,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrlSmall => $composableBuilder(
    column: $table.imageUrlSmall,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrlLarge => $composableBuilder(
    column: $table.imageUrlLarge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalIds => $composableBuilder(
    column: $table.externalIds,
    builder: (column) => ColumnFilters(column),
  );

  $$SetsTableTableFilterComposer get setId {
    final $$SetsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setId,
      referencedTable: $db.setsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetsTableTableFilterComposer(
            $db: $db,
            $table: $db.setsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> rawPricesTableRefs(
    Expression<bool> Function($$RawPricesTableTableFilterComposer f) f,
  ) {
    final $$RawPricesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rawPricesTable,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawPricesTableTableFilterComposer(
            $db: $db,
            $table: $db.rawPricesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gradedPricesTableRefs(
    Expression<bool> Function($$GradedPricesTableTableFilterComposer f) f,
  ) {
    final $$GradedPricesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gradedPricesTable,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GradedPricesTableTableFilterComposer(
            $db: $db,
            $table: $db.gradedPricesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userCardsTableRefs(
    Expression<bool> Function($$UserCardsTableTableFilterComposer f) f,
  ) {
    final $$UserCardsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userCardsTable,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserCardsTableTableFilterComposer(
            $db: $db,
            $table: $db.userCardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CardsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CardsTableTable> {
  $$CardsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localName => $composableBuilder(
    column: $table.localName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cleanName => $composableBuilder(
    column: $table.cleanName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cardNumber => $composableBuilder(
    column: $table.cardNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numberClean => $composableBuilder(
    column: $table.numberClean,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numberDenominator => $composableBuilder(
    column: $table.numberDenominator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setCode => $composableBuilder(
    column: $table.setCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rarity => $composableBuilder(
    column: $table.rarity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supertype => $composableBuilder(
    column: $table.supertype,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtypes => $composableBuilder(
    column: $table.subtypes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get types => $composableBuilder(
    column: $table.types,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hp => $composableBuilder(
    column: $table.hp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artist => $composableBuilder(
    column: $table.artist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get artistClean => $composableBuilder(
    column: $table.artistClean,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrlSmall => $composableBuilder(
    column: $table.imageUrlSmall,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrlLarge => $composableBuilder(
    column: $table.imageUrlLarge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalIds => $composableBuilder(
    column: $table.externalIds,
    builder: (column) => ColumnOrderings(column),
  );

  $$SetsTableTableOrderingComposer get setId {
    final $$SetsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setId,
      referencedTable: $db.setsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetsTableTableOrderingComposer(
            $db: $db,
            $table: $db.setsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CardsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CardsTableTable> {
  $$CardsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get localName =>
      $composableBuilder(column: $table.localName, builder: (column) => column);

  GeneratedColumn<String> get cleanName =>
      $composableBuilder(column: $table.cleanName, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get cardNumber => $composableBuilder(
    column: $table.cardNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get numberClean => $composableBuilder(
    column: $table.numberClean,
    builder: (column) => column,
  );

  GeneratedColumn<String> get numberDenominator => $composableBuilder(
    column: $table.numberDenominator,
    builder: (column) => column,
  );

  GeneratedColumn<String> get setCode =>
      $composableBuilder(column: $table.setCode, builder: (column) => column);

  GeneratedColumn<String> get rarity =>
      $composableBuilder(column: $table.rarity, builder: (column) => column);

  GeneratedColumn<String> get supertype =>
      $composableBuilder(column: $table.supertype, builder: (column) => column);

  GeneratedColumn<String> get subtypes =>
      $composableBuilder(column: $table.subtypes, builder: (column) => column);

  GeneratedColumn<String> get types =>
      $composableBuilder(column: $table.types, builder: (column) => column);

  GeneratedColumn<String> get hp =>
      $composableBuilder(column: $table.hp, builder: (column) => column);

  GeneratedColumn<String> get artist =>
      $composableBuilder(column: $table.artist, builder: (column) => column);

  GeneratedColumn<String> get artistClean => $composableBuilder(
    column: $table.artistClean,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrlSmall => $composableBuilder(
    column: $table.imageUrlSmall,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrlLarge => $composableBuilder(
    column: $table.imageUrlLarge,
    builder: (column) => column,
  );

  GeneratedColumn<String> get externalIds => $composableBuilder(
    column: $table.externalIds,
    builder: (column) => column,
  );

  $$SetsTableTableAnnotationComposer get setId {
    final $$SetsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.setId,
      referencedTable: $db.setsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.setsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> rawPricesTableRefs<T extends Object>(
    Expression<T> Function($$RawPricesTableTableAnnotationComposer a) f,
  ) {
    final $$RawPricesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rawPricesTable,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RawPricesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.rawPricesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gradedPricesTableRefs<T extends Object>(
    Expression<T> Function($$GradedPricesTableTableAnnotationComposer a) f,
  ) {
    final $$GradedPricesTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gradedPricesTable,
          getReferencedColumn: (t) => t.cardId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GradedPricesTableTableAnnotationComposer(
                $db: $db,
                $table: $db.gradedPricesTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> userCardsTableRefs<T extends Object>(
    Expression<T> Function($$UserCardsTableTableAnnotationComposer a) f,
  ) {
    final $$UserCardsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userCardsTable,
      getReferencedColumn: (t) => t.cardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserCardsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userCardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CardsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CardsTableTable,
          CardsTableData,
          $$CardsTableTableFilterComposer,
          $$CardsTableTableOrderingComposer,
          $$CardsTableTableAnnotationComposer,
          $$CardsTableTableCreateCompanionBuilder,
          $$CardsTableTableUpdateCompanionBuilder,
          (CardsTableData, $$CardsTableTableReferences),
          CardsTableData,
          PrefetchHooks Function({
            bool setId,
            bool rawPricesTableRefs,
            bool gradedPricesTableRefs,
            bool userCardsTableRefs,
          })
        > {
  $$CardsTableTableTableManager(_$AppDatabase db, $CardsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CardsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CardsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CardsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> localName = const Value.absent(),
                Value<String> cleanName = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> region = const Value.absent(),
                Value<String> cardNumber = const Value.absent(),
                Value<String> numberClean = const Value.absent(),
                Value<String?> numberDenominator = const Value.absent(),
                Value<String> setId = const Value.absent(),
                Value<String?> setCode = const Value.absent(),
                Value<String?> rarity = const Value.absent(),
                Value<String?> supertype = const Value.absent(),
                Value<String?> subtypes = const Value.absent(),
                Value<String?> types = const Value.absent(),
                Value<String?> hp = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> artistClean = const Value.absent(),
                Value<String?> imageUrlSmall = const Value.absent(),
                Value<String?> imageUrlLarge = const Value.absent(),
                Value<String?> externalIds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardsTableCompanion(
                id: id,
                name: name,
                localName: localName,
                cleanName: cleanName,
                language: language,
                region: region,
                cardNumber: cardNumber,
                numberClean: numberClean,
                numberDenominator: numberDenominator,
                setId: setId,
                setCode: setCode,
                rarity: rarity,
                supertype: supertype,
                subtypes: subtypes,
                types: types,
                hp: hp,
                artist: artist,
                artistClean: artistClean,
                imageUrlSmall: imageUrlSmall,
                imageUrlLarge: imageUrlLarge,
                externalIds: externalIds,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> localName = const Value.absent(),
                required String cleanName,
                Value<String> language = const Value.absent(),
                Value<String> region = const Value.absent(),
                required String cardNumber,
                required String numberClean,
                Value<String?> numberDenominator = const Value.absent(),
                required String setId,
                Value<String?> setCode = const Value.absent(),
                Value<String?> rarity = const Value.absent(),
                Value<String?> supertype = const Value.absent(),
                Value<String?> subtypes = const Value.absent(),
                Value<String?> types = const Value.absent(),
                Value<String?> hp = const Value.absent(),
                Value<String?> artist = const Value.absent(),
                Value<String?> artistClean = const Value.absent(),
                Value<String?> imageUrlSmall = const Value.absent(),
                Value<String?> imageUrlLarge = const Value.absent(),
                Value<String?> externalIds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CardsTableCompanion.insert(
                id: id,
                name: name,
                localName: localName,
                cleanName: cleanName,
                language: language,
                region: region,
                cardNumber: cardNumber,
                numberClean: numberClean,
                numberDenominator: numberDenominator,
                setId: setId,
                setCode: setCode,
                rarity: rarity,
                supertype: supertype,
                subtypes: subtypes,
                types: types,
                hp: hp,
                artist: artist,
                artistClean: artistClean,
                imageUrlSmall: imageUrlSmall,
                imageUrlLarge: imageUrlLarge,
                externalIds: externalIds,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CardsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                setId = false,
                rawPricesTableRefs = false,
                gradedPricesTableRefs = false,
                userCardsTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (rawPricesTableRefs) db.rawPricesTable,
                    if (gradedPricesTableRefs) db.gradedPricesTable,
                    if (userCardsTableRefs) db.userCardsTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (setId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.setId,
                            referencedTable: $$CardsTableTableReferences
                                ._setIdTable(db),
                            referencedColumn: $$CardsTableTableReferences
                                ._setIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (rawPricesTableRefs)
                        await $_getPrefetchedData<
                          CardsTableData,
                          $CardsTableTable,
                          RawPricesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CardsTableTableReferences
                              ._rawPricesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CardsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).rawPricesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (gradedPricesTableRefs)
                        await $_getPrefetchedData<
                          CardsTableData,
                          $CardsTableTable,
                          GradedPricesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CardsTableTableReferences
                              ._gradedPricesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CardsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).gradedPricesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userCardsTableRefs)
                        await $_getPrefetchedData<
                          CardsTableData,
                          $CardsTableTable,
                          UserCardsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CardsTableTableReferences
                              ._userCardsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CardsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).userCardsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cardId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CardsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CardsTableTable,
      CardsTableData,
      $$CardsTableTableFilterComposer,
      $$CardsTableTableOrderingComposer,
      $$CardsTableTableAnnotationComposer,
      $$CardsTableTableCreateCompanionBuilder,
      $$CardsTableTableUpdateCompanionBuilder,
      (CardsTableData, $$CardsTableTableReferences),
      CardsTableData,
      PrefetchHooks Function({
        bool setId,
        bool rawPricesTableRefs,
        bool gradedPricesTableRefs,
        bool userCardsTableRefs,
      })
    >;
typedef $$RawPricesTableTableCreateCompanionBuilder =
    RawPricesTableCompanion Function({
      required String cardId,
      Value<double?> marketPrice,
      Value<double?> lowPrice,
      Value<double?> midPrice,
      Value<double?> highPrice,
      Value<String> currency,
      Value<String> source,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$RawPricesTableTableUpdateCompanionBuilder =
    RawPricesTableCompanion Function({
      Value<String> cardId,
      Value<double?> marketPrice,
      Value<double?> lowPrice,
      Value<double?> midPrice,
      Value<double?> highPrice,
      Value<String> currency,
      Value<String> source,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$RawPricesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RawPricesTableTable,
          RawPricesTableData
        > {
  $$RawPricesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CardsTableTable _cardIdTable(_$AppDatabase db) =>
      db.cardsTable.createAlias('raw_prices__card_id__cards__id');

  $$CardsTableTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$CardsTableTableTableManager(
      $_db,
      $_db.cardsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RawPricesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RawPricesTableTable> {
  $$RawPricesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get marketPrice => $composableBuilder(
    column: $table.marketPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lowPrice => $composableBuilder(
    column: $table.lowPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get midPrice => $composableBuilder(
    column: $table.midPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get highPrice => $composableBuilder(
    column: $table.highPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CardsTableTableFilterComposer get cardId {
    final $$CardsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableFilterComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RawPricesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RawPricesTableTable> {
  $$RawPricesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get marketPrice => $composableBuilder(
    column: $table.marketPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lowPrice => $composableBuilder(
    column: $table.lowPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get midPrice => $composableBuilder(
    column: $table.midPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get highPrice => $composableBuilder(
    column: $table.highPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CardsTableTableOrderingComposer get cardId {
    final $$CardsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableOrderingComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RawPricesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RawPricesTableTable> {
  $$RawPricesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get marketPrice => $composableBuilder(
    column: $table.marketPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lowPrice =>
      $composableBuilder(column: $table.lowPrice, builder: (column) => column);

  GeneratedColumn<double> get midPrice =>
      $composableBuilder(column: $table.midPrice, builder: (column) => column);

  GeneratedColumn<double> get highPrice =>
      $composableBuilder(column: $table.highPrice, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CardsTableTableAnnotationComposer get cardId {
    final $$CardsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RawPricesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RawPricesTableTable,
          RawPricesTableData,
          $$RawPricesTableTableFilterComposer,
          $$RawPricesTableTableOrderingComposer,
          $$RawPricesTableTableAnnotationComposer,
          $$RawPricesTableTableCreateCompanionBuilder,
          $$RawPricesTableTableUpdateCompanionBuilder,
          (RawPricesTableData, $$RawPricesTableTableReferences),
          RawPricesTableData,
          PrefetchHooks Function({bool cardId})
        > {
  $$RawPricesTableTableTableManager(
    _$AppDatabase db,
    $RawPricesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RawPricesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RawPricesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RawPricesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> cardId = const Value.absent(),
                Value<double?> marketPrice = const Value.absent(),
                Value<double?> lowPrice = const Value.absent(),
                Value<double?> midPrice = const Value.absent(),
                Value<double?> highPrice = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RawPricesTableCompanion(
                cardId: cardId,
                marketPrice: marketPrice,
                lowPrice: lowPrice,
                midPrice: midPrice,
                highPrice: highPrice,
                currency: currency,
                source: source,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String cardId,
                Value<double?> marketPrice = const Value.absent(),
                Value<double?> lowPrice = const Value.absent(),
                Value<double?> midPrice = const Value.absent(),
                Value<double?> highPrice = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> source = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RawPricesTableCompanion.insert(
                cardId: cardId,
                marketPrice: marketPrice,
                lowPrice: lowPrice,
                midPrice: midPrice,
                highPrice: highPrice,
                currency: currency,
                source: source,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RawPricesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cardId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.cardId,
                        referencedTable: $$RawPricesTableTableReferences
                            ._cardIdTable(db),
                        referencedColumn: $$RawPricesTableTableReferences
                            ._cardIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RawPricesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RawPricesTableTable,
      RawPricesTableData,
      $$RawPricesTableTableFilterComposer,
      $$RawPricesTableTableOrderingComposer,
      $$RawPricesTableTableAnnotationComposer,
      $$RawPricesTableTableCreateCompanionBuilder,
      $$RawPricesTableTableUpdateCompanionBuilder,
      (RawPricesTableData, $$RawPricesTableTableReferences),
      RawPricesTableData,
      PrefetchHooks Function({bool cardId})
    >;
typedef $$GradedPricesTableTableCreateCompanionBuilder =
    GradedPricesTableCompanion Function({
      required String id,
      required String cardId,
      required String gradingCompany,
      required String grade,
      required double marketPrice,
      Value<double?> lowPrice,
      Value<double?> highPrice,
      Value<String> currency,
      Value<String> source,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$GradedPricesTableTableUpdateCompanionBuilder =
    GradedPricesTableCompanion Function({
      Value<String> id,
      Value<String> cardId,
      Value<String> gradingCompany,
      Value<String> grade,
      Value<double> marketPrice,
      Value<double?> lowPrice,
      Value<double?> highPrice,
      Value<String> currency,
      Value<String> source,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$GradedPricesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GradedPricesTableTable,
          GradedPricesTableData
        > {
  $$GradedPricesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CardsTableTable _cardIdTable(_$AppDatabase db) =>
      db.cardsTable.createAlias('graded_prices__card_id__cards__id');

  $$CardsTableTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$CardsTableTableTableManager(
      $_db,
      $_db.cardsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GradedPricesTableTableFilterComposer
    extends Composer<_$AppDatabase, $GradedPricesTableTable> {
  $$GradedPricesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gradingCompany => $composableBuilder(
    column: $table.gradingCompany,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get marketPrice => $composableBuilder(
    column: $table.marketPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lowPrice => $composableBuilder(
    column: $table.lowPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get highPrice => $composableBuilder(
    column: $table.highPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CardsTableTableFilterComposer get cardId {
    final $$CardsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableFilterComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradedPricesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GradedPricesTableTable> {
  $$GradedPricesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gradingCompany => $composableBuilder(
    column: $table.gradingCompany,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get marketPrice => $composableBuilder(
    column: $table.marketPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lowPrice => $composableBuilder(
    column: $table.lowPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get highPrice => $composableBuilder(
    column: $table.highPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CardsTableTableOrderingComposer get cardId {
    final $$CardsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableOrderingComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradedPricesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GradedPricesTableTable> {
  $$GradedPricesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gradingCompany => $composableBuilder(
    column: $table.gradingCompany,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<double> get marketPrice => $composableBuilder(
    column: $table.marketPrice,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lowPrice =>
      $composableBuilder(column: $table.lowPrice, builder: (column) => column);

  GeneratedColumn<double> get highPrice =>
      $composableBuilder(column: $table.highPrice, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CardsTableTableAnnotationComposer get cardId {
    final $$CardsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GradedPricesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GradedPricesTableTable,
          GradedPricesTableData,
          $$GradedPricesTableTableFilterComposer,
          $$GradedPricesTableTableOrderingComposer,
          $$GradedPricesTableTableAnnotationComposer,
          $$GradedPricesTableTableCreateCompanionBuilder,
          $$GradedPricesTableTableUpdateCompanionBuilder,
          (GradedPricesTableData, $$GradedPricesTableTableReferences),
          GradedPricesTableData,
          PrefetchHooks Function({bool cardId})
        > {
  $$GradedPricesTableTableTableManager(
    _$AppDatabase db,
    $GradedPricesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GradedPricesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GradedPricesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GradedPricesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<String> gradingCompany = const Value.absent(),
                Value<String> grade = const Value.absent(),
                Value<double> marketPrice = const Value.absent(),
                Value<double?> lowPrice = const Value.absent(),
                Value<double?> highPrice = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GradedPricesTableCompanion(
                id: id,
                cardId: cardId,
                gradingCompany: gradingCompany,
                grade: grade,
                marketPrice: marketPrice,
                lowPrice: lowPrice,
                highPrice: highPrice,
                currency: currency,
                source: source,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cardId,
                required String gradingCompany,
                required String grade,
                required double marketPrice,
                Value<double?> lowPrice = const Value.absent(),
                Value<double?> highPrice = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> source = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => GradedPricesTableCompanion.insert(
                id: id,
                cardId: cardId,
                gradingCompany: gradingCompany,
                grade: grade,
                marketPrice: marketPrice,
                lowPrice: lowPrice,
                highPrice: highPrice,
                currency: currency,
                source: source,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GradedPricesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cardId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.cardId,
                        referencedTable: $$GradedPricesTableTableReferences
                            ._cardIdTable(db),
                        referencedColumn: $$GradedPricesTableTableReferences
                            ._cardIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GradedPricesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GradedPricesTableTable,
      GradedPricesTableData,
      $$GradedPricesTableTableFilterComposer,
      $$GradedPricesTableTableOrderingComposer,
      $$GradedPricesTableTableAnnotationComposer,
      $$GradedPricesTableTableCreateCompanionBuilder,
      $$GradedPricesTableTableUpdateCompanionBuilder,
      (GradedPricesTableData, $$GradedPricesTableTableReferences),
      GradedPricesTableData,
      PrefetchHooks Function({bool cardId})
    >;
typedef $$UserCardsTableTableCreateCompanionBuilder =
    UserCardsTableCompanion Function({
      required String id,
      Value<String> userId,
      required String cardId,
      Value<int> quantity,
      Value<String> condition,
      Value<String?> gradingCompany,
      Value<String?> grade,
      Value<String?> certNumber,
      Value<double?> purchasePrice,
      Value<DateTime?> purchaseDate,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserCardsTableTableUpdateCompanionBuilder =
    UserCardsTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> cardId,
      Value<int> quantity,
      Value<String> condition,
      Value<String?> gradingCompany,
      Value<String?> grade,
      Value<String?> certNumber,
      Value<double?> purchasePrice,
      Value<DateTime?> purchaseDate,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$UserCardsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $UserCardsTableTable,
          UserCardsTableData
        > {
  $$UserCardsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CardsTableTable _cardIdTable(_$AppDatabase db) =>
      db.cardsTable.createAlias('user_cards__card_id__cards__id');

  $$CardsTableTableProcessedTableManager get cardId {
    final $_column = $_itemColumn<String>('card_id')!;

    final manager = $$CardsTableTableTableManager(
      $_db,
      $_db.cardsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $CollectionItemsTableTable,
    List<CollectionItemsTableData>
  >
  _collectionItemsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionItemsTable,
        aliasName: 'user_cards__id__collection_items__user_card_id',
      );

  $$CollectionItemsTableTableProcessedTableManager
  get collectionItemsTableRefs {
    final manager = $$CollectionItemsTableTableTableManager(
      $_db,
      $_db.collectionItemsTable,
    ).filter((f) => f.userCardId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserCardsTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserCardsTableTable> {
  $$UserCardsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gradingCompany => $composableBuilder(
    column: $table.gradingCompany,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get certNumber => $composableBuilder(
    column: $table.certNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CardsTableTableFilterComposer get cardId {
    final $$CardsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableFilterComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> collectionItemsTableRefs(
    Expression<bool> Function($$CollectionItemsTableTableFilterComposer f) f,
  ) {
    final $$CollectionItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectionItemsTable,
      getReferencedColumn: (t) => t.userCardId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.collectionItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserCardsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserCardsTableTable> {
  $$UserCardsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gradingCompany => $composableBuilder(
    column: $table.gradingCompany,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grade => $composableBuilder(
    column: $table.grade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get certNumber => $composableBuilder(
    column: $table.certNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CardsTableTableOrderingComposer get cardId {
    final $$CardsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableOrderingComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserCardsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserCardsTableTable> {
  $$UserCardsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<String> get gradingCompany => $composableBuilder(
    column: $table.gradingCompany,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get certNumber => $composableBuilder(
    column: $table.certNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
    column: $table.purchasePrice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CardsTableTableAnnotationComposer get cardId {
    final $$CardsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cardId,
      referencedTable: $db.cardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CardsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.cardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> collectionItemsTableRefs<T extends Object>(
    Expression<T> Function($$CollectionItemsTableTableAnnotationComposer a) f,
  ) {
    final $$CollectionItemsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionItemsTable,
          getReferencedColumn: (t) => t.userCardId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionItemsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$UserCardsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserCardsTableTable,
          UserCardsTableData,
          $$UserCardsTableTableFilterComposer,
          $$UserCardsTableTableOrderingComposer,
          $$UserCardsTableTableAnnotationComposer,
          $$UserCardsTableTableCreateCompanionBuilder,
          $$UserCardsTableTableUpdateCompanionBuilder,
          (UserCardsTableData, $$UserCardsTableTableReferences),
          UserCardsTableData,
          PrefetchHooks Function({bool cardId, bool collectionItemsTableRefs})
        > {
  $$UserCardsTableTableTableManager(
    _$AppDatabase db,
    $UserCardsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserCardsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserCardsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserCardsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> cardId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<String?> gradingCompany = const Value.absent(),
                Value<String?> grade = const Value.absent(),
                Value<String?> certNumber = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserCardsTableCompanion(
                id: id,
                userId: userId,
                cardId: cardId,
                quantity: quantity,
                condition: condition,
                gradingCompany: gradingCompany,
                grade: grade,
                certNumber: certNumber,
                purchasePrice: purchasePrice,
                purchaseDate: purchaseDate,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> userId = const Value.absent(),
                required String cardId,
                Value<int> quantity = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<String?> gradingCompany = const Value.absent(),
                Value<String?> grade = const Value.absent(),
                Value<String?> certNumber = const Value.absent(),
                Value<double?> purchasePrice = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserCardsTableCompanion.insert(
                id: id,
                userId: userId,
                cardId: cardId,
                quantity: quantity,
                condition: condition,
                gradingCompany: gradingCompany,
                grade: grade,
                certNumber: certNumber,
                purchasePrice: purchasePrice,
                purchaseDate: purchaseDate,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserCardsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({cardId = false, collectionItemsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (collectionItemsTableRefs) db.collectionItemsTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (cardId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.cardId,
                            referencedTable: $$UserCardsTableTableReferences
                                ._cardIdTable(db),
                            referencedColumn: $$UserCardsTableTableReferences
                                ._cardIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (collectionItemsTableRefs)
                        await $_getPrefetchedData<
                          UserCardsTableData,
                          $UserCardsTableTable,
                          CollectionItemsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$UserCardsTableTableReferences
                              ._collectionItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserCardsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userCardId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UserCardsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserCardsTableTable,
      UserCardsTableData,
      $$UserCardsTableTableFilterComposer,
      $$UserCardsTableTableOrderingComposer,
      $$UserCardsTableTableAnnotationComposer,
      $$UserCardsTableTableCreateCompanionBuilder,
      $$UserCardsTableTableUpdateCompanionBuilder,
      (UserCardsTableData, $$UserCardsTableTableReferences),
      UserCardsTableData,
      PrefetchHooks Function({bool cardId, bool collectionItemsTableRefs})
    >;
typedef $$CollectionsTableTableCreateCompanionBuilder =
    CollectionsTableCompanion Function({
      required String id,
      Value<String> userId,
      required String name,
      Value<String?> description,
      required String type,
      Value<String?> targetSetId,
      Value<String?> targetArtist,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CollectionsTableTableUpdateCompanionBuilder =
    CollectionsTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> name,
      Value<String?> description,
      Value<String> type,
      Value<String?> targetSetId,
      Value<String?> targetArtist,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CollectionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectionsTableTable,
          CollectionsTableData
        > {
  $$CollectionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SetsTableTable _targetSetIdTable(_$AppDatabase db) =>
      db.setsTable.createAlias('collections__target_set_id__sets__id');

  $$SetsTableTableProcessedTableManager? get targetSetId {
    final $_column = $_itemColumn<String>('target_set_id');
    if ($_column == null) return null;
    final manager = $$SetsTableTableTableManager(
      $_db,
      $_db.setsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetSetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $CollectionItemsTableTable,
    List<CollectionItemsTableData>
  >
  _collectionItemsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.collectionItemsTable,
        aliasName: 'collections__id__collection_items__collection_id',
      );

  $$CollectionItemsTableTableProcessedTableManager
  get collectionItemsTableRefs {
    final manager = $$CollectionItemsTableTableTableManager(
      $_db,
      $_db.collectionItemsTable,
    ).filter((f) => f.collectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _collectionItemsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CollectionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionsTableTable> {
  $$CollectionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetArtist => $composableBuilder(
    column: $table.targetArtist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SetsTableTableFilterComposer get targetSetId {
    final $$SetsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetSetId,
      referencedTable: $db.setsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetsTableTableFilterComposer(
            $db: $db,
            $table: $db.setsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> collectionItemsTableRefs(
    Expression<bool> Function($$CollectionItemsTableTableFilterComposer f) f,
  ) {
    final $$CollectionItemsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.collectionItemsTable,
      getReferencedColumn: (t) => t.collectionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionItemsTableTableFilterComposer(
            $db: $db,
            $table: $db.collectionItemsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CollectionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionsTableTable> {
  $$CollectionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetArtist => $composableBuilder(
    column: $table.targetArtist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SetsTableTableOrderingComposer get targetSetId {
    final $$SetsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetSetId,
      referencedTable: $db.setsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetsTableTableOrderingComposer(
            $db: $db,
            $table: $db.setsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionsTableTable> {
  $$CollectionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get targetArtist => $composableBuilder(
    column: $table.targetArtist,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SetsTableTableAnnotationComposer get targetSetId {
    final $$SetsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetSetId,
      referencedTable: $db.setsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SetsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.setsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> collectionItemsTableRefs<T extends Object>(
    Expression<T> Function($$CollectionItemsTableTableAnnotationComposer a) f,
  ) {
    final $$CollectionItemsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.collectionItemsTable,
          getReferencedColumn: (t) => t.collectionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CollectionItemsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.collectionItemsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CollectionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionsTableTable,
          CollectionsTableData,
          $$CollectionsTableTableFilterComposer,
          $$CollectionsTableTableOrderingComposer,
          $$CollectionsTableTableAnnotationComposer,
          $$CollectionsTableTableCreateCompanionBuilder,
          $$CollectionsTableTableUpdateCompanionBuilder,
          (CollectionsTableData, $$CollectionsTableTableReferences),
          CollectionsTableData,
          PrefetchHooks Function({
            bool targetSetId,
            bool collectionItemsTableRefs,
          })
        > {
  $$CollectionsTableTableTableManager(
    _$AppDatabase db,
    $CollectionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CollectionsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> targetSetId = const Value.absent(),
                Value<String?> targetArtist = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CollectionsTableCompanion(
                id: id,
                userId: userId,
                name: name,
                description: description,
                type: type,
                targetSetId: targetSetId,
                targetArtist: targetArtist,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> userId = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required String type,
                Value<String?> targetSetId = const Value.absent(),
                Value<String?> targetArtist = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CollectionsTableCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                description: description,
                type: type,
                targetSetId: targetSetId,
                targetArtist: targetArtist,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({targetSetId = false, collectionItemsTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (collectionItemsTableRefs) db.collectionItemsTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (targetSetId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.targetSetId,
                            referencedTable: $$CollectionsTableTableReferences
                                ._targetSetIdTable(db),
                            referencedColumn: $$CollectionsTableTableReferences
                                ._targetSetIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (collectionItemsTableRefs)
                        await $_getPrefetchedData<
                          CollectionsTableData,
                          $CollectionsTableTable,
                          CollectionItemsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CollectionsTableTableReferences
                              ._collectionItemsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CollectionsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).collectionItemsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.collectionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CollectionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionsTableTable,
      CollectionsTableData,
      $$CollectionsTableTableFilterComposer,
      $$CollectionsTableTableOrderingComposer,
      $$CollectionsTableTableAnnotationComposer,
      $$CollectionsTableTableCreateCompanionBuilder,
      $$CollectionsTableTableUpdateCompanionBuilder,
      (CollectionsTableData, $$CollectionsTableTableReferences),
      CollectionsTableData,
      PrefetchHooks Function({bool targetSetId, bool collectionItemsTableRefs})
    >;
typedef $$CollectionItemsTableTableCreateCompanionBuilder =
    CollectionItemsTableCompanion Function({
      required String id,
      required String collectionId,
      required String userCardId,
      required DateTime addedAt,
      Value<int> rowid,
    });
typedef $$CollectionItemsTableTableUpdateCompanionBuilder =
    CollectionItemsTableCompanion Function({
      Value<String> id,
      Value<String> collectionId,
      Value<String> userCardId,
      Value<DateTime> addedAt,
      Value<int> rowid,
    });

final class $$CollectionItemsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CollectionItemsTableTable,
          CollectionItemsTableData
        > {
  $$CollectionItemsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CollectionsTableTable _collectionIdTable(_$AppDatabase db) => db
      .collectionsTable
      .createAlias('collection_items__collection_id__collections__id');

  $$CollectionsTableTableProcessedTableManager get collectionId {
    final $_column = $_itemColumn<String>('collection_id')!;

    final manager = $$CollectionsTableTableTableManager(
      $_db,
      $_db.collectionsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_collectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UserCardsTableTable _userCardIdTable(_$AppDatabase db) => db
      .userCardsTable
      .createAlias('collection_items__user_card_id__user_cards__id');

  $$UserCardsTableTableProcessedTableManager get userCardId {
    final $_column = $_itemColumn<String>('user_card_id')!;

    final manager = $$UserCardsTableTableTableManager(
      $_db,
      $_db.userCardsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userCardIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CollectionItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CollectionItemsTableTable> {
  $$CollectionItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CollectionsTableTableFilterComposer get collectionId {
    final $$CollectionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collectionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableTableFilterComposer(
            $db: $db,
            $table: $db.collectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserCardsTableTableFilterComposer get userCardId {
    final $$UserCardsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCardId,
      referencedTable: $db.userCardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserCardsTableTableFilterComposer(
            $db: $db,
            $table: $db.userCardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CollectionItemsTableTable> {
  $$CollectionItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CollectionsTableTableOrderingComposer get collectionId {
    final $$CollectionsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collectionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableTableOrderingComposer(
            $db: $db,
            $table: $db.collectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserCardsTableTableOrderingComposer get userCardId {
    final $$UserCardsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCardId,
      referencedTable: $db.userCardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserCardsTableTableOrderingComposer(
            $db: $db,
            $table: $db.userCardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CollectionItemsTableTable> {
  $$CollectionItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  $$CollectionsTableTableAnnotationComposer get collectionId {
    final $$CollectionsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.collectionId,
      referencedTable: $db.collectionsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CollectionsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.collectionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UserCardsTableTableAnnotationComposer get userCardId {
    final $$UserCardsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userCardId,
      referencedTable: $db.userCardsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserCardsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.userCardsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CollectionItemsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CollectionItemsTableTable,
          CollectionItemsTableData,
          $$CollectionItemsTableTableFilterComposer,
          $$CollectionItemsTableTableOrderingComposer,
          $$CollectionItemsTableTableAnnotationComposer,
          $$CollectionItemsTableTableCreateCompanionBuilder,
          $$CollectionItemsTableTableUpdateCompanionBuilder,
          (CollectionItemsTableData, $$CollectionItemsTableTableReferences),
          CollectionItemsTableData,
          PrefetchHooks Function({bool collectionId, bool userCardId})
        > {
  $$CollectionItemsTableTableTableManager(
    _$AppDatabase db,
    $CollectionItemsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CollectionItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CollectionItemsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CollectionItemsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> collectionId = const Value.absent(),
                Value<String> userCardId = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CollectionItemsTableCompanion(
                id: id,
                collectionId: collectionId,
                userCardId: userCardId,
                addedAt: addedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String collectionId,
                required String userCardId,
                required DateTime addedAt,
                Value<int> rowid = const Value.absent(),
              }) => CollectionItemsTableCompanion.insert(
                id: id,
                collectionId: collectionId,
                userCardId: userCardId,
                addedAt: addedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CollectionItemsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({collectionId = false, userCardId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (collectionId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.collectionId,
                        referencedTable: $$CollectionItemsTableTableReferences
                            ._collectionIdTable(db),
                        referencedColumn: $$CollectionItemsTableTableReferences
                            ._collectionIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (userCardId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userCardId,
                        referencedTable: $$CollectionItemsTableTableReferences
                            ._userCardIdTable(db),
                        referencedColumn: $$CollectionItemsTableTableReferences
                            ._userCardIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CollectionItemsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CollectionItemsTableTable,
      CollectionItemsTableData,
      $$CollectionItemsTableTableFilterComposer,
      $$CollectionItemsTableTableOrderingComposer,
      $$CollectionItemsTableTableAnnotationComposer,
      $$CollectionItemsTableTableCreateCompanionBuilder,
      $$CollectionItemsTableTableUpdateCompanionBuilder,
      (CollectionItemsTableData, $$CollectionItemsTableTableReferences),
      CollectionItemsTableData,
      PrefetchHooks Function({bool collectionId, bool userCardId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SetsTableTableTableManager get setsTable =>
      $$SetsTableTableTableManager(_db, _db.setsTable);
  $$CardsTableTableTableManager get cardsTable =>
      $$CardsTableTableTableManager(_db, _db.cardsTable);
  $$RawPricesTableTableTableManager get rawPricesTable =>
      $$RawPricesTableTableTableManager(_db, _db.rawPricesTable);
  $$GradedPricesTableTableTableManager get gradedPricesTable =>
      $$GradedPricesTableTableTableManager(_db, _db.gradedPricesTable);
  $$UserCardsTableTableTableManager get userCardsTable =>
      $$UserCardsTableTableTableManager(_db, _db.userCardsTable);
  $$CollectionsTableTableTableManager get collectionsTable =>
      $$CollectionsTableTableTableManager(_db, _db.collectionsTable);
  $$CollectionItemsTableTableTableManager get collectionItemsTable =>
      $$CollectionItemsTableTableTableManager(_db, _db.collectionItemsTable);
}
