// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProducoesTable extends Producoes
    with TableInfo<$ProducoesTable, Producao> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProducoesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _talhaoMeta = const VerificationMeta('talhao');
  @override
  late final GeneratedColumn<String> talhao = GeneratedColumn<String>(
    'talhao',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maquinaMeta = const VerificationMeta(
    'maquina',
  );
  @override
  late final GeneratedColumn<String> maquina = GeneratedColumn<String>(
    'maquina',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _culturaMeta = const VerificationMeta(
    'cultura',
  );
  @override
  late final GeneratedColumn<String> cultura = GeneratedColumn<String>(
    'cultura',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pesoEstimadoMeta = const VerificationMeta(
    'pesoEstimado',
  );
  @override
  late final GeneratedColumn<double> pesoEstimado = GeneratedColumn<double>(
    'peso_estimado',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gpsCoordenadasMeta = const VerificationMeta(
    'gpsCoordenadas',
  );
  @override
  late final GeneratedColumn<String> gpsCoordenadas = GeneratedColumn<String>(
    'gps_coordenadas',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dataHoraMeta = const VerificationMeta(
    'dataHora',
  );
  @override
  late final GeneratedColumn<DateTime> dataHora = GeneratedColumn<DateTime>(
    'data_hora',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sincronizadoMeta = const VerificationMeta(
    'sincronizado',
  );
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
    'sincronizado',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sincronizado" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    talhao,
    maquina,
    cultura,
    pesoEstimado,
    gpsCoordenadas,
    dataHora,
    sincronizado,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'producoes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Producao> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('talhao')) {
      context.handle(
        _talhaoMeta,
        talhao.isAcceptableOrUnknown(data['talhao']!, _talhaoMeta),
      );
    } else if (isInserting) {
      context.missing(_talhaoMeta);
    }
    if (data.containsKey('maquina')) {
      context.handle(
        _maquinaMeta,
        maquina.isAcceptableOrUnknown(data['maquina']!, _maquinaMeta),
      );
    } else if (isInserting) {
      context.missing(_maquinaMeta);
    }
    if (data.containsKey('cultura')) {
      context.handle(
        _culturaMeta,
        cultura.isAcceptableOrUnknown(data['cultura']!, _culturaMeta),
      );
    } else if (isInserting) {
      context.missing(_culturaMeta);
    }
    if (data.containsKey('peso_estimado')) {
      context.handle(
        _pesoEstimadoMeta,
        pesoEstimado.isAcceptableOrUnknown(
          data['peso_estimado']!,
          _pesoEstimadoMeta,
        ),
      );
    }
    if (data.containsKey('gps_coordenadas')) {
      context.handle(
        _gpsCoordenadasMeta,
        gpsCoordenadas.isAcceptableOrUnknown(
          data['gps_coordenadas']!,
          _gpsCoordenadasMeta,
        ),
      );
    }
    if (data.containsKey('data_hora')) {
      context.handle(
        _dataHoraMeta,
        dataHora.isAcceptableOrUnknown(data['data_hora']!, _dataHoraMeta),
      );
    } else if (isInserting) {
      context.missing(_dataHoraMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
        _sincronizadoMeta,
        sincronizado.isAcceptableOrUnknown(
          data['sincronizado']!,
          _sincronizadoMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Producao map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Producao(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      talhao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}talhao'],
      )!,
      maquina: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}maquina'],
      )!,
      cultura: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cultura'],
      )!,
      pesoEstimado: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}peso_estimado'],
      ),
      gpsCoordenadas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gps_coordenadas'],
      ),
      dataHora: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data_hora'],
      )!,
      sincronizado: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sincronizado'],
      )!,
    );
  }

  @override
  $ProducoesTable createAlias(String alias) {
    return $ProducoesTable(attachedDatabase, alias);
  }
}

