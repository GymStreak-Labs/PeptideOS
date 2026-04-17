// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peptide.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPeptideCollection on Isar {
  IsarCollection<Peptide> get peptides => this.collection();
}

const PeptideSchema = CollectionSchema(
  name: r'Peptide',
  id: 584567578684853383,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
      enumMap: _PeptidecategoryEnumValueMap,
    ),
    r'commonStack': PropertySchema(
      id: 1,
      name: r'commonStack',
      type: IsarType.stringList,
    ),
    r'defaultDoseMcg': PropertySchema(
      id: 2,
      name: r'defaultDoseMcg',
      type: IsarType.double,
    ),
    r'defaultFrequency': PropertySchema(
      id: 3,
      name: r'defaultFrequency',
      type: IsarType.string,
    ),
    r'defaultRoute': PropertySchema(
      id: 4,
      name: r'defaultRoute',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 5,
      name: r'description',
      type: IsarType.string,
    ),
    r'disclaimer': PropertySchema(
      id: 6,
      name: r'disclaimer',
      type: IsarType.string,
    ),
    r'halfLife': PropertySchema(
      id: 7,
      name: r'halfLife',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 8,
      name: r'name',
      type: IsarType.string,
    ),
    r'notes': PropertySchema(
      id: 9,
      name: r'notes',
      type: IsarType.string,
    ),
    r'slug': PropertySchema(
      id: 10,
      name: r'slug',
      type: IsarType.string,
    ),
    r'typicalCycleWeeks': PropertySchema(
      id: 11,
      name: r'typicalCycleWeeks',
      type: IsarType.long,
    ),
    r'typicalDose': PropertySchema(
      id: 12,
      name: r'typicalDose',
      type: IsarType.string,
    )
  },
  estimateSize: _peptideEstimateSize,
  serialize: _peptideSerialize,
  deserialize: _peptideDeserialize,
  deserializeProp: _peptideDeserializeProp,
  idName: r'id',
  indexes: {
    r'slug': IndexSchema(
      id: 6169444064746062836,
      name: r'slug',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'slug',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _peptideGetId,
  getLinks: _peptideGetLinks,
  attach: _peptideAttach,
  version: '3.1.0+1',
);

int _peptideEstimateSize(
  Peptide object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.name.length * 3;
  bytesCount += 3 + object.commonStack.length * 3;
  {
    for (var i = 0; i < object.commonStack.length; i++) {
      final value = object.commonStack[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.defaultFrequency.length * 3;
  bytesCount += 3 + object.defaultRoute.length * 3;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.disclaimer.length * 3;
  bytesCount += 3 + object.halfLife.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.slug.length * 3;
  bytesCount += 3 + object.typicalDose.length * 3;
  return bytesCount;
}

void _peptideSerialize(
  Peptide object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category.name);
  writer.writeStringList(offsets[1], object.commonStack);
  writer.writeDouble(offsets[2], object.defaultDoseMcg);
  writer.writeString(offsets[3], object.defaultFrequency);
  writer.writeString(offsets[4], object.defaultRoute);
  writer.writeString(offsets[5], object.description);
  writer.writeString(offsets[6], object.disclaimer);
  writer.writeString(offsets[7], object.halfLife);
  writer.writeString(offsets[8], object.name);
  writer.writeString(offsets[9], object.notes);
  writer.writeString(offsets[10], object.slug);
  writer.writeLong(offsets[11], object.typicalCycleWeeks);
  writer.writeString(offsets[12], object.typicalDose);
}

Peptide _peptideDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Peptide();
  object.category =
      _PeptidecategoryValueEnumMap[reader.readStringOrNull(offsets[0])] ??
          PeptideCategory.healing;
  object.commonStack = reader.readStringList(offsets[1]) ?? [];
  object.defaultDoseMcg = reader.readDouble(offsets[2]);
  object.defaultFrequency = reader.readString(offsets[3]);
  object.defaultRoute = reader.readString(offsets[4]);
  object.description = reader.readString(offsets[5]);
  object.disclaimer = reader.readString(offsets[6]);
  object.halfLife = reader.readString(offsets[7]);
  object.id = id;
  object.name = reader.readString(offsets[8]);
  object.notes = reader.readString(offsets[9]);
  object.slug = reader.readString(offsets[10]);
  object.typicalCycleWeeks = reader.readLong(offsets[11]);
  object.typicalDose = reader.readString(offsets[12]);
  return object;
}

P _peptideDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_PeptidecategoryValueEnumMap[reader.readStringOrNull(offset)] ??
          PeptideCategory.healing) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PeptidecategoryEnumValueMap = {
  r'healing': r'healing',
  r'growthHormone': r'growthHormone',
  r'cognitive': r'cognitive',
  r'metabolic': r'metabolic',
  r'aesthetic': r'aesthetic',
  r'longevity': r'longevity',
  r'other': r'other',
};
const _PeptidecategoryValueEnumMap = {
  r'healing': PeptideCategory.healing,
  r'growthHormone': PeptideCategory.growthHormone,
  r'cognitive': PeptideCategory.cognitive,
  r'metabolic': PeptideCategory.metabolic,
  r'aesthetic': PeptideCategory.aesthetic,
  r'longevity': PeptideCategory.longevity,
  r'other': PeptideCategory.other,
};

Id _peptideGetId(Peptide object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _peptideGetLinks(Peptide object) {
  return [];
}

void _peptideAttach(IsarCollection<dynamic> col, Id id, Peptide object) {
  object.id = id;
}

extension PeptideByIndex on IsarCollection<Peptide> {
  Future<Peptide?> getBySlug(String slug) {
    return getByIndex(r'slug', [slug]);
  }

  Peptide? getBySlugSync(String slug) {
    return getByIndexSync(r'slug', [slug]);
  }

  Future<bool> deleteBySlug(String slug) {
    return deleteByIndex(r'slug', [slug]);
  }

  bool deleteBySlugSync(String slug) {
    return deleteByIndexSync(r'slug', [slug]);
  }

  Future<List<Peptide?>> getAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndex(r'slug', values);
  }

  List<Peptide?> getAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'slug', values);
  }

  Future<int> deleteAllBySlug(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'slug', values);
  }

  int deleteAllBySlugSync(List<String> slugValues) {
    final values = slugValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'slug', values);
  }

  Future<Id> putBySlug(Peptide object) {
    return putByIndex(r'slug', object);
  }

  Id putBySlugSync(Peptide object, {bool saveLinks = true}) {
    return putByIndexSync(r'slug', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllBySlug(List<Peptide> objects) {
    return putAllByIndex(r'slug', objects);
  }

  List<Id> putAllBySlugSync(List<Peptide> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'slug', objects, saveLinks: saveLinks);
  }
}

