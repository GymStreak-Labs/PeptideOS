// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dose_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDoseLogCollection on Isar {
  IsarCollection<DoseLog> get doseLogs => this.collection();
}

const DoseLogSchema = CollectionSchema(
  name: r'DoseLog',
  id: -6875638677250359335,
  properties: {
    r'amountTaken': PropertySchema(
      id: 0,
      name: r'amountTaken',
      type: IsarType.double,
    ),
    r'injectionSite': PropertySchema(
      id: 1,
      name: r'injectionSite',
      type: IsarType.string,
    ),
    r'isPending': PropertySchema(
      id: 2,
      name: r'isPending',
      type: IsarType.bool,
    ),
    r'isTaken': PropertySchema(
      id: 3,
      name: r'isTaken',
      type: IsarType.bool,
    ),
    r'notes': PropertySchema(
      id: 4,
      name: r'notes',
      type: IsarType.string,
    ),
    r'peptideName': PropertySchema(
      id: 5,
      name: r'peptideName',
      type: IsarType.string,
    ),
    r'protocolPeptideUuid': PropertySchema(
      id: 6,
      name: r'protocolPeptideUuid',
      type: IsarType.string,
    ),
    r'protocolUuid': PropertySchema(
      id: 7,
      name: r'protocolUuid',
      type: IsarType.string,
    ),
    r'scheduledAt': PropertySchema(
      id: 8,
      name: r'scheduledAt',
      type: IsarType.dateTime,
    ),
    r'skipped': PropertySchema(
      id: 9,
      name: r'skipped',
      type: IsarType.bool,
    ),
    r'takenAt': PropertySchema(
      id: 10,
      name: r'takenAt',
      type: IsarType.dateTime,
    ),
    r'units': PropertySchema(
      id: 11,
      name: r'units',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 12,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _doseLogEstimateSize,
  serialize: _doseLogSerialize,
  deserialize: _doseLogDeserialize,
  deserializeProp: _doseLogDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'protocolUuid': IndexSchema(
      id: -4000142618922299562,
      name: r'protocolUuid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'protocolUuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'protocolPeptideUuid': IndexSchema(
      id: 7244915941777255915,
      name: r'protocolPeptideUuid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'protocolPeptideUuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'scheduledAt': IndexSchema(
      id: -1483275037155116518,
      name: r'scheduledAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'scheduledAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _doseLogGetId,
  getLinks: _doseLogGetLinks,
  attach: _doseLogAttach,
  version: '3.1.0+1',
);

int _doseLogEstimateSize(
  DoseLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.injectionSite.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.peptideName.length * 3;
  bytesCount += 3 + object.protocolPeptideUuid.length * 3;
  bytesCount += 3 + object.protocolUuid.length * 3;
  bytesCount += 3 + object.units.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _doseLogSerialize(
  DoseLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amountTaken);
  writer.writeString(offsets[1], object.injectionSite);
  writer.writeBool(offsets[2], object.isPending);
  writer.writeBool(offsets[3], object.isTaken);
  writer.writeString(offsets[4], object.notes);
  writer.writeString(offsets[5], object.peptideName);
  writer.writeString(offsets[6], object.protocolPeptideUuid);
  writer.writeString(offsets[7], object.protocolUuid);
  writer.writeDateTime(offsets[8], object.scheduledAt);
  writer.writeBool(offsets[9], object.skipped);
  writer.writeDateTime(offsets[10], object.takenAt);
  writer.writeString(offsets[11], object.units);
  writer.writeString(offsets[12], object.uuid);
}

DoseLog _doseLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DoseLog();
  object.amountTaken = reader.readDouble(offsets[0]);
  object.id = id;
  object.injectionSite = reader.readString(offsets[1]);
  object.notes = reader.readString(offsets[4]);
  object.peptideName = reader.readString(offsets[5]);
  object.protocolPeptideUuid = reader.readString(offsets[6]);
  object.protocolUuid = reader.readString(offsets[7]);
  object.scheduledAt = reader.readDateTime(offsets[8]);
  object.skipped = reader.readBool(offsets[9]);
  object.takenAt = reader.readDateTimeOrNull(offsets[10]);
  object.units = reader.readString(offsets[11]);
  object.uuid = reader.readString(offsets[12]);
  return object;
}

P _doseLogDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _doseLogGetId(DoseLog object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _doseLogGetLinks(DoseLog object) {
  return [];
}

void _doseLogAttach(IsarCollection<dynamic> col, Id id, DoseLog object) {
  object.id = id;
}

extension DoseLogByIndex on IsarCollection<DoseLog> {
  Future<DoseLog?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  DoseLog? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<DoseLog?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<DoseLog?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(DoseLog object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(DoseLog object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<DoseLog> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<DoseLog> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension DoseLogQueryWhereSort on QueryBuilder<DoseLog, DoseLog, QWhere> {
  QueryBuilder<DoseLog, DoseLog, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhere> anyScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'scheduledAt'),
      );
    });
  }
}

extension DoseLogQueryWhere on QueryBuilder<DoseLog, DoseLog, QWhereClause> {
  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> uuidNotEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> protocolUuidEqualTo(
      String protocolUuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'protocolUuid',
        value: [protocolUuid],
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> protocolUuidNotEqualTo(
      String protocolUuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'protocolUuid',
              lower: [],
              upper: [protocolUuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'protocolUuid',
              lower: [protocolUuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'protocolUuid',
              lower: [protocolUuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'protocolUuid',
              lower: [],
              upper: [protocolUuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> protocolPeptideUuidEqualTo(
      String protocolPeptideUuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'protocolPeptideUuid',
        value: [protocolPeptideUuid],
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause>
      protocolPeptideUuidNotEqualTo(String protocolPeptideUuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'protocolPeptideUuid',
              lower: [],
              upper: [protocolPeptideUuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'protocolPeptideUuid',
              lower: [protocolPeptideUuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'protocolPeptideUuid',
              lower: [protocolPeptideUuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'protocolPeptideUuid',
              lower: [],
              upper: [protocolPeptideUuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> scheduledAtEqualTo(
      DateTime scheduledAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'scheduledAt',
        value: [scheduledAt],
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> scheduledAtNotEqualTo(
      DateTime scheduledAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scheduledAt',
              lower: [],
              upper: [scheduledAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scheduledAt',
              lower: [scheduledAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scheduledAt',
              lower: [scheduledAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'scheduledAt',
              lower: [],
              upper: [scheduledAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> scheduledAtGreaterThan(
    DateTime scheduledAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'scheduledAt',
        lower: [scheduledAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> scheduledAtLessThan(
    DateTime scheduledAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'scheduledAt',
        lower: [],
        upper: [scheduledAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterWhereClause> scheduledAtBetween(
    DateTime lowerScheduledAt,
    DateTime upperScheduledAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'scheduledAt',
        lower: [lowerScheduledAt],
        includeLower: includeLower,
        upper: [upperScheduledAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DoseLogQueryFilter
    on QueryBuilder<DoseLog, DoseLog, QFilterCondition> {
  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> amountTakenEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountTaken',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> amountTakenGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountTaken',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> amountTakenLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountTaken',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> amountTakenBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountTaken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> injectionSiteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'injectionSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      injectionSiteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'injectionSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> injectionSiteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'injectionSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> injectionSiteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'injectionSite',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> injectionSiteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'injectionSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> injectionSiteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'injectionSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> injectionSiteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'injectionSite',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> injectionSiteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'injectionSite',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> injectionSiteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'injectionSite',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      injectionSiteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'injectionSite',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> isPendingEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPending',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> isTakenEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isTaken',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> notesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> notesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> peptideNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peptideName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> peptideNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'peptideName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> peptideNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'peptideName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> peptideNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'peptideName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> peptideNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'peptideName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> peptideNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'peptideName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> peptideNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'peptideName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> peptideNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'peptideName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> peptideNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peptideName',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      peptideNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'peptideName',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolPeptideUuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protocolPeptideUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolPeptideUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'protocolPeptideUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolPeptideUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'protocolPeptideUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolPeptideUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'protocolPeptideUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolPeptideUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'protocolPeptideUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolPeptideUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'protocolPeptideUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolPeptideUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'protocolPeptideUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolPeptideUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'protocolPeptideUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolPeptideUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protocolPeptideUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolPeptideUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'protocolPeptideUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> protocolUuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protocolUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> protocolUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'protocolUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> protocolUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'protocolUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> protocolUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'protocolUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> protocolUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'protocolUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> protocolUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'protocolUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> protocolUuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'protocolUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> protocolUuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'protocolUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> protocolUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protocolUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition>
      protocolUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'protocolUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> scheduledAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduledAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> scheduledAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduledAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> scheduledAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduledAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> scheduledAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduledAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> skippedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'skipped',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> takenAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'takenAt',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> takenAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'takenAt',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> takenAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'takenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> takenAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'takenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> takenAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'takenAt',
        value: value,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> takenAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'takenAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> unitsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'units',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> unitsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'units',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> unitsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'units',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> unitsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'units',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> unitsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'units',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> unitsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'units',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> unitsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'units',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> unitsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'units',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> unitsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'units',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> unitsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'units',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension DoseLogQueryObject
    on QueryBuilder<DoseLog, DoseLog, QFilterCondition> {}

extension DoseLogQueryLinks
    on QueryBuilder<DoseLog, DoseLog, QFilterCondition> {}

extension DoseLogQuerySortBy on QueryBuilder<DoseLog, DoseLog, QSortBy> {
  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByAmountTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTaken', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByAmountTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTaken', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByInjectionSite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injectionSite', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByInjectionSiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injectionSite', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByIsPending() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPending', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByIsPendingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPending', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByIsTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTaken', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByIsTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTaken', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByPeptideName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peptideName', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByPeptideNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peptideName', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByProtocolPeptideUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protocolPeptideUuid', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByProtocolPeptideUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protocolPeptideUuid', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByProtocolUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protocolUuid', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByProtocolUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protocolUuid', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByScheduledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortBySkipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipped', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortBySkippedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipped', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByTakenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByUnits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'units', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByUnitsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'units', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DoseLogQuerySortThenBy
    on QueryBuilder<DoseLog, DoseLog, QSortThenBy> {
  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByAmountTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTaken', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByAmountTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTaken', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByInjectionSite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injectionSite', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByInjectionSiteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'injectionSite', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByIsPending() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPending', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByIsPendingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPending', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByIsTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTaken', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByIsTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isTaken', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByPeptideName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peptideName', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByPeptideNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peptideName', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByProtocolPeptideUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protocolPeptideUuid', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByProtocolPeptideUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protocolPeptideUuid', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByProtocolUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protocolUuid', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByProtocolUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protocolUuid', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByScheduledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenBySkipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipped', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenBySkippedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'skipped', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByTakenAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAt', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByUnits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'units', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByUnitsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'units', Sort.desc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension DoseLogQueryWhereDistinct
    on QueryBuilder<DoseLog, DoseLog, QDistinct> {
  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByAmountTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountTaken');
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByInjectionSite(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'injectionSite',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByIsPending() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPending');
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByIsTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isTaken');
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByPeptideName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peptideName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByProtocolPeptideUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'protocolPeptideUuid',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByProtocolUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'protocolUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledAt');
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctBySkipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'skipped');
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByTakenAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'takenAt');
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByUnits(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'units', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DoseLog, DoseLog, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension DoseLogQueryProperty
    on QueryBuilder<DoseLog, DoseLog, QQueryProperty> {
  QueryBuilder<DoseLog, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DoseLog, double, QQueryOperations> amountTakenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountTaken');
    });
  }

  QueryBuilder<DoseLog, String, QQueryOperations> injectionSiteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'injectionSite');
    });
  }

  QueryBuilder<DoseLog, bool, QQueryOperations> isPendingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPending');
    });
  }

  QueryBuilder<DoseLog, bool, QQueryOperations> isTakenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isTaken');
    });
  }

  QueryBuilder<DoseLog, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<DoseLog, String, QQueryOperations> peptideNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peptideName');
    });
  }

  QueryBuilder<DoseLog, String, QQueryOperations>
      protocolPeptideUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'protocolPeptideUuid');
    });
  }

  QueryBuilder<DoseLog, String, QQueryOperations> protocolUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'protocolUuid');
    });
  }

  QueryBuilder<DoseLog, DateTime, QQueryOperations> scheduledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledAt');
    });
  }

  QueryBuilder<DoseLog, bool, QQueryOperations> skippedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'skipped');
    });
  }

  QueryBuilder<DoseLog, DateTime?, QQueryOperations> takenAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'takenAt');
    });
  }

  QueryBuilder<DoseLog, String, QQueryOperations> unitsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'units');
    });
  }

  QueryBuilder<DoseLog, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