class Producao extends DataClass implements Insertable<Producao> {
  final String id;
  final String talhao;
  final String maquina;
  final String cultura;
  final double? pesoEstimado;
  final String? gpsCoordenadas;
  final DateTime dataHora;
  final bool sincronizado;
  const Producao({
    required this.id,
    required this.talhao,
    required this.maquina,
    required this.cultura,
    this.pesoEstimado,
    this.gpsCoordenadas,
    required this.dataHora,
    required this.sincronizado,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['talhao'] = Variable<String>(talhao);
    map['maquina'] = Variable<String>(maquina);
    map['cultura'] = Variable<String>(cultura);
    if (!nullToAbsent || pesoEstimado != null) {
      map['peso_estimado'] = Variable<double>(pesoEstimado);
    }
    if (!nullToAbsent || gpsCoordenadas != null) {
      map['gps_coordenadas'] = Variable<String>(gpsCoordenadas);
    }
    map['data_hora'] = Variable<DateTime>(dataHora);
    map['sincronizado'] = Variable<bool>(sincronizado);
    return map;
  }

  ProducoesCompanion toCompanion(bool nullToAbsent) {
    return ProducoesCompanion(
      id: Value(id),
      talhao: Value(talhao),
      maquina: Value(maquina),
      cultura: Value(cultura),
      pesoEstimado: pesoEstimado == null && nullToAbsent
          ? const Value.absent()
          : Value(pesoEstimado),
      gpsCoordenadas: gpsCoordenadas == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsCoordenadas),
      dataHora: Value(dataHora),
      sincronizado: Value(sincronizado),
    );
  }

  factory Producao.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Producao(
      id: serializer.fromJson<String>(json['id']),
      talhao: serializer.fromJson<String>(json['talhao']),
      maquina: serializer.fromJson<String>(json['maquina']),
      cultura: serializer.fromJson<String>(json['cultura']),
      pesoEstimado: serializer.fromJson<double?>(json['pesoEstimado']),
      gpsCoordenadas: serializer.fromJson<String?>(json['gpsCoordenadas']),
      dataHora: serializer.fromJson<DateTime>(json['dataHora']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'talhao': serializer.toJson<String>(talhao),
      'maquina': serializer.toJson<String>(maquina),
      'cultura': serializer.toJson<String>(cultura),
      'pesoEstimado': serializer.toJson<double?>(pesoEstimado),
      'gpsCoordenadas': serializer.toJson<String?>(gpsCoordenadas),
      'dataHora': serializer.toJson<DateTime>(dataHora),
      'sincronizado': serializer.toJson<bool>(sincronizado),
    };
  }

