// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PreferencesTableTable extends PreferencesTable
    with TableInfo<$PreferencesTableTable, PreferencesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferencesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _isFirstRunMeta =
      const VerificationMeta('isFirstRun');
  @override
  late final GeneratedColumn<bool> isFirstRun = GeneratedColumn<bool>(
      'is_first_run', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_first_run" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _themeModeMeta =
      const VerificationMeta('themeMode');
  @override
  late final GeneratedColumnWithTypeConverter<ThemeMode, String> themeMode =
      GeneratedColumn<String>('theme_mode', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(ThemeMode.system.name))
          .withConverter<ThemeMode>($PreferencesTableTable.$converterthemeMode);
  static const VerificationMeta _localeMeta = const VerificationMeta('locale');
  @override
  late final GeneratedColumnWithTypeConverter<Locale, String> locale =
      GeneratedColumn<String>('locale', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant(
                  '{"languageCode":"system","countryCode":"system"}'))
          .withConverter<Locale>($PreferencesTableTable.$converterlocale);
  static const VerificationMeta _isDarkModeMeta =
      const VerificationMeta('isDarkMode');
  @override
  late final GeneratedColumn<bool> isDarkMode = GeneratedColumn<bool>(
      'is_dark_mode', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_dark_mode" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _cacheMusicMeta =
      const VerificationMeta('cacheMusic');
  @override
  late final GeneratedColumn<bool> cacheMusic = GeneratedColumn<bool>(
      'cache_music', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("cache_music" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _downloadLocationMeta =
      const VerificationMeta('downloadLocation');
  @override
  late final GeneratedColumn<String> downloadLocation = GeneratedColumn<String>(
      'download_location', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(""));
  static const VerificationMeta _defaultToastOpMeta =
      const VerificationMeta('defaultToastOp');
  @override
  late final GeneratedColumn<double> defaultToastOp = GeneratedColumn<double>(
      'default_toast_op', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _enableAutoPlayMeta =
      const VerificationMeta('enableAutoPlay');
  @override
  late final GeneratedColumn<bool> enableAutoPlay = GeneratedColumn<bool>(
      'enable_auto_play', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enable_auto_play" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _enableOpenHAMeta =
      const VerificationMeta('enableOpenHA');
  @override
  late final GeneratedColumn<bool> enableOpenHA = GeneratedColumn<bool>(
      'enable_open_h_a', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enable_open_h_a" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _layoutModeMeta =
      const VerificationMeta('layoutMode');
  @override
  late final GeneratedColumnWithTypeConverter<LayoutMode, String> layoutMode =
      GeneratedColumn<String>('layout_mode', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: Constant(LayoutMode.auto.name))
          .withConverter<LayoutMode>(
              $PreferencesTableTable.$converterlayoutMode);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        isFirstRun,
        themeMode,
        locale,
        isDarkMode,
        cacheMusic,
        downloadLocation,
        defaultToastOp,
        enableAutoPlay,
        enableOpenHA,
        layoutMode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preferences_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PreferencesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_first_run')) {
      context.handle(
          _isFirstRunMeta,
          isFirstRun.isAcceptableOrUnknown(
              data['is_first_run']!, _isFirstRunMeta));
    }
    context.handle(_themeModeMeta, const VerificationResult.success());
    context.handle(_localeMeta, const VerificationResult.success());
    if (data.containsKey('is_dark_mode')) {
      context.handle(
          _isDarkModeMeta,
          isDarkMode.isAcceptableOrUnknown(
              data['is_dark_mode']!, _isDarkModeMeta));
    }
    if (data.containsKey('cache_music')) {
      context.handle(
          _cacheMusicMeta,
          cacheMusic.isAcceptableOrUnknown(
              data['cache_music']!, _cacheMusicMeta));
    }
    if (data.containsKey('download_location')) {
      context.handle(
          _downloadLocationMeta,
          downloadLocation.isAcceptableOrUnknown(
              data['download_location']!, _downloadLocationMeta));
    }
    if (data.containsKey('default_toast_op')) {
      context.handle(
          _defaultToastOpMeta,
          defaultToastOp.isAcceptableOrUnknown(
              data['default_toast_op']!, _defaultToastOpMeta));
    }
    if (data.containsKey('enable_auto_play')) {
      context.handle(
          _enableAutoPlayMeta,
          enableAutoPlay.isAcceptableOrUnknown(
              data['enable_auto_play']!, _enableAutoPlayMeta));
    }
    if (data.containsKey('enable_open_h_a')) {
      context.handle(
          _enableOpenHAMeta,
          enableOpenHA.isAcceptableOrUnknown(
              data['enable_open_h_a']!, _enableOpenHAMeta));
    }
    context.handle(_layoutModeMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PreferencesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreferencesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      isFirstRun: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_first_run'])!,
      themeMode: $PreferencesTableTable.$converterthemeMode.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}theme_mode'])!),
      locale: $PreferencesTableTable.$converterlocale.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}locale'])!),
      isDarkMode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dark_mode'])!,
      cacheMusic: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}cache_music'])!,
      downloadLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}download_location'])!,
      defaultToastOp: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}default_toast_op'])!,
      enableAutoPlay: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enable_auto_play'])!,
      enableOpenHA: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enable_open_h_a'])!,
      layoutMode: $PreferencesTableTable.$converterlayoutMode.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}layout_mode'])!),
    );
  }

  @override
  $PreferencesTableTable createAlias(String alias) {
    return $PreferencesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ThemeMode, String, String> $converterthemeMode =
      const EnumNameConverter<ThemeMode>(ThemeMode.values);
  static TypeConverter<Locale, String> $converterlocale =
      const LocaleConverter();
  static JsonTypeConverter2<LayoutMode, String, String> $converterlayoutMode =
      const EnumNameConverter<LayoutMode>(LayoutMode.values);
}