extension PeptideQueryWhereSort on QueryBuilder<Peptide, Peptide, QWhere> {
  QueryBuilder<Peptide, Peptide, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PeptideQueryWhere on QueryBuilder<Peptide, Peptide, QWhereClause> {
  QueryBuilder<Peptide, Peptide, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Peptide, Peptide, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterWhereClause> idBetween(
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

  QueryBuilder<Peptide, Peptide, QAfterWhereClause> slugEqualTo(String slug) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'slug',
        value: [slug],
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterWhereClause> slugNotEqualTo(
      String slug) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'slug',
              lower: [],
              upper: [slug],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'slug',
              lower: [slug],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'slug',
              lower: [slug],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'slug',
              lower: [],
              upper: [slug],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PeptideQueryFilter
    on QueryBuilder<Peptide, Peptide, QFilterCondition> {
  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> categoryEqualTo(
    PeptideCategory value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> categoryGreaterThan(
    PeptideCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> categoryLessThan(
    PeptideCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> categoryBetween(
    PeptideCategory lower,
    PeptideCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> categoryContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commonStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'commonStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'commonStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'commonStack',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'commonStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'commonStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'commonStack',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'commonStack',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'commonStack',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'commonStack',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonStack',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> commonStackIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonStack',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonStack',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonStack',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonStack',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      commonStackLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'commonStack',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultDoseMcgEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultDoseMcg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      defaultDoseMcgGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultDoseMcg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultDoseMcgLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultDoseMcg',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultDoseMcgBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultDoseMcg',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultFrequencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultFrequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      defaultFrequencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultFrequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      defaultFrequencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultFrequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultFrequencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultFrequency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      defaultFrequencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultFrequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      defaultFrequencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultFrequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      defaultFrequencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultFrequency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultFrequencyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultFrequency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      defaultFrequencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultFrequency',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      defaultFrequencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultFrequency',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultRouteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultRoute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultRouteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultRoute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultRouteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultRoute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultRouteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultRoute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultRouteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'defaultRoute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultRouteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'defaultRoute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultRouteContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'defaultRoute',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultRouteMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'defaultRoute',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> defaultRouteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultRoute',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      defaultRouteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'defaultRoute',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> disclaimerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'disclaimer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> disclaimerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'disclaimer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> disclaimerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'disclaimer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> disclaimerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'disclaimer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> disclaimerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'disclaimer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> disclaimerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'disclaimer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> disclaimerContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'disclaimer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> disclaimerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'disclaimer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> disclaimerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'disclaimer',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> disclaimerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'disclaimer',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> halfLifeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'halfLife',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> halfLifeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'halfLife',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> halfLifeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'halfLife',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> halfLifeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'halfLife',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> halfLifeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'halfLife',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> halfLifeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'halfLife',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> halfLifeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'halfLife',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> halfLifeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'halfLife',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> halfLifeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'halfLife',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> halfLifeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'halfLife',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> notesEqualTo(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> notesGreaterThan(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> notesLessThan(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> notesBetween(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> notesStartsWith(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> notesEndsWith(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> notesContains(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> notesMatches(
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

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> slugEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> slugGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> slugLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> slugBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'slug',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> slugStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> slugEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> slugContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'slug',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> slugMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'slug',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> slugIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'slug',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> slugIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'slug',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      typicalCycleWeeksEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typicalCycleWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      typicalCycleWeeksGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'typicalCycleWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      typicalCycleWeeksLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'typicalCycleWeeks',
        value: value,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      typicalCycleWeeksBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'typicalCycleWeeks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> typicalDoseEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typicalDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> typicalDoseGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'typicalDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> typicalDoseLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'typicalDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> typicalDoseBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'typicalDose',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> typicalDoseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'typicalDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> typicalDoseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'typicalDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> typicalDoseContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'typicalDose',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> typicalDoseMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'typicalDose',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition> typicalDoseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'typicalDose',
        value: '',
      ));
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterFilterCondition>
      typicalDoseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'typicalDose',
        value: '',
      ));
    });
  }
}

extension PeptideQueryObject
    on QueryBuilder<Peptide, Peptide, QFilterCondition> {}

extension PeptideQueryLinks
    on QueryBuilder<Peptide, Peptide, QFilterCondition> {}

extension PeptideQuerySortBy on QueryBuilder<Peptide, Peptide, QSortBy> {
  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByDefaultDoseMcg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultDoseMcg', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByDefaultDoseMcgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultDoseMcg', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByDefaultFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultFrequency', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByDefaultFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultFrequency', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByDefaultRoute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultRoute', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByDefaultRouteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultRoute', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByDisclaimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disclaimer', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByDisclaimerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disclaimer', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByHalfLife() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'halfLife', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByHalfLifeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'halfLife', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByTypicalCycleWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typicalCycleWeeks', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByTypicalCycleWeeksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typicalCycleWeeks', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByTypicalDose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typicalDose', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> sortByTypicalDoseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typicalDose', Sort.desc);
    });
  }
}

extension PeptideQuerySortThenBy
    on QueryBuilder<Peptide, Peptide, QSortThenBy> {
  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByDefaultDoseMcg() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultDoseMcg', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByDefaultDoseMcgDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultDoseMcg', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByDefaultFrequency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultFrequency', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByDefaultFrequencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultFrequency', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByDefaultRoute() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultRoute', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByDefaultRouteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultRoute', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByDisclaimer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disclaimer', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByDisclaimerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'disclaimer', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByHalfLife() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'halfLife', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByHalfLifeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'halfLife', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenBySlug() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenBySlugDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'slug', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByTypicalCycleWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typicalCycleWeeks', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByTypicalCycleWeeksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typicalCycleWeeks', Sort.desc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByTypicalDose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typicalDose', Sort.asc);
    });
  }