  Producao copyWith({
    String? id,
    String? talhao,
    String? maquina,
    String? cultura,
    Value<double?> pesoEstimado = const Value.absent(),
    Value<String?> gpsCoordenadas = const Value.absent(),
    DateTime? dataHora,
    bool? sincronizado,
  }) => Producao(
    id: id ?? this.id,
    talhao: talhao ?? this.talhao,
    maquina: maquina ?? this.maquina,
    cultura: cultura ?? this.cultura,
    pesoEstimado: pesoEstimado.present ? pesoEstimado.value : this.pesoEstimado,
    gpsCoordenadas: gpsCoordenadas.present
        ? gpsCoordenadas.value
        : this.gpsCoordenadas,
    dataHora: dataHora ?? this.dataHora,
    sincronizado: sincronizado ?? this.sincronizado,
  );
  Producao copyWithCompanion(ProducoesCompanion data) {
    return Producao(
      id: data.id.present ? data.id.value : this.id,
      talhao: data.talhao.present ? data.talhao.value : this.talhao,
      maquina: data.maquina.present ? data.maquina.value : this.maquina,
      cultura: data.cultura.present ? data.cultura.value : this.cultura,
      pesoEstimado: data.pesoEstimado.present
          ? data.pesoEstimado.value
          : this.pesoEstimado,
      gpsCoordenadas: data.gpsCoordenadas.present
          ? data.gpsCoordenadas.value
          : this.gpsCoordenadas,
      dataHora: data.dataHora.present ? data.dataHora.value : this.dataHora,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Producao(')
          ..write('id: $id, ')
          ..write('talhao: $talhao, ')
          ..write('maquina: $maquina, ')
          ..write('cultura: $cultura, ')
          ..write('pesoEstimado: $pesoEstimado, ')
          ..write('gpsCoordenadas: $gpsCoordenadas, ')
          ..write('dataHora: $dataHora, ')
          ..write('sincronizado: $sincronizado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    talhao,
    maquina,
    cultura,
    pesoEstimado,
    gpsCoordenadas,
    dataHora,
    sincronizado,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Producao &&
          other.id == this.id &&
          other.talhao == this.talhao &&
          other.maquina == this.maquina &&
          other.cultura == this.cultura &&
          other.pesoEstimado == this.pesoEstimado &&
          other.gpsCoordenadas == this.gpsCoordenadas &&
          other.dataHora == this.dataHora &&
          other.sincronizado == this.sincronizado);
}

class ProducoesCompanion extends UpdateCompanion<Producao> {
  final Value<String> id;
  final Value<String> talhao;
  final Value<String> maquina;
  final Value<String> cultura;
  final Value<double?> pesoEstimado;
  final Value<String?> gpsCoordenadas;
  final Value<DateTime> dataHora;
  final Value<bool> sincronizado;
  final Value<int> rowid;
  const ProducoesCompanion({
    this.id = const Value.absent(),
    this.talhao = const Value.absent(),
    this.maquina = const Value.absent(),
    this.cultura = const Value.absent(),
    this.pesoEstimado = const Value.absent(),
    this.gpsCoordenadas = const Value.absent(),
    this.dataHora = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProducoesCompanion.insert({
    required String id,
    required String talhao,
    required String maquina,
    required String cultura,
    this.pesoEstimado = const Value.absent(),
    this.gpsCoordenadas = const Value.absent(),
    required DateTime dataHora,
    this.sincronizado = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       talhao = Value(talhao),
       maquina = Value(maquina),
       cultura = Value(cultura),
       dataHora = Value(dataHora);
  static Insertable<Producao> custom({
    Expression<String>? id,
    Expression<String>? talhao,
    Expression<String>? maquina,
    Expression<String>? cultura,
    Expression<double>? pesoEstimado,
    Expression<String>? gpsCoordenadas,
    Expression<DateTime>? dataHora,
    Expression<bool>? sincronizado,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (talhao != null) 'talhao': talhao,
      if (maquina != null) 'maquina': maquina,
      if (cultura != null) 'cultura': cultura,
      if (pesoEstimado != null) 'peso_estimado': pesoEstimado,
      if (gpsCoordenadas != null) 'gps_coordenadas': gpsCoordenadas,
      if (dataHora != null) 'data_hora': dataHora,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProducoesCompanion copyWith({
    Value<String>? id,
    Value<String>? talhao,
    Value<String>? maquina,
    Value<String>? cultura,
    Value<double?>? pesoEstimado,
    Value<String?>? gpsCoordenadas,
    Value<DateTime>? dataHora,
    Value<bool>? sincronizado,
    Value<int>? rowid,
  }) {
    return ProducoesCompanion(
      id: id ?? this.id,
      talhao: talhao ?? this.talhao,
      maquina: maquina ?? this.maquina,
      cultura: cultura ?? this.cultura,
      pesoEstimado: pesoEstimado ?? this.pesoEstimado,
      gpsCoordenadas: gpsCoordenadas ?? this.gpsCoordenadas,
      dataHora: dataHora ?? this.dataHora,
      sincronizado: sincronizado ?? this.sincronizado,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (talhao.present) {
      map['talhao'] = Variable<String>(talhao.value);
    }
    if (maquina.present) {
      map['maquina'] = Variable<String>(maquina.value);
    }
    if (cultura.present) {
      map['cultura'] = Variable<String>(cultura.value);
    }
    if (pesoEstimado.present) {
      map['peso_estimado'] = Variable<double>(pesoEstimado.value);
    }
    if (gpsCoordenadas.present) {
      map['gps_coordenadas'] = Variable<String>(gpsCoordenadas.value);
    }
    if (dataHora.present) {
      map['data_hora'] = Variable<DateTime>(dataHora.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProducoesCompanion(')
          ..write('id: $id, ')
          ..write('talhao: $talhao, ')
          ..write('maquina: $maquina, ')
          ..write('cultura: $cultura, ')
          ..write('pesoEstimado: $pesoEstimado, ')
          ..write('gpsCoordenadas: $gpsCoordenadas, ')
          ..write('dataHora: $dataHora, ')
          ..write('sincronizado: $sincronizado, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProducoesTable producoes = $ProducoesTable(this);
  late final Index idxProducaoTalhao = Index(
    'idx_producao_talhao',
    'CREATE INDEX idx_producao_talhao ON producoes (talhao)',
  );
  late final Index idxProducaoData = Index(
    'idx_producao_data',
    'CREATE INDEX idx_producao_data ON producoes (data_hora)',
  );
  late final ProducoesDao producoesDao = ProducoesDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    producoes,
    idxProducaoTalhao,
    idxProducaoData,
  ];
}

typedef $$ProducoesTableCreateCompanionBuilder =
    ProducoesCompanion Function({
      required String id,
      required String talhao,
      required String maquina,
      required String cultura,
      Value<double?> pesoEstimado,
      Value<String?> gpsCoordenadas,
      required DateTime dataHora,
      Value<bool> sincronizado,
      Value<int> rowid,
    });
typedef $$ProducoesTableUpdateCompanionBuilder =
    ProducoesCompanion Function({
      Value<String> id,
      Value<String> talhao,
      Value<String> maquina,
      Value<String> cultura,
      Value<double?> pesoEstimado,
      Value<String?> gpsCoordenadas,
      Value<DateTime> dataHora,
      Value<bool> sincronizado,
      Value<int> rowid,
    });

class $$ProducoesTableFilterComposer
    extends Composer<_$AppDatabase, $ProducoesTable> {
  $$ProducoesTableFilterComposer({
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

  ColumnFilters<String> get talhao => $composableBuilder(
    column: $table.talhao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maquina => $composableBuilder(
    column: $table.maquina,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cultura => $composableBuilder(
    column: $table.cultura,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pesoEstimado => $composableBuilder(
    column: $table.pesoEstimado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gpsCoordenadas => $composableBuilder(
    column: $table.gpsCoordenadas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dataHora => $composableBuilder(
    column: $table.dataHora,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProducoesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProducoesTable> {
  $$ProducoesTableOrderingComposer({
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

  ColumnOrderings<String> get talhao => $composableBuilder(
    column: $table.talhao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maquina => $composableBuilder(
    column: $table.maquina,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cultura => $composableBuilder(
    column: $table.cultura,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pesoEstimado => $composableBuilder(
    column: $table.pesoEstimado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gpsCoordenadas => $composableBuilder(
    column: $table.gpsCoordenadas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dataHora => $composableBuilder(
    column: $table.dataHora,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProducoesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProducoesTable> {
  $$ProducoesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get talhao =>
      $composableBuilder(column: $table.talhao, builder: (column) => column);

  GeneratedColumn<String> get maquina =>
      $composableBuilder(column: $table.maquina, builder: (column) => column);

  GeneratedColumn<String> get cultura =>
      $composableBuilder(column: $table.cultura, builder: (column) => column);

  GeneratedColumn<double> get pesoEstimado => $composableBuilder(
    column: $table.pesoEstimado,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gpsCoordenadas => $composableBuilder(
    column: $table.gpsCoordenadas,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dataHora =>
      $composableBuilder(column: $table.dataHora, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
    column: $table.sincronizado,
    builder: (column) => column,
  );
}

class $$ProducoesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProducoesTable,
          Producao,
          $$ProducoesTableFilterComposer,
          $$ProducoesTableOrderingComposer,
          $$ProducoesTableAnnotationComposer,
          $$ProducoesTableCreateCompanionBuilder,
          $$ProducoesTableUpdateCompanionBuilder,
          (Producao, BaseReferences<_$AppDatabase, $ProducoesTable, Producao>),
          Producao,
          PrefetchHooks Function()
        > {
  $$ProducoesTableTableManager(_$AppDatabase db, $ProducoesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProducoesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProducoesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProducoesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> talhao = const Value.absent(),
                Value<String> maquina = const Value.absent(),
                Value<String> cultura = const Value.absent(),
                Value<double?> pesoEstimado = const Value.absent(),
                Value<String?> gpsCoordenadas = const Value.absent(),
                Value<DateTime> dataHora = const Value.absent(),
                Value<bool> sincronizado = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProducoesCompanion(
                id: id,
                talhao: talhao,
                maquina: maquina,
                cultura: cultura,
                pesoEstimado: pesoEstimado,
                gpsCoordenadas: gpsCoordenadas,
                dataHora: dataHora,
                sincronizado: sincronizado,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String talhao,
                required String maquina,
                required String cultura,
                Value<double?> pesoEstimado = const Value.absent(),
                Value<String?> gpsCoordenadas = const Value.absent(),
                required DateTime dataHora,
                Value<bool> sincronizado = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProducoesCompanion.insert(
                id: id,
                talhao: talhao,
                maquina: maquina,
                cultura: cultura,
                pesoEstimado: pesoEstimado,
                gpsCoordenadas: gpsCoordenadas,
                dataHora: dataHora,
                sincronizado: sincronizado,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProducoesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProducoesTable,
      Producao,
      $$ProducoesTableFilterComposer,
      $$ProducoesTableOrderingComposer,
      $$ProducoesTableAnnotationComposer,
      $$ProducoesTableCreateCompanionBuilder,
      $$ProducoesTableUpdateCompanionBuilder,
      (Producao, BaseReferences<_$AppDatabase, $ProducoesTable, Producao>),
      Producao,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProducoesTableTableManager get producoes =>
      $$ProducoesTableTableManager(_db, _db.producoes);
}