class PreferencesTableData extends DataClass
    implements Insertable<PreferencesTableData> {
  final int id;

  /// 是否首次启动
  final bool isFirstRun;

  /// 主题模式
  final ThemeMode themeMode;

  /// 国际化
  final Locale locale;

  /// 是否黑夜模式
  final bool isDarkMode;

  /// 缓存音乐
  final bool cacheMusic;

  /// 下载路径
  final String downloadLocation;

  /// 默认吐司参数
  final double defaultToastOp;

  /// 自动播放 默认不允许
  final bool enableAutoPlay;

  /// 是否开启硬件加速
  final bool enableOpenHA;

  /// 首页布局模式
  final LayoutMode layoutMode;
  const PreferencesTableData(
      {required this.id,
      required this.isFirstRun,
      required this.themeMode,
      required this.locale,
      required this.isDarkMode,
      required this.cacheMusic,
      required this.downloadLocation,
      required this.defaultToastOp,
      required this.enableAutoPlay,
      required this.enableOpenHA,
      required this.layoutMode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_first_run'] = Variable<bool>(isFirstRun);
    {
      map['theme_mode'] = Variable<String>(
          $PreferencesTableTable.$converterthemeMode.toSql(themeMode));
    }
    {
      map['locale'] = Variable<String>(
          $PreferencesTableTable.$converterlocale.toSql(locale));
    }
    map['is_dark_mode'] = Variable<bool>(isDarkMode);
    map['cache_music'] = Variable<bool>(cacheMusic);
    map['download_location'] = Variable<String>(downloadLocation);
    map['default_toast_op'] = Variable<double>(defaultToastOp);
    map['enable_auto_play'] = Variable<bool>(enableAutoPlay);
    map['enable_open_h_a'] = Variable<bool>(enableOpenHA);
    {
      map['layout_mode'] = Variable<String>(
          $PreferencesTableTable.$converterlayoutMode.toSql(layoutMode));
    }
    return map;
  }

  PreferencesTableCompanion toCompanion(bool nullToAbsent) {
    return PreferencesTableCompanion(
      id: Value(id),
      isFirstRun: Value(isFirstRun),
      themeMode: Value(themeMode),
      locale: Value(locale),
      isDarkMode: Value(isDarkMode),
      cacheMusic: Value(cacheMusic),
      downloadLocation: Value(downloadLocation),
      defaultToastOp: Value(defaultToastOp),
      enableAutoPlay: Value(enableAutoPlay),
      enableOpenHA: Value(enableOpenHA),
      layoutMode: Value(layoutMode),
    );
  }

  factory PreferencesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreferencesTableData(
      id: serializer.fromJson<int>(json['id']),
      isFirstRun: serializer.fromJson<bool>(json['isFirstRun']),
      themeMode: $PreferencesTableTable.$converterthemeMode
          .fromJson(serializer.fromJson<String>(json['themeMode'])),
      locale: serializer.fromJson<Locale>(json['locale']),
      isDarkMode: serializer.fromJson<bool>(json['isDarkMode']),
      cacheMusic: serializer.fromJson<bool>(json['cacheMusic']),
      downloadLocation: serializer.fromJson<String>(json['downloadLocation']),
      defaultToastOp: serializer.fromJson<double>(json['defaultToastOp']),
      enableAutoPlay: serializer.fromJson<bool>(json['enableAutoPlay']),
      enableOpenHA: serializer.fromJson<bool>(json['enableOpenHA']),
      layoutMode: $PreferencesTableTable.$converterlayoutMode
          .fromJson(serializer.fromJson<String>(json['layoutMode'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isFirstRun': serializer.toJson<bool>(isFirstRun),
      'themeMode': serializer.toJson<String>(
          $PreferencesTableTable.$converterthemeMode.toJson(themeMode)),
      'locale': serializer.toJson<Locale>(locale),
      'isDarkMode': serializer.toJson<bool>(isDarkMode),
      'cacheMusic': serializer.toJson<bool>(cacheMusic),
      'downloadLocation': serializer.toJson<String>(downloadLocation),
      'defaultToastOp': serializer.toJson<double>(defaultToastOp),
      'enableAutoPlay': serializer.toJson<bool>(enableAutoPlay),
      'enableOpenHA': serializer.toJson<bool>(enableOpenHA),
      'layoutMode': serializer.toJson<String>(
          $PreferencesTableTable.$converterlayoutMode.toJson(layoutMode)),
    };
  }

  PreferencesTableData copyWith(
          {int? id,
          bool? isFirstRun,
          ThemeMode? themeMode,
          Locale? locale,
          bool? isDarkMode,
          bool? cacheMusic,
          String? downloadLocation,
          double? defaultToastOp,
          bool? enableAutoPlay,
          bool? enableOpenHA,
          LayoutMode? layoutMode}) =>
      PreferencesTableData(
        id: id ?? this.id,
        isFirstRun: isFirstRun ?? this.isFirstRun,
        themeMode: themeMode ?? this.themeMode,
        locale: locale ?? this.locale,
        isDarkMode: isDarkMode ?? this.isDarkMode,
        cacheMusic: cacheMusic ?? this.cacheMusic,
        downloadLocation: downloadLocation ?? this.downloadLocation,
        defaultToastOp: defaultToastOp ?? this.defaultToastOp,
        enableAutoPlay: enableAutoPlay ?? this.enableAutoPlay,
        enableOpenHA: enableOpenHA ?? this.enableOpenHA,
        layoutMode: layoutMode ?? this.layoutMode,
      );
  PreferencesTableData copyWithCompanion(PreferencesTableCompanion data) {
    return PreferencesTableData(
      id: data.id.present ? data.id.value : this.id,
      isFirstRun:
          data.isFirstRun.present ? data.isFirstRun.value : this.isFirstRun,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      locale: data.locale.present ? data.locale.value : this.locale,
      isDarkMode:
          data.isDarkMode.present ? data.isDarkMode.value : this.isDarkMode,
      cacheMusic:
          data.cacheMusic.present ? data.cacheMusic.value : this.cacheMusic,
      downloadLocation: data.downloadLocation.present
          ? data.downloadLocation.value
          : this.downloadLocation,
      defaultToastOp: data.defaultToastOp.present
          ? data.defaultToastOp.value
          : this.defaultToastOp,
      enableAutoPlay: data.enableAutoPlay.present
          ? data.enableAutoPlay.value
          : this.enableAutoPlay,
      enableOpenHA: data.enableOpenHA.present
          ? data.enableOpenHA.value
          : this.enableOpenHA,
      layoutMode:
          data.layoutMode.present ? data.layoutMode.value : this.layoutMode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesTableData(')
          ..write('id: $id, ')
          ..write('isFirstRun: $isFirstRun, ')
          ..write('themeMode: $themeMode, ')
          ..write('locale: $locale, ')
          ..write('isDarkMode: $isDarkMode, ')
          ..write('cacheMusic: $cacheMusic, ')
          ..write('downloadLocation: $downloadLocation, ')
          ..write('defaultToastOp: $defaultToastOp, ')
          ..write('enableAutoPlay: $enableAutoPlay, ')
          ..write('enableOpenHA: $enableOpenHA, ')
          ..write('layoutMode: $layoutMode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      isFirstRun,
      themeMode,
      locale,
      isDarkMode,
      cacheMusic,
      downloadLocation,
      defaultToastOp,
      enableAutoPlay,
      enableOpenHA,
      layoutMode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreferencesTableData &&
          other.id == this.id &&
          other.isFirstRun == this.isFirstRun &&
          other.themeMode == this.themeMode &&
          other.locale == this.locale &&
          other.isDarkMode == this.isDarkMode &&
          other.cacheMusic == this.cacheMusic &&
          other.downloadLocation == this.downloadLocation &&
          other.defaultToastOp == this.defaultToastOp &&
          other.enableAutoPlay == this.enableAutoPlay &&
          other.enableOpenHA == this.enableOpenHA &&
          other.layoutMode == this.layoutMode);
}

class PreferencesTableCompanion extends UpdateCompanion<PreferencesTableData> {
  final Value<int> id;
  final Value<bool> isFirstRun;
  final Value<ThemeMode> themeMode;
  final Value<Locale> locale;
  final Value<bool> isDarkMode;
  final Value<bool> cacheMusic;
  final Value<String> downloadLocation;
  final Value<double> defaultToastOp;
  final Value<bool> enableAutoPlay;
  final Value<bool> enableOpenHA;
  final Value<LayoutMode> layoutMode;
  const PreferencesTableCompanion({
    this.id = const Value.absent(),
    this.isFirstRun = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.locale = const Value.absent(),
    this.isDarkMode = const Value.absent(),
    this.cacheMusic = const Value.absent(),
    this.downloadLocation = const Value.absent(),
    this.defaultToastOp = const Value.absent(),
    this.enableAutoPlay = const Value.absent(),
    this.enableOpenHA = const Value.absent(),
    this.layoutMode = const Value.absent(),
  });
  PreferencesTableCompanion.insert({
    this.id = const Value.absent(),
    this.isFirstRun = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.locale = const Value.absent(),
    this.isDarkMode = const Value.absent(),
    this.cacheMusic = const Value.absent(),
    this.downloadLocation = const Value.absent(),
    this.defaultToastOp = const Value.absent(),
    this.enableAutoPlay = const Value.absent(),
    this.enableOpenHA = const Value.absent(),
    this.layoutMode = const Value.absent(),
  });
  static Insertable<PreferencesTableData> custom({
    Expression<int>? id,
    Expression<bool>? isFirstRun,
    Expression<String>? themeMode,
    Expression<String>? locale,
    Expression<bool>? isDarkMode,
    Expression<bool>? cacheMusic,
    Expression<String>? downloadLocation,
    Expression<double>? defaultToastOp,
    Expression<bool>? enableAutoPlay,
    Expression<bool>? enableOpenHA,
    Expression<String>? layoutMode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isFirstRun != null) 'is_first_run': isFirstRun,
      if (themeMode != null) 'theme_mode': themeMode,
      if (locale != null) 'locale': locale,
      if (isDarkMode != null) 'is_dark_mode': isDarkMode,
      if (cacheMusic != null) 'cache_music': cacheMusic,
      if (downloadLocation != null) 'download_location': downloadLocation,
      if (defaultToastOp != null) 'default_toast_op': defaultToastOp,
      if (enableAutoPlay != null) 'enable_auto_play': enableAutoPlay,
      if (enableOpenHA != null) 'enable_open_h_a': enableOpenHA,
      if (layoutMode != null) 'layout_mode': layoutMode,
    });
  }

  PreferencesTableCompanion copyWith(
      {Value<int>? id,
      Value<bool>? isFirstRun,
      Value<ThemeMode>? themeMode,
      Value<Locale>? locale,
      Value<bool>? isDarkMode,
      Value<bool>? cacheMusic,
      Value<String>? downloadLocation,
      Value<double>? defaultToastOp,
      Value<bool>? enableAutoPlay,
      Value<bool>? enableOpenHA,
      Value<LayoutMode>? layoutMode}) {
    return PreferencesTableCompanion(
      id: id ?? this.id,
      isFirstRun: isFirstRun ?? this.isFirstRun,
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      cacheMusic: cacheMusic ?? this.cacheMusic,
      downloadLocation: downloadLocation ?? this.downloadLocation,
      defaultToastOp: defaultToastOp ?? this.defaultToastOp,
      enableAutoPlay: enableAutoPlay ?? this.enableAutoPlay,
      enableOpenHA: enableOpenHA ?? this.enableOpenHA,
      layoutMode: layoutMode ?? this.layoutMode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isFirstRun.present) {
      map['is_first_run'] = Variable<bool>(isFirstRun.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(
          $PreferencesTableTable.$converterthemeMode.toSql(themeMode.value));
    }
    if (locale.present) {
      map['locale'] = Variable<String>(
          $PreferencesTableTable.$converterlocale.toSql(locale.value));
    }
    if (isDarkMode.present) {
      map['is_dark_mode'] = Variable<bool>(isDarkMode.value);
    }
    if (cacheMusic.present) {
      map['cache_music'] = Variable<bool>(cacheMusic.value);
    }
    if (downloadLocation.present) {
      map['download_location'] = Variable<String>(downloadLocation.value);
    }
    if (defaultToastOp.present) {
      map['default_toast_op'] = Variable<double>(defaultToastOp.value);
    }
    if (enableAutoPlay.present) {
      map['enable_auto_play'] = Variable<bool>(enableAutoPlay.value);
    }
    if (enableOpenHA.present) {
      map['enable_open_h_a'] = Variable<bool>(enableOpenHA.value);
    }
    if (layoutMode.present) {
      map['layout_mode'] = Variable<String>(
          $PreferencesTableTable.$converterlayoutMode.toSql(layoutMode.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferencesTableCompanion(')
          ..write('id: $id, ')
          ..write('isFirstRun: $isFirstRun, ')
          ..write('themeMode: $themeMode, ')
          ..write('locale: $locale, ')
          ..write('isDarkMode: $isDarkMode, ')
          ..write('cacheMusic: $cacheMusic, ')
          ..write('downloadLocation: $downloadLocation, ')
          ..write('defaultToastOp: $defaultToastOp, ')
          ..write('enableAutoPlay: $enableAutoPlay, ')
          ..write('enableOpenHA: $enableOpenHA, ')
          ..write('layoutMode: $layoutMode')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PreferencesTableTable preferencesTable =
      $PreferencesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [preferencesTable];
}

typedef $$PreferencesTableTableCreateCompanionBuilder
    = PreferencesTableCompanion Function({
  Value<int> id,
  Value<bool> isFirstRun,
  Value<ThemeMode> themeMode,
  Value<Locale> locale,
  Value<bool> isDarkMode,
  Value<bool> cacheMusic,
  Value<String> downloadLocation,
  Value<double> defaultToastOp,
  Value<bool> enableAutoPlay,
  Value<bool> enableOpenHA,
  Value<LayoutMode> layoutMode,
});
typedef $$PreferencesTableTableUpdateCompanionBuilder
    = PreferencesTableCompanion Function({
  Value<int> id,
  Value<bool> isFirstRun,
  Value<ThemeMode> themeMode,
  Value<Locale> locale,
  Value<bool> isDarkMode,
  Value<bool> cacheMusic,
  Value<String> downloadLocation,
  Value<double> defaultToastOp,
  Value<bool> enableAutoPlay,
  Value<bool> enableOpenHA,
  Value<LayoutMode> layoutMode,
});

class $$PreferencesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PreferencesTableTable> {
  $$PreferencesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFirstRun => $composableBuilder(
      column: $table.isFirstRun, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ThemeMode, ThemeMode, String> get themeMode =>
      $composableBuilder(
          column: $table.themeMode,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<Locale, Locale, String> get locale =>
      $composableBuilder(
          column: $table.locale,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isDarkMode => $composableBuilder(
      column: $table.isDarkMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get cacheMusic => $composableBuilder(
      column: $table.cacheMusic, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get downloadLocation => $composableBuilder(
      column: $table.downloadLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get defaultToastOp => $composableBuilder(
      column: $table.defaultToastOp,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enableAutoPlay => $composableBuilder(
      column: $table.enableAutoPlay,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enableOpenHA => $composableBuilder(
      column: $table.enableOpenHA, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<LayoutMode, LayoutMode, String>
      get layoutMode => $composableBuilder(
          column: $table.layoutMode,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$PreferencesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PreferencesTableTable> {
  $$PreferencesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFirstRun => $composableBuilder(
      column: $table.isFirstRun, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get themeMode => $composableBuilder(
      column: $table.themeMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locale => $composableBuilder(
      column: $table.locale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDarkMode => $composableBuilder(
      column: $table.isDarkMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get cacheMusic => $composableBuilder(
      column: $table.cacheMusic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get downloadLocation => $composableBuilder(
      column: $table.downloadLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get defaultToastOp => $composableBuilder(
      column: $table.defaultToastOp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enableAutoPlay => $composableBuilder(
      column: $table.enableAutoPlay,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enableOpenHA => $composableBuilder(
      column: $table.enableOpenHA,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get layoutMode => $composableBuilder(
      column: $table.layoutMode, builder: (column) => ColumnOrderings(column));
}

class $$PreferencesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreferencesTableTable> {
  $$PreferencesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isFirstRun => $composableBuilder(
      column: $table.isFirstRun, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ThemeMode, String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Locale, String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<bool> get isDarkMode => $composableBuilder(
      column: $table.isDarkMode, builder: (column) => column);

  GeneratedColumn<bool> get cacheMusic => $composableBuilder(
      column: $table.cacheMusic, builder: (column) => column);

  GeneratedColumn<String> get downloadLocation => $composableBuilder(
      column: $table.downloadLocation, builder: (column) => column);

  GeneratedColumn<double> get defaultToastOp => $composableBuilder(
      column: $table.defaultToastOp, builder: (column) => column);

  GeneratedColumn<bool> get enableAutoPlay => $composableBuilder(
      column: $table.enableAutoPlay, builder: (column) => column);

  GeneratedColumn<bool> get enableOpenHA => $composableBuilder(
      column: $table.enableOpenHA, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LayoutMode, String> get layoutMode =>
      $composableBuilder(
          column: $table.layoutMode, builder: (column) => column);
}

class $$PreferencesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PreferencesTableTable,
    PreferencesTableData,
    $$PreferencesTableTableFilterComposer,
    $$PreferencesTableTableOrderingComposer,
    $$PreferencesTableTableAnnotationComposer,
    $$PreferencesTableTableCreateCompanionBuilder,
    $$PreferencesTableTableUpdateCompanionBuilder,
    (
      PreferencesTableData,
      BaseReferences<_$AppDatabase, $PreferencesTableTable,
          PreferencesTableData>
    ),
    PreferencesTableData,
    PrefetchHooks Function()> {
  $$PreferencesTableTableTableManager(
      _$AppDatabase db, $PreferencesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreferencesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreferencesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreferencesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isFirstRun = const Value.absent(),
            Value<ThemeMode> themeMode = const Value.absent(),
            Value<Locale> locale = const Value.absent(),
            Value<bool> isDarkMode = const Value.absent(),
            Value<bool> cacheMusic = const Value.absent(),
            Value<String> downloadLocation = const Value.absent(),
            Value<double> defaultToastOp = const Value.absent(),
            Value<bool> enableAutoPlay = const Value.absent(),
            Value<bool> enableOpenHA = const Value.absent(),
            Value<LayoutMode> layoutMode = const Value.absent(),
          }) =>
              PreferencesTableCompanion(
            id: id,
            isFirstRun: isFirstRun,
            themeMode: themeMode,
            locale: locale,
            isDarkMode: isDarkMode,
            cacheMusic: cacheMusic,
            downloadLocation: downloadLocation,
            defaultToastOp: defaultToastOp,
            enableAutoPlay: enableAutoPlay,
            enableOpenHA: enableOpenHA,
            layoutMode: layoutMode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<bool> isFirstRun = const Value.absent(),
            Value<ThemeMode> themeMode = const Value.absent(),
            Value<Locale> locale = const Value.absent(),
            Value<bool> isDarkMode = const Value.absent(),
            Value<bool> cacheMusic = const Value.absent(),
            Value<String> downloadLocation = const Value.absent(),
            Value<double> defaultToastOp = const Value.absent(),
            Value<bool> enableAutoPlay = const Value.absent(),
            Value<bool> enableOpenHA = const Value.absent(),
            Value<LayoutMode> layoutMode = const Value.absent(),
          }) =>
              PreferencesTableCompanion.insert(
            id: id,
            isFirstRun: isFirstRun,
            themeMode: themeMode,
            locale: locale,
            isDarkMode: isDarkMode,
            cacheMusic: cacheMusic,
            downloadLocation: downloadLocation,
            defaultToastOp: defaultToastOp,
            enableAutoPlay: enableAutoPlay,
            enableOpenHA: enableOpenHA,
            layoutMode: layoutMode,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PreferencesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PreferencesTableTable,
    PreferencesTableData,
    $$PreferencesTableTableFilterComposer,
    $$PreferencesTableTableOrderingComposer,
    $$PreferencesTableTableAnnotationComposer,
    $$PreferencesTableTableCreateCompanionBuilder,
    $$PreferencesTableTableUpdateCompanionBuilder,
    (
      PreferencesTableData,
      BaseReferences<_$AppDatabase, $PreferencesTableTable,
          PreferencesTableData>
    ),
    PreferencesTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PreferencesTableTableTableManager get preferencesTable =>
      $$PreferencesTableTableTableManager(_db, _db.preferencesTable);
}