  QueryBuilder<Peptide, Peptide, QAfterSortBy> thenByTypicalDoseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'typicalDose', Sort.desc);
    });
  }
}

extension PeptideQueryWhereDistinct
    on QueryBuilder<Peptide, Peptide, QDistinct> {
  QueryBuilder<Peptide, Peptide, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByCommonStack() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'commonStack');
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByDefaultDoseMcg() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultDoseMcg');
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByDefaultFrequency(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultFrequency',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByDefaultRoute(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultRoute', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByDisclaimer(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'disclaimer', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByHalfLife(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'halfLife', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctBySlug(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'slug', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByTypicalCycleWeeks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typicalCycleWeeks');
    });
  }

  QueryBuilder<Peptide, Peptide, QDistinct> distinctByTypicalDose(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'typicalDose', caseSensitive: caseSensitive);
    });
  }
}

extension PeptideQueryProperty
    on QueryBuilder<Peptide, Peptide, QQueryProperty> {
  QueryBuilder<Peptide, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Peptide, PeptideCategory, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<Peptide, List<String>, QQueryOperations> commonStackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'commonStack');
    });
  }

  QueryBuilder<Peptide, double, QQueryOperations> defaultDoseMcgProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultDoseMcg');
    });
  }

  QueryBuilder<Peptide, String, QQueryOperations> defaultFrequencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultFrequency');
    });
  }

  QueryBuilder<Peptide, String, QQueryOperations> defaultRouteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultRoute');
    });
  }

  QueryBuilder<Peptide, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Peptide, String, QQueryOperations> disclaimerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'disclaimer');
    });
  }

  QueryBuilder<Peptide, String, QQueryOperations> halfLifeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'halfLife');
    });
  }

  QueryBuilder<Peptide, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Peptide, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<Peptide, String, QQueryOperations> slugProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'slug');
    });
  }

  QueryBuilder<Peptide, int, QQueryOperations> typicalCycleWeeksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typicalCycleWeeks');
    });
  }

  QueryBuilder<Peptide, String, QQueryOperations> typicalDoseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'typicalDose');
    });
  }
}
