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
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _isFirstRunMeta = const VerificationMeta(
    'isFirstRun',
  );
  @override
  late final GeneratedColumn<bool> isFirstRun = GeneratedColumn<bool>(
    'is_first_run',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_first_run" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ThemeMode, String> themeMode =
      GeneratedColumn<String>(
        'theme_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(ThemeMode.system.name),
      ).withConverter<ThemeMode>($PreferencesTableTable.$converterthemeMode);
  @override
  late final GeneratedColumnWithTypeConverter<Locale, String> locale =
      GeneratedColumn<String>(
        'locale',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(
          '{"languageCode":"system","countryCode":"system"}',
        ),
      ).withConverter<Locale>($PreferencesTableTable.$converterlocale);
  static const VerificationMeta _isDarkModeMeta = const VerificationMeta(
    'isDarkMode',
  );
  @override
  late final GeneratedColumn<bool> isDarkMode = GeneratedColumn<bool>(
    'is_dark_mode',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dark_mode" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _cacheMusicMeta = const VerificationMeta(
    'cacheMusic',
  );
  @override
  late final GeneratedColumn<bool> cacheMusic = GeneratedColumn<bool>(
    'cache_music',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cache_music" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _downloadLocationMeta = const VerificationMeta(
    'downloadLocation',
  );
  @override
  late final GeneratedColumn<String> downloadLocation = GeneratedColumn<String>(
    'download_location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
  );
  static const VerificationMeta _defaultToastOpMeta = const VerificationMeta(
    'defaultToastOp',
  );
  @override
  late final GeneratedColumn<double> defaultToastOp = GeneratedColumn<double>(
    'default_toast_op',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _enableAutoPlayMeta = const VerificationMeta(
    'enableAutoPlay',
  );
  @override
  late final GeneratedColumn<bool> enableAutoPlay = GeneratedColumn<bool>(
    'enable_auto_play',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_auto_play" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _enableOpenHAMeta = const VerificationMeta(
    'enableOpenHA',
  );
  @override
  late final GeneratedColumn<bool> enableOpenHA = GeneratedColumn<bool>(
    'enable_open_h_a',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enable_open_h_a" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<LayoutMode, String> layoutMode =
      GeneratedColumn<String>(
        'layout_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(LayoutMode.auto.name),
      ).withConverter<LayoutMode>($PreferencesTableTable.$converterlayoutMode);
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
    layoutMode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preferences_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PreferencesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_first_run')) {
      context.handle(
        _isFirstRunMeta,
        isFirstRun.isAcceptableOrUnknown(
          data['is_first_run']!,
          _isFirstRunMeta,
        ),
      );
    }
    if (data.containsKey('is_dark_mode')) {
      context.handle(
        _isDarkModeMeta,
        isDarkMode.isAcceptableOrUnknown(
          data['is_dark_mode']!,
          _isDarkModeMeta,
        ),
      );
    }
    if (data.containsKey('cache_music')) {
      context.handle(
        _cacheMusicMeta,
        cacheMusic.isAcceptableOrUnknown(data['cache_music']!, _cacheMusicMeta),
      );
    }
    if (data.containsKey('download_location')) {
      context.handle(
        _downloadLocationMeta,
        downloadLocation.isAcceptableOrUnknown(
          data['download_location']!,
          _downloadLocationMeta,
        ),
      );
    }
    if (data.containsKey('default_toast_op')) {
      context.handle(
        _defaultToastOpMeta,
        defaultToastOp.isAcceptableOrUnknown(
          data['default_toast_op']!,
          _defaultToastOpMeta,
        ),
      );
    }
    if (data.containsKey('enable_auto_play')) {
      context.handle(
        _enableAutoPlayMeta,
        enableAutoPlay.isAcceptableOrUnknown(
          data['enable_auto_play']!,
          _enableAutoPlayMeta,
        ),
      );
    }
    if (data.containsKey('enable_open_h_a')) {
      context.handle(
        _enableOpenHAMeta,
        enableOpenHA.isAcceptableOrUnknown(
          data['enable_open_h_a']!,
          _enableOpenHAMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PreferencesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreferencesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isFirstRun: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_first_run'],
      )!,
      themeMode: $PreferencesTableTable.$converterthemeMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}theme_mode'],
        )!,
      ),
      locale: $PreferencesTableTable.$converterlocale.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}locale'],
        )!,
      ),
      isDarkMode: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dark_mode'],
      )!,
      cacheMusic: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cache_music'],
      )!,
      downloadLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}download_location'],
      )!,
      defaultToastOp: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_toast_op'],
      )!,
      enableAutoPlay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_auto_play'],
      )!,
      enableOpenHA: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enable_open_h_a'],
      )!,
      layoutMode: $PreferencesTableTable.$converterlayoutMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}layout_mode'],
        )!,
      ),
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
  final bool isFirstRun;
  final ThemeMode themeMode;
  final Locale locale;
  final bool isDarkMode;
  final bool cacheMusic;
  final String downloadLocation;
  final double defaultToastOp;
  final bool enableAutoPlay;
  final bool enableOpenHA;
  final LayoutMode layoutMode;
  const PreferencesTableData({
    required this.id,
    required this.isFirstRun,
    required this.themeMode,
    required this.locale,
    required this.isDarkMode,
    required this.cacheMusic,
    required this.downloadLocation,
    required this.defaultToastOp,
    required this.enableAutoPlay,
    required this.enableOpenHA,
    required this.layoutMode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_first_run'] = Variable<bool>(isFirstRun);
    {
      map['theme_mode'] = Variable<String>(
        $PreferencesTableTable.$converterthemeMode.toSql(themeMode),
      );
    }
    {
      map['locale'] = Variable<String>(
        $PreferencesTableTable.$converterlocale.toSql(locale),
      );
    }
    map['is_dark_mode'] = Variable<bool>(isDarkMode);
    map['cache_music'] = Variable<bool>(cacheMusic);
    map['download_location'] = Variable<String>(downloadLocation);
    map['default_toast_op'] = Variable<double>(defaultToastOp);
    map['enable_auto_play'] = Variable<bool>(enableAutoPlay);
    map['enable_open_h_a'] = Variable<bool>(enableOpenHA);
    {
      map['layout_mode'] = Variable<String>(
        $PreferencesTableTable.$converterlayoutMode.toSql(layoutMode),
      );
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

  factory PreferencesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreferencesTableData(
      id: serializer.fromJson<int>(json['id']),
      isFirstRun: serializer.fromJson<bool>(json['isFirstRun']),
      themeMode: $PreferencesTableTable.$converterthemeMode.fromJson(
        serializer.fromJson<String>(json['themeMode']),
      ),
      locale: serializer.fromJson<Locale>(json['locale']),
      isDarkMode: serializer.fromJson<bool>(json['isDarkMode']),
      cacheMusic: serializer.fromJson<bool>(json['cacheMusic']),
      downloadLocation: serializer.fromJson<String>(json['downloadLocation']),
      defaultToastOp: serializer.fromJson<double>(json['defaultToastOp']),
      enableAutoPlay: serializer.fromJson<bool>(json['enableAutoPlay']),
      enableOpenHA: serializer.fromJson<bool>(json['enableOpenHA']),
      layoutMode: $PreferencesTableTable.$converterlayoutMode.fromJson(
        serializer.fromJson<String>(json['layoutMode']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isFirstRun': serializer.toJson<bool>(isFirstRun),
      'themeMode': serializer.toJson<String>(
        $PreferencesTableTable.$converterthemeMode.toJson(themeMode),
      ),
      'locale': serializer.toJson<Locale>(locale),
      'isDarkMode': serializer.toJson<bool>(isDarkMode),
      'cacheMusic': serializer.toJson<bool>(cacheMusic),
      'downloadLocation': serializer.toJson<String>(downloadLocation),
      'defaultToastOp': serializer.toJson<double>(defaultToastOp),
      'enableAutoPlay': serializer.toJson<bool>(enableAutoPlay),
      'enableOpenHA': serializer.toJson<bool>(enableOpenHA),
      'layoutMode': serializer.toJson<String>(
        $PreferencesTableTable.$converterlayoutMode.toJson(layoutMode),
      ),
    };
  }

  PreferencesTableData copyWith({
    int? id,
    bool? isFirstRun,
    ThemeMode? themeMode,
    Locale? locale,
    bool? isDarkMode,
    bool? cacheMusic,
    String? downloadLocation,
    double? defaultToastOp,
    bool? enableAutoPlay,
    bool? enableOpenHA,
    LayoutMode? layoutMode,
  }) => PreferencesTableData(
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
      isFirstRun: data.isFirstRun.present
          ? data.isFirstRun.value
          : this.isFirstRun,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      locale: data.locale.present ? data.locale.value : this.locale,
      isDarkMode: data.isDarkMode.present
          ? data.isDarkMode.value
          : this.isDarkMode,
      cacheMusic: data.cacheMusic.present
          ? data.cacheMusic.value
          : this.cacheMusic,
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
      layoutMode: data.layoutMode.present
          ? data.layoutMode.value
          : this.layoutMode,
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
    layoutMode,
  );
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

  PreferencesTableCompanion copyWith({
    Value<int>? id,
    Value<bool>? isFirstRun,
    Value<ThemeMode>? themeMode,
    Value<Locale>? locale,
    Value<bool>? isDarkMode,
    Value<bool>? cacheMusic,
    Value<String>? downloadLocation,
    Value<double>? defaultToastOp,
    Value<bool>? enableAutoPlay,
    Value<bool>? enableOpenHA,
    Value<LayoutMode>? layoutMode,
  }) {
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
        $PreferencesTableTable.$converterthemeMode.toSql(themeMode.value),
      );
    }
    if (locale.present) {
      map['locale'] = Variable<String>(
        $PreferencesTableTable.$converterlocale.toSql(locale.value),
      );
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
        $PreferencesTableTable.$converterlayoutMode.toSql(layoutMode.value),
      );
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

class $ClcCategoriesTable extends ClcCategories
    with TableInfo<$ClcCategoriesTable, ClcCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClcCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1,
    ),
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
  @override
  List<GeneratedColumn> get $columns => [code, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clc_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClcCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  ClcCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClcCategory(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ClcCategoriesTable createAlias(String alias) {
    return $ClcCategoriesTable(attachedDatabase, alias);
  }
}

class ClcCategory extends DataClass implements Insertable<ClcCategory> {
  final String code;
  final String name;
  const ClcCategory({required this.code, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    return map;
  }

  ClcCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ClcCategoriesCompanion(code: Value(code), name: Value(name));
  }

  factory ClcCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClcCategory(
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
    };
  }

  ClcCategory copyWith({String? code, String? name}) =>
      ClcCategory(code: code ?? this.code, name: name ?? this.name);
  ClcCategory copyWithCompanion(ClcCategoriesCompanion data) {
    return ClcCategory(
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClcCategory(')
          ..write('code: $code, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClcCategory &&
          other.code == this.code &&
          other.name == this.name);
}

class ClcCategoriesCompanion extends UpdateCompanion<ClcCategory> {
  final Value<String> code;
  final Value<String> name;
  final Value<int> rowid;
  const ClcCategoriesCompanion({
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClcCategoriesCompanion.insert({
    required String code,
    required String name,
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       name = Value(name);
  static Insertable<ClcCategory> custom({
    Expression<String>? code,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClcCategoriesCompanion copyWith({
    Value<String>? code,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return ClcCategoriesCompanion(
      code: code ?? this.code,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClcCategoriesCompanion(')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VolumesTable extends Volumes with TableInfo<$VolumesTable, Volume> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VolumesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fileHashMeta = const VerificationMeta(
    'fileHash',
  );
  @override
  late final GeneratedColumn<String> fileHash = GeneratedColumn<String>(
    'file_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _publisherMeta = const VerificationMeta(
    'publisher',
  );
  @override
  late final GeneratedColumn<String> publisher = GeneratedColumn<String>(
    'publisher',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clcCodeMeta = const VerificationMeta(
    'clcCode',
  );
  @override
  late final GeneratedColumn<String> clcCode = GeneratedColumn<String>(
    'clc_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clc_categories (code)',
    ),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverPathMeta = const VerificationMeta(
    'coverPath',
  );
  @override
  late final GeneratedColumn<String> coverPath = GeneratedColumn<String>(
    'cover_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createTimeMeta = const VerificationMeta(
    'createTime',
  );
  @override
  late final GeneratedColumn<DateTime> createTime = GeneratedColumn<DateTime>(
    'create_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fileHash,
    title,
    author,
    publisher,
    clcCode,
    rating,
    remarks,
    coverPath,
    createTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'volumes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Volume> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('file_hash')) {
      context.handle(
        _fileHashMeta,
        fileHash.isAcceptableOrUnknown(data['file_hash']!, _fileHashMeta),
      );
    } else if (isInserting) {
      context.missing(_fileHashMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('publisher')) {
      context.handle(
        _publisherMeta,
        publisher.isAcceptableOrUnknown(data['publisher']!, _publisherMeta),
      );
    }
    if (data.containsKey('clc_code')) {
      context.handle(
        _clcCodeMeta,
        clcCode.isAcceptableOrUnknown(data['clc_code']!, _clcCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_clcCodeMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('cover_path')) {
      context.handle(
        _coverPathMeta,
        coverPath.isAcceptableOrUnknown(data['cover_path']!, _coverPathMeta),
      );
    }
    if (data.containsKey('create_time')) {
      context.handle(
        _createTimeMeta,
        createTime.isAcceptableOrUnknown(data['create_time']!, _createTimeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Volume map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Volume(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fileHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_hash'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      ),
      publisher: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}publisher'],
      ),
      clcCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clc_code'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      ),
      coverPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_path'],
      ),
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_time'],
      )!,
    );
  }

  @override
  $VolumesTable createAlias(String alias) {
    return $VolumesTable(attachedDatabase, alias);
  }
}

class Volume extends DataClass implements Insertable<Volume> {
  final int id;
  final String fileHash;
  final String title;
  final String? author;
  final String? publisher;
  final String clcCode;
  final int rating;
  final String? remarks;
  final String? coverPath;
  final DateTime createTime;
  const Volume({
    required this.id,
    required this.fileHash,
    required this.title,
    this.author,
    this.publisher,
    required this.clcCode,
    required this.rating,
    this.remarks,
    this.coverPath,
    required this.createTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['file_hash'] = Variable<String>(fileHash);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || publisher != null) {
      map['publisher'] = Variable<String>(publisher);
    }
    map['clc_code'] = Variable<String>(clcCode);
    map['rating'] = Variable<int>(rating);
    if (!nullToAbsent || remarks != null) {
      map['remarks'] = Variable<String>(remarks);
    }
    if (!nullToAbsent || coverPath != null) {
      map['cover_path'] = Variable<String>(coverPath);
    }
    map['create_time'] = Variable<DateTime>(createTime);
    return map;
  }

  VolumesCompanion toCompanion(bool nullToAbsent) {
    return VolumesCompanion(
      id: Value(id),
      fileHash: Value(fileHash),
      title: Value(title),
      author: author == null && nullToAbsent
          ? const Value.absent()
          : Value(author),
      publisher: publisher == null && nullToAbsent
          ? const Value.absent()
          : Value(publisher),
      clcCode: Value(clcCode),
      rating: Value(rating),
      remarks: remarks == null && nullToAbsent
          ? const Value.absent()
          : Value(remarks),
      coverPath: coverPath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverPath),
      createTime: Value(createTime),
    );
  }

  factory Volume.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Volume(
      id: serializer.fromJson<int>(json['id']),
      fileHash: serializer.fromJson<String>(json['fileHash']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String?>(json['author']),
      publisher: serializer.fromJson<String?>(json['publisher']),
      clcCode: serializer.fromJson<String>(json['clcCode']),
      rating: serializer.fromJson<int>(json['rating']),
      remarks: serializer.fromJson<String?>(json['remarks']),
      coverPath: serializer.fromJson<String?>(json['coverPath']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fileHash': serializer.toJson<String>(fileHash),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String?>(author),
      'publisher': serializer.toJson<String?>(publisher),
      'clcCode': serializer.toJson<String>(clcCode),
      'rating': serializer.toJson<int>(rating),
      'remarks': serializer.toJson<String?>(remarks),
      'coverPath': serializer.toJson<String?>(coverPath),
      'createTime': serializer.toJson<DateTime>(createTime),
    };
  }

  Volume copyWith({
    int? id,
    String? fileHash,
    String? title,
    Value<String?> author = const Value.absent(),
    Value<String?> publisher = const Value.absent(),
    String? clcCode,
    int? rating,
    Value<String?> remarks = const Value.absent(),
    Value<String?> coverPath = const Value.absent(),
    DateTime? createTime,
  }) => Volume(
    id: id ?? this.id,
    fileHash: fileHash ?? this.fileHash,
    title: title ?? this.title,
    author: author.present ? author.value : this.author,
    publisher: publisher.present ? publisher.value : this.publisher,
    clcCode: clcCode ?? this.clcCode,
    rating: rating ?? this.rating,
    remarks: remarks.present ? remarks.value : this.remarks,
    coverPath: coverPath.present ? coverPath.value : this.coverPath,
    createTime: createTime ?? this.createTime,
  );
  Volume copyWithCompanion(VolumesCompanion data) {
    return Volume(
      id: data.id.present ? data.id.value : this.id,
      fileHash: data.fileHash.present ? data.fileHash.value : this.fileHash,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      publisher: data.publisher.present ? data.publisher.value : this.publisher,
      clcCode: data.clcCode.present ? data.clcCode.value : this.clcCode,
      rating: data.rating.present ? data.rating.value : this.rating,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      coverPath: data.coverPath.present ? data.coverPath.value : this.coverPath,
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Volume(')
          ..write('id: $id, ')
          ..write('fileHash: $fileHash, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('publisher: $publisher, ')
          ..write('clcCode: $clcCode, ')
          ..write('rating: $rating, ')
          ..write('remarks: $remarks, ')
          ..write('coverPath: $coverPath, ')
          ..write('createTime: $createTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fileHash,
    title,
    author,
    publisher,
    clcCode,
    rating,
    remarks,
    coverPath,
    createTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Volume &&
          other.id == this.id &&
          other.fileHash == this.fileHash &&
          other.title == this.title &&
          other.author == this.author &&
          other.publisher == this.publisher &&
          other.clcCode == this.clcCode &&
          other.rating == this.rating &&
          other.remarks == this.remarks &&
          other.coverPath == this.coverPath &&
          other.createTime == this.createTime);
}

class VolumesCompanion extends UpdateCompanion<Volume> {
  final Value<int> id;
  final Value<String> fileHash;
  final Value<String> title;
  final Value<String?> author;
  final Value<String?> publisher;
  final Value<String> clcCode;
  final Value<int> rating;
  final Value<String?> remarks;
  final Value<String?> coverPath;
  final Value<DateTime> createTime;
  const VolumesCompanion({
    this.id = const Value.absent(),
    this.fileHash = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.publisher = const Value.absent(),
    this.clcCode = const Value.absent(),
    this.rating = const Value.absent(),
    this.remarks = const Value.absent(),
    this.coverPath = const Value.absent(),
    this.createTime = const Value.absent(),
  });
  VolumesCompanion.insert({
    this.id = const Value.absent(),
    required String fileHash,
    required String title,
    this.author = const Value.absent(),
    this.publisher = const Value.absent(),
    required String clcCode,
    this.rating = const Value.absent(),
    this.remarks = const Value.absent(),
    this.coverPath = const Value.absent(),
    this.createTime = const Value.absent(),
  }) : fileHash = Value(fileHash),
       title = Value(title),
       clcCode = Value(clcCode);
  static Insertable<Volume> custom({
    Expression<int>? id,
    Expression<String>? fileHash,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? publisher,
    Expression<String>? clcCode,
    Expression<int>? rating,
    Expression<String>? remarks,
    Expression<String>? coverPath,
    Expression<DateTime>? createTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileHash != null) 'file_hash': fileHash,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (publisher != null) 'publisher': publisher,
      if (clcCode != null) 'clc_code': clcCode,
      if (rating != null) 'rating': rating,
      if (remarks != null) 'remarks': remarks,
      if (coverPath != null) 'cover_path': coverPath,
      if (createTime != null) 'create_time': createTime,
    });
  }

  VolumesCompanion copyWith({
    Value<int>? id,
    Value<String>? fileHash,
    Value<String>? title,
    Value<String?>? author,
    Value<String?>? publisher,
    Value<String>? clcCode,
    Value<int>? rating,
    Value<String?>? remarks,
    Value<String?>? coverPath,
    Value<DateTime>? createTime,
  }) {
    return VolumesCompanion(
      id: id ?? this.id,
      fileHash: fileHash ?? this.fileHash,
      title: title ?? this.title,
      author: author ?? this.author,
      publisher: publisher ?? this.publisher,
      clcCode: clcCode ?? this.clcCode,
      rating: rating ?? this.rating,
      remarks: remarks ?? this.remarks,
      coverPath: coverPath ?? this.coverPath,
      createTime: createTime ?? this.createTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fileHash.present) {
      map['file_hash'] = Variable<String>(fileHash.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (publisher.present) {
      map['publisher'] = Variable<String>(publisher.value);
    }
    if (clcCode.present) {
      map['clc_code'] = Variable<String>(clcCode.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (coverPath.present) {
      map['cover_path'] = Variable<String>(coverPath.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VolumesCompanion(')
          ..write('id: $id, ')
          ..write('fileHash: $fileHash, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('publisher: $publisher, ')
          ..write('clcCode: $clcCode, ')
          ..write('rating: $rating, ')
          ..write('remarks: $remarks, ')
          ..write('coverPath: $coverPath, ')
          ..write('createTime: $createTime')
          ..write(')'))
        .toString();
  }
}

class $VolumeLocationsTable extends VolumeLocations
    with TableInfo<$VolumeLocationsTable, VolumeLocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VolumeLocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _volumeIdMeta = const VerificationMeta(
    'volumeId',
  );
  @override
  late final GeneratedColumn<int> volumeId = GeneratedColumn<int>(
    'volume_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES volumes (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<BookMediaType, int> mediaType =
      GeneratedColumn<int>(
        'media_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: Constant(BookMediaType.epub.index),
      ).withConverter<BookMediaType>($VolumeLocationsTable.$convertermediaType);
  static const VerificationMeta _relativePathMeta = const VerificationMeta(
    'relativePath',
  );
  @override
  late final GeneratedColumn<String> relativePath = GeneratedColumn<String>(
    'relative_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    volumeId,
    mediaType,
    relativePath,
    fileSize,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'volume_locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<VolumeLocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('volume_id')) {
      context.handle(
        _volumeIdMeta,
        volumeId.isAcceptableOrUnknown(data['volume_id']!, _volumeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeIdMeta);
    }
    if (data.containsKey('relative_path')) {
      context.handle(
        _relativePathMeta,
        relativePath.isAcceptableOrUnknown(
          data['relative_path']!,
          _relativePathMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_relativePathMeta);
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VolumeLocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VolumeLocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      volumeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume_id'],
      )!,
      mediaType: $VolumeLocationsTable.$convertermediaType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}media_type'],
        )!,
      ),
      relativePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relative_path'],
      )!,
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      ),
    );
  }

  @override
  $VolumeLocationsTable createAlias(String alias) {
    return $VolumeLocationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BookMediaType, int, int> $convertermediaType =
      const EnumIndexConverter<BookMediaType>(BookMediaType.values);
}

class VolumeLocation extends DataClass implements Insertable<VolumeLocation> {
  final int id;
  final int volumeId;
  final BookMediaType mediaType;
  final String relativePath;
  final int? fileSize;
  const VolumeLocation({
    required this.id,
    required this.volumeId,
    required this.mediaType,
    required this.relativePath,
    this.fileSize,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['volume_id'] = Variable<int>(volumeId);
    {
      map['media_type'] = Variable<int>(
        $VolumeLocationsTable.$convertermediaType.toSql(mediaType),
      );
    }
    map['relative_path'] = Variable<String>(relativePath);
    if (!nullToAbsent || fileSize != null) {
      map['file_size'] = Variable<int>(fileSize);
    }
    return map;
  }

  VolumeLocationsCompanion toCompanion(bool nullToAbsent) {
    return VolumeLocationsCompanion(
      id: Value(id),
      volumeId: Value(volumeId),
      mediaType: Value(mediaType),
      relativePath: Value(relativePath),
      fileSize: fileSize == null && nullToAbsent
          ? const Value.absent()
          : Value(fileSize),
    );
  }

  factory VolumeLocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VolumeLocation(
      id: serializer.fromJson<int>(json['id']),
      volumeId: serializer.fromJson<int>(json['volumeId']),
      mediaType: $VolumeLocationsTable.$convertermediaType.fromJson(
        serializer.fromJson<int>(json['mediaType']),
      ),
      relativePath: serializer.fromJson<String>(json['relativePath']),
      fileSize: serializer.fromJson<int?>(json['fileSize']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'volumeId': serializer.toJson<int>(volumeId),
      'mediaType': serializer.toJson<int>(
        $VolumeLocationsTable.$convertermediaType.toJson(mediaType),
      ),
      'relativePath': serializer.toJson<String>(relativePath),
      'fileSize': serializer.toJson<int?>(fileSize),
    };
  }

  VolumeLocation copyWith({
    int? id,
    int? volumeId,
    BookMediaType? mediaType,
    String? relativePath,
    Value<int?> fileSize = const Value.absent(),
  }) => VolumeLocation(
    id: id ?? this.id,
    volumeId: volumeId ?? this.volumeId,
    mediaType: mediaType ?? this.mediaType,
    relativePath: relativePath ?? this.relativePath,
    fileSize: fileSize.present ? fileSize.value : this.fileSize,
  );
  VolumeLocation copyWithCompanion(VolumeLocationsCompanion data) {
    return VolumeLocation(
      id: data.id.present ? data.id.value : this.id,
      volumeId: data.volumeId.present ? data.volumeId.value : this.volumeId,
      mediaType: data.mediaType.present ? data.mediaType.value : this.mediaType,
      relativePath: data.relativePath.present
          ? data.relativePath.value
          : this.relativePath,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VolumeLocation(')
          ..write('id: $id, ')
          ..write('volumeId: $volumeId, ')
          ..write('mediaType: $mediaType, ')
          ..write('relativePath: $relativePath, ')
          ..write('fileSize: $fileSize')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, volumeId, mediaType, relativePath, fileSize);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VolumeLocation &&
          other.id == this.id &&
          other.volumeId == this.volumeId &&
          other.mediaType == this.mediaType &&
          other.relativePath == this.relativePath &&
          other.fileSize == this.fileSize);
}

class VolumeLocationsCompanion extends UpdateCompanion<VolumeLocation> {
  final Value<int> id;
  final Value<int> volumeId;
  final Value<BookMediaType> mediaType;
  final Value<String> relativePath;
  final Value<int?> fileSize;
  const VolumeLocationsCompanion({
    this.id = const Value.absent(),
    this.volumeId = const Value.absent(),
    this.mediaType = const Value.absent(),
    this.relativePath = const Value.absent(),
    this.fileSize = const Value.absent(),
  });
  VolumeLocationsCompanion.insert({
    this.id = const Value.absent(),
    required int volumeId,
    this.mediaType = const Value.absent(),
    required String relativePath,
    this.fileSize = const Value.absent(),
  }) : volumeId = Value(volumeId),
       relativePath = Value(relativePath);
  static Insertable<VolumeLocation> custom({
    Expression<int>? id,
    Expression<int>? volumeId,
    Expression<int>? mediaType,
    Expression<String>? relativePath,
    Expression<int>? fileSize,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (volumeId != null) 'volume_id': volumeId,
      if (mediaType != null) 'media_type': mediaType,
      if (relativePath != null) 'relative_path': relativePath,
      if (fileSize != null) 'file_size': fileSize,
    });
  }

  VolumeLocationsCompanion copyWith({
    Value<int>? id,
    Value<int>? volumeId,
    Value<BookMediaType>? mediaType,
    Value<String>? relativePath,
    Value<int?>? fileSize,
  }) {
    return VolumeLocationsCompanion(
      id: id ?? this.id,
      volumeId: volumeId ?? this.volumeId,
      mediaType: mediaType ?? this.mediaType,
      relativePath: relativePath ?? this.relativePath,
      fileSize: fileSize ?? this.fileSize,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (volumeId.present) {
      map['volume_id'] = Variable<int>(volumeId.value);
    }
    if (mediaType.present) {
      map['media_type'] = Variable<int>(
        $VolumeLocationsTable.$convertermediaType.toSql(mediaType.value),
      );
    }
    if (relativePath.present) {
      map['relative_path'] = Variable<String>(relativePath.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VolumeLocationsCompanion(')
          ..write('id: $id, ')
          ..write('volumeId: $volumeId, ')
          ..write('mediaType: $mediaType, ')
          ..write('relativePath: $relativePath, ')
          ..write('fileSize: $fileSize')
          ..write(')'))
        .toString();
  }
}

class $FragmentsTable extends Fragments
    with TableInfo<$FragmentsTable, Fragment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FragmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _volumeIdMeta = const VerificationMeta(
    'volumeId',
  );
  @override
  late final GeneratedColumn<int> volumeId = GeneratedColumn<int>(
    'volume_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES volumes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _postionAnchorMeta = const VerificationMeta(
    'postionAnchor',
  );
  @override
  late final GeneratedColumn<String> postionAnchor = GeneratedColumn<String>(
    'postion_anchor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    volumeId,
    title,
    postionAnchor,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fragments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Fragment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('volume_id')) {
      context.handle(
        _volumeIdMeta,
        volumeId.isAcceptableOrUnknown(data['volume_id']!, _volumeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('postion_anchor')) {
      context.handle(
        _postionAnchorMeta,
        postionAnchor.isAcceptableOrUnknown(
          data['postion_anchor']!,
          _postionAnchorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_postionAnchorMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fragment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fragment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      volumeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      postionAnchor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postion_anchor'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $FragmentsTable createAlias(String alias) {
    return $FragmentsTable(attachedDatabase, alias);
  }
}

class Fragment extends DataClass implements Insertable<Fragment> {
  final int id;
  final int volumeId;
  final String title;
  final String postionAnchor;
  final int sortOrder;
  const Fragment({
    required this.id,
    required this.volumeId,
    required this.title,
    required this.postionAnchor,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['volume_id'] = Variable<int>(volumeId);
    map['title'] = Variable<String>(title);
    map['postion_anchor'] = Variable<String>(postionAnchor);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  FragmentsCompanion toCompanion(bool nullToAbsent) {
    return FragmentsCompanion(
      id: Value(id),
      volumeId: Value(volumeId),
      title: Value(title),
      postionAnchor: Value(postionAnchor),
      sortOrder: Value(sortOrder),
    );
  }

  factory Fragment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fragment(
      id: serializer.fromJson<int>(json['id']),
      volumeId: serializer.fromJson<int>(json['volumeId']),
      title: serializer.fromJson<String>(json['title']),
      postionAnchor: serializer.fromJson<String>(json['postionAnchor']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'volumeId': serializer.toJson<int>(volumeId),
      'title': serializer.toJson<String>(title),
      'postionAnchor': serializer.toJson<String>(postionAnchor),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Fragment copyWith({
    int? id,
    int? volumeId,
    String? title,
    String? postionAnchor,
    int? sortOrder,
  }) => Fragment(
    id: id ?? this.id,
    volumeId: volumeId ?? this.volumeId,
    title: title ?? this.title,
    postionAnchor: postionAnchor ?? this.postionAnchor,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Fragment copyWithCompanion(FragmentsCompanion data) {
    return Fragment(
      id: data.id.present ? data.id.value : this.id,
      volumeId: data.volumeId.present ? data.volumeId.value : this.volumeId,
      title: data.title.present ? data.title.value : this.title,
      postionAnchor: data.postionAnchor.present
          ? data.postionAnchor.value
          : this.postionAnchor,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Fragment(')
          ..write('id: $id, ')
          ..write('volumeId: $volumeId, ')
          ..write('title: $title, ')
          ..write('postionAnchor: $postionAnchor, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, volumeId, title, postionAnchor, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fragment &&
          other.id == this.id &&
          other.volumeId == this.volumeId &&
          other.title == this.title &&
          other.postionAnchor == this.postionAnchor &&
          other.sortOrder == this.sortOrder);
}

class FragmentsCompanion extends UpdateCompanion<Fragment> {
  final Value<int> id;
  final Value<int> volumeId;
  final Value<String> title;
  final Value<String> postionAnchor;
  final Value<int> sortOrder;
  const FragmentsCompanion({
    this.id = const Value.absent(),
    this.volumeId = const Value.absent(),
    this.title = const Value.absent(),
    this.postionAnchor = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  FragmentsCompanion.insert({
    this.id = const Value.absent(),
    required int volumeId,
    required String title,
    required String postionAnchor,
    required int sortOrder,
  }) : volumeId = Value(volumeId),
       title = Value(title),
       postionAnchor = Value(postionAnchor),
       sortOrder = Value(sortOrder);
  static Insertable<Fragment> custom({
    Expression<int>? id,
    Expression<int>? volumeId,
    Expression<String>? title,
    Expression<String>? postionAnchor,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (volumeId != null) 'volume_id': volumeId,
      if (title != null) 'title': title,
      if (postionAnchor != null) 'postion_anchor': postionAnchor,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  FragmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? volumeId,
    Value<String>? title,
    Value<String>? postionAnchor,
    Value<int>? sortOrder,
  }) {
    return FragmentsCompanion(
      id: id ?? this.id,
      volumeId: volumeId ?? this.volumeId,
      title: title ?? this.title,
      postionAnchor: postionAnchor ?? this.postionAnchor,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (volumeId.present) {
      map['volume_id'] = Variable<int>(volumeId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (postionAnchor.present) {
      map['postion_anchor'] = Variable<String>(postionAnchor.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentsCompanion(')
          ..write('id: $id, ')
          ..write('volumeId: $volumeId, ')
          ..write('title: $title, ')
          ..write('postionAnchor: $postionAnchor, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $ReadingProgressTable extends ReadingProgress
    with TableInfo<$ReadingProgressTable, ReadingProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _volumeIdMeta = const VerificationMeta(
    'volumeId',
  );
  @override
  late final GeneratedColumn<int> volumeId = GeneratedColumn<int>(
    'volume_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES volumes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _lastAnchorMeta = const VerificationMeta(
    'lastAnchor',
  );
  @override
  late final GeneratedColumn<String> lastAnchor = GeneratedColumn<String>(
    'last_anchor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _percentageMeta = const VerificationMeta(
    'percentage',
  );
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
    'percentage',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _updateTimeMeta = const VerificationMeta(
    'updateTime',
  );
  @override
  late final GeneratedColumn<DateTime> updateTime = GeneratedColumn<DateTime>(
    'update_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    volumeId,
    lastAnchor,
    percentage,
    updateTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('volume_id')) {
      context.handle(
        _volumeIdMeta,
        volumeId.isAcceptableOrUnknown(data['volume_id']!, _volumeIdMeta),
      );
    }
    if (data.containsKey('last_anchor')) {
      context.handle(
        _lastAnchorMeta,
        lastAnchor.isAcceptableOrUnknown(data['last_anchor']!, _lastAnchorMeta),
      );
    } else if (isInserting) {
      context.missing(_lastAnchorMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
        _percentageMeta,
        percentage.isAcceptableOrUnknown(data['percentage']!, _percentageMeta),
      );
    }
    if (data.containsKey('update_time')) {
      context.handle(
        _updateTimeMeta,
        updateTime.isAcceptableOrUnknown(data['update_time']!, _updateTimeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {volumeId};
  @override
  ReadingProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingProgressData(
      volumeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume_id'],
      )!,
      lastAnchor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_anchor'],
      )!,
      percentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}percentage'],
      )!,
      updateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}update_time'],
      )!,
    );
  }

  @override
  $ReadingProgressTable createAlias(String alias) {
    return $ReadingProgressTable(attachedDatabase, alias);
  }
}

class ReadingProgressData extends DataClass
    implements Insertable<ReadingProgressData> {
  final int volumeId;
  final String lastAnchor;
  final double percentage;
  final DateTime updateTime;
  const ReadingProgressData({
    required this.volumeId,
    required this.lastAnchor,
    required this.percentage,
    required this.updateTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['volume_id'] = Variable<int>(volumeId);
    map['last_anchor'] = Variable<String>(lastAnchor);
    map['percentage'] = Variable<double>(percentage);
    map['update_time'] = Variable<DateTime>(updateTime);
    return map;
  }

  ReadingProgressCompanion toCompanion(bool nullToAbsent) {
    return ReadingProgressCompanion(
      volumeId: Value(volumeId),
      lastAnchor: Value(lastAnchor),
      percentage: Value(percentage),
      updateTime: Value(updateTime),
    );
  }

  factory ReadingProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingProgressData(
      volumeId: serializer.fromJson<int>(json['volumeId']),
      lastAnchor: serializer.fromJson<String>(json['lastAnchor']),
      percentage: serializer.fromJson<double>(json['percentage']),
      updateTime: serializer.fromJson<DateTime>(json['updateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'volumeId': serializer.toJson<int>(volumeId),
      'lastAnchor': serializer.toJson<String>(lastAnchor),
      'percentage': serializer.toJson<double>(percentage),
      'updateTime': serializer.toJson<DateTime>(updateTime),
    };
  }

  ReadingProgressData copyWith({
    int? volumeId,
    String? lastAnchor,
    double? percentage,
    DateTime? updateTime,
  }) => ReadingProgressData(
    volumeId: volumeId ?? this.volumeId,
    lastAnchor: lastAnchor ?? this.lastAnchor,
    percentage: percentage ?? this.percentage,
    updateTime: updateTime ?? this.updateTime,
  );
  ReadingProgressData copyWithCompanion(ReadingProgressCompanion data) {
    return ReadingProgressData(
      volumeId: data.volumeId.present ? data.volumeId.value : this.volumeId,
      lastAnchor: data.lastAnchor.present
          ? data.lastAnchor.value
          : this.lastAnchor,
      percentage: data.percentage.present
          ? data.percentage.value
          : this.percentage,
      updateTime: data.updateTime.present
          ? data.updateTime.value
          : this.updateTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressData(')
          ..write('volumeId: $volumeId, ')
          ..write('lastAnchor: $lastAnchor, ')
          ..write('percentage: $percentage, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(volumeId, lastAnchor, percentage, updateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingProgressData &&
          other.volumeId == this.volumeId &&
          other.lastAnchor == this.lastAnchor &&
          other.percentage == this.percentage &&
          other.updateTime == this.updateTime);
}

class ReadingProgressCompanion extends UpdateCompanion<ReadingProgressData> {
  final Value<int> volumeId;
  final Value<String> lastAnchor;
  final Value<double> percentage;
  final Value<DateTime> updateTime;
  const ReadingProgressCompanion({
    this.volumeId = const Value.absent(),
    this.lastAnchor = const Value.absent(),
    this.percentage = const Value.absent(),
    this.updateTime = const Value.absent(),
  });
  ReadingProgressCompanion.insert({
    this.volumeId = const Value.absent(),
    required String lastAnchor,
    this.percentage = const Value.absent(),
    this.updateTime = const Value.absent(),
  }) : lastAnchor = Value(lastAnchor);
  static Insertable<ReadingProgressData> custom({
    Expression<int>? volumeId,
    Expression<String>? lastAnchor,
    Expression<double>? percentage,
    Expression<DateTime>? updateTime,
  }) {
    return RawValuesInsertable({
      if (volumeId != null) 'volume_id': volumeId,
      if (lastAnchor != null) 'last_anchor': lastAnchor,
      if (percentage != null) 'percentage': percentage,
      if (updateTime != null) 'update_time': updateTime,
    });
  }

  ReadingProgressCompanion copyWith({
    Value<int>? volumeId,
    Value<String>? lastAnchor,
    Value<double>? percentage,
    Value<DateTime>? updateTime,
  }) {
    return ReadingProgressCompanion(
      volumeId: volumeId ?? this.volumeId,
      lastAnchor: lastAnchor ?? this.lastAnchor,
      percentage: percentage ?? this.percentage,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (volumeId.present) {
      map['volume_id'] = Variable<int>(volumeId.value);
    }
    if (lastAnchor.present) {
      map['last_anchor'] = Variable<String>(lastAnchor.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (updateTime.present) {
      map['update_time'] = Variable<DateTime>(updateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressCompanion(')
          ..write('volumeId: $volumeId, ')
          ..write('lastAnchor: $lastAnchor, ')
          ..write('percentage: $percentage, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }
}

class $GemsTable extends Gems with TableInfo<$GemsTable, Gem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _volumeIdMeta = const VerificationMeta(
    'volumeId',
  );
  @override
  late final GeneratedColumn<int> volumeId = GeneratedColumn<int>(
    'volume_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES volumes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _anchorMeta = const VerificationMeta('anchor');
  @override
  late final GeneratedColumn<String> anchor = GeneratedColumn<String>(
    'anchor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createTimeMeta = const VerificationMeta(
    'createTime',
  );
  @override
  late final GeneratedColumn<DateTime> createTime = GeneratedColumn<DateTime>(
    'create_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _chapterTitleMeta = const VerificationMeta(
    'chapterTitle',
  );
  @override
  late final GeneratedColumn<String> chapterTitle = GeneratedColumn<String>(
    'chapter_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    volumeId,
    content,
    anchor,
    createTime,
    chapterTitle,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gems';
  @override
  VerificationContext validateIntegrity(
    Insertable<Gem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('volume_id')) {
      context.handle(
        _volumeIdMeta,
        volumeId.isAcceptableOrUnknown(data['volume_id']!, _volumeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('anchor')) {
      context.handle(
        _anchorMeta,
        anchor.isAcceptableOrUnknown(data['anchor']!, _anchorMeta),
      );
    } else if (isInserting) {
      context.missing(_anchorMeta);
    }
    if (data.containsKey('create_time')) {
      context.handle(
        _createTimeMeta,
        createTime.isAcceptableOrUnknown(data['create_time']!, _createTimeMeta),
      );
    }
    if (data.containsKey('chapter_title')) {
      context.handle(
        _chapterTitleMeta,
        chapterTitle.isAcceptableOrUnknown(
          data['chapter_title']!,
          _chapterTitleMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Gem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      volumeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}volume_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      anchor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}anchor'],
      )!,
      createTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}create_time'],
      )!,
      chapterTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chapter_title'],
      ),
    );
  }

  @override
  $GemsTable createAlias(String alias) {
    return $GemsTable(attachedDatabase, alias);
  }
}

class Gem extends DataClass implements Insertable<Gem> {
  final int id;
  final int volumeId;
  final String content;
  final String anchor;
  final DateTime createTime;
  final String? chapterTitle;
  const Gem({
    required this.id,
    required this.volumeId,
    required this.content,
    required this.anchor,
    required this.createTime,
    this.chapterTitle,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['volume_id'] = Variable<int>(volumeId);
    map['content'] = Variable<String>(content);
    map['anchor'] = Variable<String>(anchor);
    map['create_time'] = Variable<DateTime>(createTime);
    if (!nullToAbsent || chapterTitle != null) {
      map['chapter_title'] = Variable<String>(chapterTitle);
    }
    return map;
  }

  GemsCompanion toCompanion(bool nullToAbsent) {
    return GemsCompanion(
      id: Value(id),
      volumeId: Value(volumeId),
      content: Value(content),
      anchor: Value(anchor),
      createTime: Value(createTime),
      chapterTitle: chapterTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(chapterTitle),
    );
  }

  factory Gem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Gem(
      id: serializer.fromJson<int>(json['id']),
      volumeId: serializer.fromJson<int>(json['volumeId']),
      content: serializer.fromJson<String>(json['content']),
      anchor: serializer.fromJson<String>(json['anchor']),
      createTime: serializer.fromJson<DateTime>(json['createTime']),
      chapterTitle: serializer.fromJson<String?>(json['chapterTitle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'volumeId': serializer.toJson<int>(volumeId),
      'content': serializer.toJson<String>(content),
      'anchor': serializer.toJson<String>(anchor),
      'createTime': serializer.toJson<DateTime>(createTime),
      'chapterTitle': serializer.toJson<String?>(chapterTitle),
    };
  }

  Gem copyWith({
    int? id,
    int? volumeId,
    String? content,
    String? anchor,
    DateTime? createTime,
    Value<String?> chapterTitle = const Value.absent(),
  }) => Gem(
    id: id ?? this.id,
    volumeId: volumeId ?? this.volumeId,
    content: content ?? this.content,
    anchor: anchor ?? this.anchor,
    createTime: createTime ?? this.createTime,
    chapterTitle: chapterTitle.present ? chapterTitle.value : this.chapterTitle,
  );
  Gem copyWithCompanion(GemsCompanion data) {
    return Gem(
      id: data.id.present ? data.id.value : this.id,
      volumeId: data.volumeId.present ? data.volumeId.value : this.volumeId,
      content: data.content.present ? data.content.value : this.content,
      anchor: data.anchor.present ? data.anchor.value : this.anchor,
      createTime: data.createTime.present
          ? data.createTime.value
          : this.createTime,
      chapterTitle: data.chapterTitle.present
          ? data.chapterTitle.value
          : this.chapterTitle,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gem(')
          ..write('id: $id, ')
          ..write('volumeId: $volumeId, ')
          ..write('content: $content, ')
          ..write('anchor: $anchor, ')
          ..write('createTime: $createTime, ')
          ..write('chapterTitle: $chapterTitle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, volumeId, content, anchor, createTime, chapterTitle);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gem &&
          other.id == this.id &&
          other.volumeId == this.volumeId &&
          other.content == this.content &&
          other.anchor == this.anchor &&
          other.createTime == this.createTime &&
          other.chapterTitle == this.chapterTitle);
}

class GemsCompanion extends UpdateCompanion<Gem> {
  final Value<int> id;
  final Value<int> volumeId;
  final Value<String> content;
  final Value<String> anchor;
  final Value<DateTime> createTime;
  final Value<String?> chapterTitle;
  const GemsCompanion({
    this.id = const Value.absent(),
    this.volumeId = const Value.absent(),
    this.content = const Value.absent(),
    this.anchor = const Value.absent(),
    this.createTime = const Value.absent(),
    this.chapterTitle = const Value.absent(),
  });
  GemsCompanion.insert({
    this.id = const Value.absent(),
    required int volumeId,
    required String content,
    required String anchor,
    this.createTime = const Value.absent(),
    this.chapterTitle = const Value.absent(),
  }) : volumeId = Value(volumeId),
       content = Value(content),
       anchor = Value(anchor);
  static Insertable<Gem> custom({
    Expression<int>? id,
    Expression<int>? volumeId,
    Expression<String>? content,
    Expression<String>? anchor,
    Expression<DateTime>? createTime,
    Expression<String>? chapterTitle,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (volumeId != null) 'volume_id': volumeId,
      if (content != null) 'content': content,
      if (anchor != null) 'anchor': anchor,
      if (createTime != null) 'create_time': createTime,
      if (chapterTitle != null) 'chapter_title': chapterTitle,
    });
  }

  GemsCompanion copyWith({
    Value<int>? id,
    Value<int>? volumeId,
    Value<String>? content,
    Value<String>? anchor,
    Value<DateTime>? createTime,
    Value<String?>? chapterTitle,
  }) {
    return GemsCompanion(
      id: id ?? this.id,
      volumeId: volumeId ?? this.volumeId,
      content: content ?? this.content,
      anchor: anchor ?? this.anchor,
      createTime: createTime ?? this.createTime,
      chapterTitle: chapterTitle ?? this.chapterTitle,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (volumeId.present) {
      map['volume_id'] = Variable<int>(volumeId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (anchor.present) {
      map['anchor'] = Variable<String>(anchor.value);
    }
    if (createTime.present) {
      map['create_time'] = Variable<DateTime>(createTime.value);
    }
    if (chapterTitle.present) {
      map['chapter_title'] = Variable<String>(chapterTitle.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GemsCompanion(')
          ..write('id: $id, ')
          ..write('volumeId: $volumeId, ')
          ..write('content: $content, ')
          ..write('anchor: $anchor, ')
          ..write('createTime: $createTime, ')
          ..write('chapterTitle: $chapterTitle')
          ..write(')'))
        .toString();
  }
}

class $WebDavConfigsTable extends WebDavConfigs
    with TableInfo<$WebDavConfigsTable, WebDavConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WebDavConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
  );
  static const VerificationMeta _rootPathMeta = const VerificationMeta(
    'rootPath',
  );
  @override
  late final GeneratedColumn<String> rootPath = GeneratedColumn<String>(
    'root_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant("iyoot"),
  );
  static const VerificationMeta _keepLatestOnlyMeta = const VerificationMeta(
    'keepLatestOnly',
  );
  @override
  late final GeneratedColumn<bool> keepLatestOnly = GeneratedColumn<bool>(
    'keep_latest_only',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("keep_latest_only" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _autoCheckNewMeta = const VerificationMeta(
    'autoCheckNew',
  );
  @override
  late final GeneratedColumn<bool> autoCheckNew = GeneratedColumn<bool>(
    'auto_check_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_check_new" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastSyncTimeMeta = const VerificationMeta(
    'lastSyncTime',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncTime = GeneratedColumn<DateTime>(
    'last_sync_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    url,
    username,
    password,
    rootPath,
    keepLatestOnly,
    autoCheckNew,
    isEnabled,
    lastSyncTime,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'web_dav_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WebDavConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    }
    if (data.containsKey('root_path')) {
      context.handle(
        _rootPathMeta,
        rootPath.isAcceptableOrUnknown(data['root_path']!, _rootPathMeta),
      );
    }
    if (data.containsKey('keep_latest_only')) {
      context.handle(
        _keepLatestOnlyMeta,
        keepLatestOnly.isAcceptableOrUnknown(
          data['keep_latest_only']!,
          _keepLatestOnlyMeta,
        ),
      );
    }
    if (data.containsKey('auto_check_new')) {
      context.handle(
        _autoCheckNewMeta,
        autoCheckNew.isAcceptableOrUnknown(
          data['auto_check_new']!,
          _autoCheckNewMeta,
        ),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('last_sync_time')) {
      context.handle(
        _lastSyncTimeMeta,
        lastSyncTime.isAcceptableOrUnknown(
          data['last_sync_time']!,
          _lastSyncTimeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WebDavConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WebDavConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
      rootPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}root_path'],
      )!,
      keepLatestOnly: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}keep_latest_only'],
      )!,
      autoCheckNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_check_new'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      lastSyncTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync_time'],
      ),
    );
  }

  @override
  $WebDavConfigsTable createAlias(String alias) {
    return $WebDavConfigsTable(attachedDatabase, alias);
  }
}

class WebDavConfig extends DataClass implements Insertable<WebDavConfig> {
  final int id;

  /// WebDAV 服务器地址
  final String url;

  /// 账号
  final String username;

  /// 密码 (加密存储)
  final String password;

  /// 存放根目录
  final String rootPath;

  /// 仅保留最新备份
  final bool keepLatestOnly;

  /// 自动检查新备份
  final bool autoCheckNew;

  /// 是否启用同步
  final bool isEnabled;

  /// 上次同步时间
  final DateTime? lastSyncTime;
  const WebDavConfig({
    required this.id,
    required this.url,
    required this.username,
    required this.password,
    required this.rootPath,
    required this.keepLatestOnly,
    required this.autoCheckNew,
    required this.isEnabled,
    this.lastSyncTime,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['url'] = Variable<String>(url);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    map['root_path'] = Variable<String>(rootPath);
    map['keep_latest_only'] = Variable<bool>(keepLatestOnly);
    map['auto_check_new'] = Variable<bool>(autoCheckNew);
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || lastSyncTime != null) {
      map['last_sync_time'] = Variable<DateTime>(lastSyncTime);
    }
    return map;
  }

  WebDavConfigsCompanion toCompanion(bool nullToAbsent) {
    return WebDavConfigsCompanion(
      id: Value(id),
      url: Value(url),
      username: Value(username),
      password: Value(password),
      rootPath: Value(rootPath),
      keepLatestOnly: Value(keepLatestOnly),
      autoCheckNew: Value(autoCheckNew),
      isEnabled: Value(isEnabled),
      lastSyncTime: lastSyncTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncTime),
    );
  }

  factory WebDavConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WebDavConfig(
      id: serializer.fromJson<int>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      rootPath: serializer.fromJson<String>(json['rootPath']),
      keepLatestOnly: serializer.fromJson<bool>(json['keepLatestOnly']),
      autoCheckNew: serializer.fromJson<bool>(json['autoCheckNew']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      lastSyncTime: serializer.fromJson<DateTime?>(json['lastSyncTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'url': serializer.toJson<String>(url),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'rootPath': serializer.toJson<String>(rootPath),
      'keepLatestOnly': serializer.toJson<bool>(keepLatestOnly),
      'autoCheckNew': serializer.toJson<bool>(autoCheckNew),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'lastSyncTime': serializer.toJson<DateTime?>(lastSyncTime),
    };
  }

  WebDavConfig copyWith({
    int? id,
    String? url,
    String? username,
    String? password,
    String? rootPath,
    bool? keepLatestOnly,
    bool? autoCheckNew,
    bool? isEnabled,
    Value<DateTime?> lastSyncTime = const Value.absent(),
  }) => WebDavConfig(
    id: id ?? this.id,
    url: url ?? this.url,
    username: username ?? this.username,
    password: password ?? this.password,
    rootPath: rootPath ?? this.rootPath,
    keepLatestOnly: keepLatestOnly ?? this.keepLatestOnly,
    autoCheckNew: autoCheckNew ?? this.autoCheckNew,
    isEnabled: isEnabled ?? this.isEnabled,
    lastSyncTime: lastSyncTime.present ? lastSyncTime.value : this.lastSyncTime,
  );
  WebDavConfig copyWithCompanion(WebDavConfigsCompanion data) {
    return WebDavConfig(
      id: data.id.present ? data.id.value : this.id,
      url: data.url.present ? data.url.value : this.url,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
      rootPath: data.rootPath.present ? data.rootPath.value : this.rootPath,
      keepLatestOnly: data.keepLatestOnly.present
          ? data.keepLatestOnly.value
          : this.keepLatestOnly,
      autoCheckNew: data.autoCheckNew.present
          ? data.autoCheckNew.value
          : this.autoCheckNew,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      lastSyncTime: data.lastSyncTime.present
          ? data.lastSyncTime.value
          : this.lastSyncTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WebDavConfig(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('rootPath: $rootPath, ')
          ..write('keepLatestOnly: $keepLatestOnly, ')
          ..write('autoCheckNew: $autoCheckNew, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('lastSyncTime: $lastSyncTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    url,
    username,
    password,
    rootPath,
    keepLatestOnly,
    autoCheckNew,
    isEnabled,
    lastSyncTime,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WebDavConfig &&
          other.id == this.id &&
          other.url == this.url &&
          other.username == this.username &&
          other.password == this.password &&
          other.rootPath == this.rootPath &&
          other.keepLatestOnly == this.keepLatestOnly &&
          other.autoCheckNew == this.autoCheckNew &&
          other.isEnabled == this.isEnabled &&
          other.lastSyncTime == this.lastSyncTime);
}

class WebDavConfigsCompanion extends UpdateCompanion<WebDavConfig> {
  final Value<int> id;
  final Value<String> url;
  final Value<String> username;
  final Value<String> password;
  final Value<String> rootPath;
  final Value<bool> keepLatestOnly;
  final Value<bool> autoCheckNew;
  final Value<bool> isEnabled;
  final Value<DateTime?> lastSyncTime;
  const WebDavConfigsCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.rootPath = const Value.absent(),
    this.keepLatestOnly = const Value.absent(),
    this.autoCheckNew = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.lastSyncTime = const Value.absent(),
  });
  WebDavConfigsCompanion.insert({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.rootPath = const Value.absent(),
    this.keepLatestOnly = const Value.absent(),
    this.autoCheckNew = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.lastSyncTime = const Value.absent(),
  });
  static Insertable<WebDavConfig> custom({
    Expression<int>? id,
    Expression<String>? url,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String>? rootPath,
    Expression<bool>? keepLatestOnly,
    Expression<bool>? autoCheckNew,
    Expression<bool>? isEnabled,
    Expression<DateTime>? lastSyncTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (rootPath != null) 'root_path': rootPath,
      if (keepLatestOnly != null) 'keep_latest_only': keepLatestOnly,
      if (autoCheckNew != null) 'auto_check_new': autoCheckNew,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (lastSyncTime != null) 'last_sync_time': lastSyncTime,
    });
  }

  WebDavConfigsCompanion copyWith({
    Value<int>? id,
    Value<String>? url,
    Value<String>? username,
    Value<String>? password,
    Value<String>? rootPath,
    Value<bool>? keepLatestOnly,
    Value<bool>? autoCheckNew,
    Value<bool>? isEnabled,
    Value<DateTime?>? lastSyncTime,
  }) {
    return WebDavConfigsCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      username: username ?? this.username,
      password: password ?? this.password,
      rootPath: rootPath ?? this.rootPath,
      keepLatestOnly: keepLatestOnly ?? this.keepLatestOnly,
      autoCheckNew: autoCheckNew ?? this.autoCheckNew,
      isEnabled: isEnabled ?? this.isEnabled,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (rootPath.present) {
      map['root_path'] = Variable<String>(rootPath.value);
    }
    if (keepLatestOnly.present) {
      map['keep_latest_only'] = Variable<bool>(keepLatestOnly.value);
    }
    if (autoCheckNew.present) {
      map['auto_check_new'] = Variable<bool>(autoCheckNew.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (lastSyncTime.present) {
      map['last_sync_time'] = Variable<DateTime>(lastSyncTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WebDavConfigsCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('rootPath: $rootPath, ')
          ..write('keepLatestOnly: $keepLatestOnly, ')
          ..write('autoCheckNew: $autoCheckNew, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('lastSyncTime: $lastSyncTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PreferencesTableTable preferencesTable = $PreferencesTableTable(
    this,
  );
  late final $ClcCategoriesTable clcCategories = $ClcCategoriesTable(this);
  late final $VolumesTable volumes = $VolumesTable(this);
  late final $VolumeLocationsTable volumeLocations = $VolumeLocationsTable(
    this,
  );
  late final $FragmentsTable fragments = $FragmentsTable(this);
  late final $ReadingProgressTable readingProgress = $ReadingProgressTable(
    this,
  );
  late final $GemsTable gems = $GemsTable(this);
  late final $WebDavConfigsTable webDavConfigs = $WebDavConfigsTable(this);
  late final WebDavDao webDavDao = WebDavDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    preferencesTable,
    clcCategories,
    volumes,
    volumeLocations,
    fragments,
    readingProgress,
    gems,
    webDavConfigs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'volumes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('volume_locations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'volumes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fragments', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'volumes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reading_progress', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'volumes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('gems', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PreferencesTableTableCreateCompanionBuilder =
    PreferencesTableCompanion Function({
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
typedef $$PreferencesTableTableUpdateCompanionBuilder =
    PreferencesTableCompanion Function({
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFirstRun => $composableBuilder(
    column: $table.isFirstRun,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ThemeMode, ThemeMode, String> get themeMode =>
      $composableBuilder(
        column: $table.themeMode,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Locale, Locale, String> get locale =>
      $composableBuilder(
        column: $table.locale,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get isDarkMode => $composableBuilder(
    column: $table.isDarkMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cacheMusic => $composableBuilder(
    column: $table.cacheMusic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get downloadLocation => $composableBuilder(
    column: $table.downloadLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultToastOp => $composableBuilder(
    column: $table.defaultToastOp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableAutoPlay => $composableBuilder(
    column: $table.enableAutoPlay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enableOpenHA => $composableBuilder(
    column: $table.enableOpenHA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LayoutMode, LayoutMode, String>
  get layoutMode => $composableBuilder(
    column: $table.layoutMode,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFirstRun => $composableBuilder(
    column: $table.isFirstRun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locale => $composableBuilder(
    column: $table.locale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDarkMode => $composableBuilder(
    column: $table.isDarkMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cacheMusic => $composableBuilder(
    column: $table.cacheMusic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get downloadLocation => $composableBuilder(
    column: $table.downloadLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultToastOp => $composableBuilder(
    column: $table.defaultToastOp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableAutoPlay => $composableBuilder(
    column: $table.enableAutoPlay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enableOpenHA => $composableBuilder(
    column: $table.enableOpenHA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get layoutMode => $composableBuilder(
    column: $table.layoutMode,
    builder: (column) => ColumnOrderings(column),
  );
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
    column: $table.isFirstRun,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<ThemeMode, String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Locale, String> get locale =>
      $composableBuilder(column: $table.locale, builder: (column) => column);

  GeneratedColumn<bool> get isDarkMode => $composableBuilder(
    column: $table.isDarkMode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get cacheMusic => $composableBuilder(
    column: $table.cacheMusic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get downloadLocation => $composableBuilder(
    column: $table.downloadLocation,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultToastOp => $composableBuilder(
    column: $table.defaultToastOp,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableAutoPlay => $composableBuilder(
    column: $table.enableAutoPlay,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get enableOpenHA => $composableBuilder(
    column: $table.enableOpenHA,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LayoutMode, String> get layoutMode =>
      $composableBuilder(
        column: $table.layoutMode,
        builder: (column) => column,
      );
}

class $$PreferencesTableTableTableManager
    extends
        RootTableManager<
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
            BaseReferences<
              _$AppDatabase,
              $PreferencesTableTable,
              PreferencesTableData
            >,
          ),
          PreferencesTableData,
          PrefetchHooks Function()
        > {
  $$PreferencesTableTableTableManager(
    _$AppDatabase db,
    $PreferencesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreferencesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreferencesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreferencesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
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
              }) => PreferencesTableCompanion(
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
          createCompanionCallback:
              ({
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
              }) => PreferencesTableCompanion.insert(
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
        ),
      );
}

typedef $$PreferencesTableTableProcessedTableManager =
    ProcessedTableManager<
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
        BaseReferences<
          _$AppDatabase,
          $PreferencesTableTable,
          PreferencesTableData
        >,
      ),
      PreferencesTableData,
      PrefetchHooks Function()
    >;
typedef $$ClcCategoriesTableCreateCompanionBuilder =
    ClcCategoriesCompanion Function({
      required String code,
      required String name,
      Value<int> rowid,
    });
typedef $$ClcCategoriesTableUpdateCompanionBuilder =
    ClcCategoriesCompanion Function({
      Value<String> code,
      Value<String> name,
      Value<int> rowid,
    });

final class $$ClcCategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $ClcCategoriesTable, ClcCategory> {
  $$ClcCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$VolumesTable, List<Volume>> _volumesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.volumes,
    aliasName: $_aliasNameGenerator(db.clcCategories.code, db.volumes.clcCode),
  );

  $$VolumesTableProcessedTableManager get volumesRefs {
    final manager = $$VolumesTableTableManager(
      $_db,
      $_db.volumes,
    ).filter((f) => f.clcCode.code.sqlEquals($_itemColumn<String>('code')!));

    final cache = $_typedResult.readTableOrNull(_volumesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClcCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ClcCategoriesTable> {
  $$ClcCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> volumesRefs(
    Expression<bool> Function($$VolumesTableFilterComposer f) f,
  ) {
    final $$VolumesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.clcCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableFilterComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClcCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClcCategoriesTable> {
  $$ClcCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClcCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClcCategoriesTable> {
  $$ClcCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> volumesRefs<T extends Object>(
    Expression<T> Function($$VolumesTableAnnotationComposer a) f,
  ) {
    final $$VolumesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.code,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.clcCode,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableAnnotationComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClcCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClcCategoriesTable,
          ClcCategory,
          $$ClcCategoriesTableFilterComposer,
          $$ClcCategoriesTableOrderingComposer,
          $$ClcCategoriesTableAnnotationComposer,
          $$ClcCategoriesTableCreateCompanionBuilder,
          $$ClcCategoriesTableUpdateCompanionBuilder,
          (ClcCategory, $$ClcCategoriesTableReferences),
          ClcCategory,
          PrefetchHooks Function({bool volumesRefs})
        > {
  $$ClcCategoriesTableTableManager(_$AppDatabase db, $ClcCategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClcCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClcCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClcCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  ClcCategoriesCompanion(code: code, name: name, rowid: rowid),
          createCompanionCallback:
              ({
                required String code,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => ClcCategoriesCompanion.insert(
                code: code,
                name: name,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClcCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({volumesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (volumesRefs) db.volumes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (volumesRefs)
                    await $_getPrefetchedData<
                      ClcCategory,
                      $ClcCategoriesTable,
                      Volume
                    >(
                      currentTable: table,
                      referencedTable: $$ClcCategoriesTableReferences
                          ._volumesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ClcCategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).volumesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.clcCode == item.code),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ClcCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClcCategoriesTable,
      ClcCategory,
      $$ClcCategoriesTableFilterComposer,
      $$ClcCategoriesTableOrderingComposer,
      $$ClcCategoriesTableAnnotationComposer,
      $$ClcCategoriesTableCreateCompanionBuilder,
      $$ClcCategoriesTableUpdateCompanionBuilder,
      (ClcCategory, $$ClcCategoriesTableReferences),
      ClcCategory,
      PrefetchHooks Function({bool volumesRefs})
    >;
typedef $$VolumesTableCreateCompanionBuilder =
    VolumesCompanion Function({
      Value<int> id,
      required String fileHash,
      required String title,
      Value<String?> author,
      Value<String?> publisher,
      required String clcCode,
      Value<int> rating,
      Value<String?> remarks,
      Value<String?> coverPath,
      Value<DateTime> createTime,
    });
typedef $$VolumesTableUpdateCompanionBuilder =
    VolumesCompanion Function({
      Value<int> id,
      Value<String> fileHash,
      Value<String> title,
      Value<String?> author,
      Value<String?> publisher,
      Value<String> clcCode,
      Value<int> rating,
      Value<String?> remarks,
      Value<String?> coverPath,
      Value<DateTime> createTime,
    });

final class $$VolumesTableReferences
    extends BaseReferences<_$AppDatabase, $VolumesTable, Volume> {
  $$VolumesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClcCategoriesTable _clcCodeTable(_$AppDatabase db) =>
      db.clcCategories.createAlias(
        $_aliasNameGenerator(db.volumes.clcCode, db.clcCategories.code),
      );

  $$ClcCategoriesTableProcessedTableManager get clcCode {
    final $_column = $_itemColumn<String>('clc_code')!;

    final manager = $$ClcCategoriesTableTableManager(
      $_db,
      $_db.clcCategories,
    ).filter((f) => f.code.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clcCodeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$VolumeLocationsTable, List<VolumeLocation>>
  _volumeLocationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.volumeLocations,
    aliasName: $_aliasNameGenerator(db.volumes.id, db.volumeLocations.volumeId),
  );

  $$VolumeLocationsTableProcessedTableManager get volumeLocationsRefs {
    final manager = $$VolumeLocationsTableTableManager(
      $_db,
      $_db.volumeLocations,
    ).filter((f) => f.volumeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _volumeLocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FragmentsTable, List<Fragment>>
  _fragmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fragments,
    aliasName: $_aliasNameGenerator(db.volumes.id, db.fragments.volumeId),
  );

  $$FragmentsTableProcessedTableManager get fragmentsRefs {
    final manager = $$FragmentsTableTableManager(
      $_db,
      $_db.fragments,
    ).filter((f) => f.volumeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_fragmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReadingProgressTable, List<ReadingProgressData>>
  _readingProgressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.readingProgress,
    aliasName: $_aliasNameGenerator(db.volumes.id, db.readingProgress.volumeId),
  );

  $$ReadingProgressTableProcessedTableManager get readingProgressRefs {
    final manager = $$ReadingProgressTableTableManager(
      $_db,
      $_db.readingProgress,
    ).filter((f) => f.volumeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _readingProgressRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GemsTable, List<Gem>> _gemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.gems,
    aliasName: $_aliasNameGenerator(db.volumes.id, db.gems.volumeId),
  );

  $$GemsTableProcessedTableManager get gemsRefs {
    final manager = $$GemsTableTableManager(
      $_db,
      $_db.gems,
    ).filter((f) => f.volumeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_gemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VolumesTableFilterComposer
    extends Composer<_$AppDatabase, $VolumesTable> {
  $$VolumesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileHash => $composableBuilder(
    column: $table.fileHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnFilters(column),
  );

  $$ClcCategoriesTableFilterComposer get clcCode {
    final $$ClcCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clcCode,
      referencedTable: $db.clcCategories,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClcCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.clcCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> volumeLocationsRefs(
    Expression<bool> Function($$VolumeLocationsTableFilterComposer f) f,
  ) {
    final $$VolumeLocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.volumeLocations,
      getReferencedColumn: (t) => t.volumeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumeLocationsTableFilterComposer(
            $db: $db,
            $table: $db.volumeLocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fragmentsRefs(
    Expression<bool> Function($$FragmentsTableFilterComposer f) f,
  ) {
    final $$FragmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fragments,
      getReferencedColumn: (t) => t.volumeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FragmentsTableFilterComposer(
            $db: $db,
            $table: $db.fragments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> readingProgressRefs(
    Expression<bool> Function($$ReadingProgressTableFilterComposer f) f,
  ) {
    final $$ReadingProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingProgress,
      getReferencedColumn: (t) => t.volumeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingProgressTableFilterComposer(
            $db: $db,
            $table: $db.readingProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gemsRefs(
    Expression<bool> Function($$GemsTableFilterComposer f) f,
  ) {
    final $$GemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gems,
      getReferencedColumn: (t) => t.volumeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GemsTableFilterComposer(
            $db: $db,
            $table: $db.gems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VolumesTableOrderingComposer
    extends Composer<_$AppDatabase, $VolumesTable> {
  $$VolumesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileHash => $composableBuilder(
    column: $table.fileHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get publisher => $composableBuilder(
    column: $table.publisher,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClcCategoriesTableOrderingComposer get clcCode {
    final $$ClcCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clcCode,
      referencedTable: $db.clcCategories,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClcCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.clcCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VolumesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VolumesTable> {
  $$VolumesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileHash =>
      $composableBuilder(column: $table.fileHash, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get publisher =>
      $composableBuilder(column: $table.publisher, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get coverPath =>
      $composableBuilder(column: $table.coverPath, builder: (column) => column);

  GeneratedColumn<DateTime> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );

  $$ClcCategoriesTableAnnotationComposer get clcCode {
    final $$ClcCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clcCode,
      referencedTable: $db.clcCategories,
      getReferencedColumn: (t) => t.code,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClcCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.clcCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> volumeLocationsRefs<T extends Object>(
    Expression<T> Function($$VolumeLocationsTableAnnotationComposer a) f,
  ) {
    final $$VolumeLocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.volumeLocations,
      getReferencedColumn: (t) => t.volumeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumeLocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.volumeLocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> fragmentsRefs<T extends Object>(
    Expression<T> Function($$FragmentsTableAnnotationComposer a) f,
  ) {
    final $$FragmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fragments,
      getReferencedColumn: (t) => t.volumeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FragmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.fragments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> readingProgressRefs<T extends Object>(
    Expression<T> Function($$ReadingProgressTableAnnotationComposer a) f,
  ) {
    final $$ReadingProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingProgress,
      getReferencedColumn: (t) => t.volumeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.readingProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gemsRefs<T extends Object>(
    Expression<T> Function($$GemsTableAnnotationComposer a) f,
  ) {
    final $$GemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gems,
      getReferencedColumn: (t) => t.volumeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GemsTableAnnotationComposer(
            $db: $db,
            $table: $db.gems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VolumesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VolumesTable,
          Volume,
          $$VolumesTableFilterComposer,
          $$VolumesTableOrderingComposer,
          $$VolumesTableAnnotationComposer,
          $$VolumesTableCreateCompanionBuilder,
          $$VolumesTableUpdateCompanionBuilder,
          (Volume, $$VolumesTableReferences),
          Volume,
          PrefetchHooks Function({
            bool clcCode,
            bool volumeLocationsRefs,
            bool fragmentsRefs,
            bool readingProgressRefs,
            bool gemsRefs,
          })
        > {
  $$VolumesTableTableManager(_$AppDatabase db, $VolumesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VolumesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VolumesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VolumesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> fileHash = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> author = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                Value<String> clcCode = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<String?> coverPath = const Value.absent(),
                Value<DateTime> createTime = const Value.absent(),
              }) => VolumesCompanion(
                id: id,
                fileHash: fileHash,
                title: title,
                author: author,
                publisher: publisher,
                clcCode: clcCode,
                rating: rating,
                remarks: remarks,
                coverPath: coverPath,
                createTime: createTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String fileHash,
                required String title,
                Value<String?> author = const Value.absent(),
                Value<String?> publisher = const Value.absent(),
                required String clcCode,
                Value<int> rating = const Value.absent(),
                Value<String?> remarks = const Value.absent(),
                Value<String?> coverPath = const Value.absent(),
                Value<DateTime> createTime = const Value.absent(),
              }) => VolumesCompanion.insert(
                id: id,
                fileHash: fileHash,
                title: title,
                author: author,
                publisher: publisher,
                clcCode: clcCode,
                rating: rating,
                remarks: remarks,
                coverPath: coverPath,
                createTime: createTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VolumesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clcCode = false,
                volumeLocationsRefs = false,
                fragmentsRefs = false,
                readingProgressRefs = false,
                gemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (volumeLocationsRefs) db.volumeLocations,
                    if (fragmentsRefs) db.fragments,
                    if (readingProgressRefs) db.readingProgress,
                    if (gemsRefs) db.gems,
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
                        if (clcCode) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clcCode,
                                    referencedTable: $$VolumesTableReferences
                                        ._clcCodeTable(db),
                                    referencedColumn: $$VolumesTableReferences
                                        ._clcCodeTable(db)
                                        .code,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (volumeLocationsRefs)
                        await $_getPrefetchedData<
                          Volume,
                          $VolumesTable,
                          VolumeLocation
                        >(
                          currentTable: table,
                          referencedTable: $$VolumesTableReferences
                              ._volumeLocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VolumesTableReferences(
                                db,
                                table,
                                p0,
                              ).volumeLocationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.volumeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (fragmentsRefs)
                        await $_getPrefetchedData<
                          Volume,
                          $VolumesTable,
                          Fragment
                        >(
                          currentTable: table,
                          referencedTable: $$VolumesTableReferences
                              ._fragmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VolumesTableReferences(
                                db,
                                table,
                                p0,
                              ).fragmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.volumeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (readingProgressRefs)
                        await $_getPrefetchedData<
                          Volume,
                          $VolumesTable,
                          ReadingProgressData
                        >(
                          currentTable: table,
                          referencedTable: $$VolumesTableReferences
                              ._readingProgressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VolumesTableReferences(
                                db,
                                table,
                                p0,
                              ).readingProgressRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.volumeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (gemsRefs)
                        await $_getPrefetchedData<Volume, $VolumesTable, Gem>(
                          currentTable: table,
                          referencedTable: $$VolumesTableReferences
                              ._gemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VolumesTableReferences(db, table, p0).gemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.volumeId == item.id,
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

typedef $$VolumesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VolumesTable,
      Volume,
      $$VolumesTableFilterComposer,
      $$VolumesTableOrderingComposer,
      $$VolumesTableAnnotationComposer,
      $$VolumesTableCreateCompanionBuilder,
      $$VolumesTableUpdateCompanionBuilder,
      (Volume, $$VolumesTableReferences),
      Volume,
      PrefetchHooks Function({
        bool clcCode,
        bool volumeLocationsRefs,
        bool fragmentsRefs,
        bool readingProgressRefs,
        bool gemsRefs,
      })
    >;
typedef $$VolumeLocationsTableCreateCompanionBuilder =
    VolumeLocationsCompanion Function({
      Value<int> id,
      required int volumeId,
      Value<BookMediaType> mediaType,
      required String relativePath,
      Value<int?> fileSize,
    });
typedef $$VolumeLocationsTableUpdateCompanionBuilder =
    VolumeLocationsCompanion Function({
      Value<int> id,
      Value<int> volumeId,
      Value<BookMediaType> mediaType,
      Value<String> relativePath,
      Value<int?> fileSize,
    });

final class $$VolumeLocationsTableReferences
    extends
        BaseReferences<_$AppDatabase, $VolumeLocationsTable, VolumeLocation> {
  $$VolumeLocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VolumesTable _volumeIdTable(_$AppDatabase db) =>
      db.volumes.createAlias(
        $_aliasNameGenerator(db.volumeLocations.volumeId, db.volumes.id),
      );

  $$VolumesTableProcessedTableManager get volumeId {
    final $_column = $_itemColumn<int>('volume_id')!;

    final manager = $$VolumesTableTableManager(
      $_db,
      $_db.volumes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_volumeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VolumeLocationsTableFilterComposer
    extends Composer<_$AppDatabase, $VolumeLocationsTable> {
  $$VolumeLocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BookMediaType, BookMediaType, int>
  get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  $$VolumesTableFilterComposer get volumeId {
    final $$VolumesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableFilterComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VolumeLocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $VolumeLocationsTable> {
  $$VolumeLocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mediaType => $composableBuilder(
    column: $table.mediaType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  $$VolumesTableOrderingComposer get volumeId {
    final $$VolumesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableOrderingComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VolumeLocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VolumeLocationsTable> {
  $$VolumeLocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BookMediaType, int> get mediaType =>
      $composableBuilder(column: $table.mediaType, builder: (column) => column);

  GeneratedColumn<String> get relativePath => $composableBuilder(
    column: $table.relativePath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  $$VolumesTableAnnotationComposer get volumeId {
    final $$VolumesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableAnnotationComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VolumeLocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VolumeLocationsTable,
          VolumeLocation,
          $$VolumeLocationsTableFilterComposer,
          $$VolumeLocationsTableOrderingComposer,
          $$VolumeLocationsTableAnnotationComposer,
          $$VolumeLocationsTableCreateCompanionBuilder,
          $$VolumeLocationsTableUpdateCompanionBuilder,
          (VolumeLocation, $$VolumeLocationsTableReferences),
          VolumeLocation,
          PrefetchHooks Function({bool volumeId})
        > {
  $$VolumeLocationsTableTableManager(
    _$AppDatabase db,
    $VolumeLocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VolumeLocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VolumeLocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VolumeLocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> volumeId = const Value.absent(),
                Value<BookMediaType> mediaType = const Value.absent(),
                Value<String> relativePath = const Value.absent(),
                Value<int?> fileSize = const Value.absent(),
              }) => VolumeLocationsCompanion(
                id: id,
                volumeId: volumeId,
                mediaType: mediaType,
                relativePath: relativePath,
                fileSize: fileSize,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int volumeId,
                Value<BookMediaType> mediaType = const Value.absent(),
                required String relativePath,
                Value<int?> fileSize = const Value.absent(),
              }) => VolumeLocationsCompanion.insert(
                id: id,
                volumeId: volumeId,
                mediaType: mediaType,
                relativePath: relativePath,
                fileSize: fileSize,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VolumeLocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({volumeId = false}) {
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
                    if (volumeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.volumeId,
                                referencedTable:
                                    $$VolumeLocationsTableReferences
                                        ._volumeIdTable(db),
                                referencedColumn:
                                    $$VolumeLocationsTableReferences
                                        ._volumeIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $$VolumeLocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VolumeLocationsTable,
      VolumeLocation,
      $$VolumeLocationsTableFilterComposer,
      $$VolumeLocationsTableOrderingComposer,
      $$VolumeLocationsTableAnnotationComposer,
      $$VolumeLocationsTableCreateCompanionBuilder,
      $$VolumeLocationsTableUpdateCompanionBuilder,
      (VolumeLocation, $$VolumeLocationsTableReferences),
      VolumeLocation,
      PrefetchHooks Function({bool volumeId})
    >;
typedef $$FragmentsTableCreateCompanionBuilder =
    FragmentsCompanion Function({
      Value<int> id,
      required int volumeId,
      required String title,
      required String postionAnchor,
      required int sortOrder,
    });
typedef $$FragmentsTableUpdateCompanionBuilder =
    FragmentsCompanion Function({
      Value<int> id,
      Value<int> volumeId,
      Value<String> title,
      Value<String> postionAnchor,
      Value<int> sortOrder,
    });

final class $$FragmentsTableReferences
    extends BaseReferences<_$AppDatabase, $FragmentsTable, Fragment> {
  $$FragmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VolumesTable _volumeIdTable(_$AppDatabase db) => db.volumes
      .createAlias($_aliasNameGenerator(db.fragments.volumeId, db.volumes.id));

  $$VolumesTableProcessedTableManager get volumeId {
    final $_column = $_itemColumn<int>('volume_id')!;

    final manager = $$VolumesTableTableManager(
      $_db,
      $_db.volumes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_volumeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FragmentsTableFilterComposer
    extends Composer<_$AppDatabase, $FragmentsTable> {
  $$FragmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postionAnchor => $composableBuilder(
    column: $table.postionAnchor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$VolumesTableFilterComposer get volumeId {
    final $$VolumesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableFilterComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FragmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $FragmentsTable> {
  $$FragmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postionAnchor => $composableBuilder(
    column: $table.postionAnchor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$VolumesTableOrderingComposer get volumeId {
    final $$VolumesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableOrderingComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FragmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FragmentsTable> {
  $$FragmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get postionAnchor => $composableBuilder(
    column: $table.postionAnchor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$VolumesTableAnnotationComposer get volumeId {
    final $$VolumesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableAnnotationComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FragmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FragmentsTable,
          Fragment,
          $$FragmentsTableFilterComposer,
          $$FragmentsTableOrderingComposer,
          $$FragmentsTableAnnotationComposer,
          $$FragmentsTableCreateCompanionBuilder,
          $$FragmentsTableUpdateCompanionBuilder,
          (Fragment, $$FragmentsTableReferences),
          Fragment,
          PrefetchHooks Function({bool volumeId})
        > {
  $$FragmentsTableTableManager(_$AppDatabase db, $FragmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FragmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FragmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FragmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> volumeId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> postionAnchor = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => FragmentsCompanion(
                id: id,
                volumeId: volumeId,
                title: title,
                postionAnchor: postionAnchor,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int volumeId,
                required String title,
                required String postionAnchor,
                required int sortOrder,
              }) => FragmentsCompanion.insert(
                id: id,
                volumeId: volumeId,
                title: title,
                postionAnchor: postionAnchor,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FragmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({volumeId = false}) {
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
                    if (volumeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.volumeId,
                                referencedTable: $$FragmentsTableReferences
                                    ._volumeIdTable(db),
                                referencedColumn: $$FragmentsTableReferences
                                    ._volumeIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$FragmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FragmentsTable,
      Fragment,
      $$FragmentsTableFilterComposer,
      $$FragmentsTableOrderingComposer,
      $$FragmentsTableAnnotationComposer,
      $$FragmentsTableCreateCompanionBuilder,
      $$FragmentsTableUpdateCompanionBuilder,
      (Fragment, $$FragmentsTableReferences),
      Fragment,
      PrefetchHooks Function({bool volumeId})
    >;
typedef $$ReadingProgressTableCreateCompanionBuilder =
    ReadingProgressCompanion Function({
      Value<int> volumeId,
      required String lastAnchor,
      Value<double> percentage,
      Value<DateTime> updateTime,
    });
typedef $$ReadingProgressTableUpdateCompanionBuilder =
    ReadingProgressCompanion Function({
      Value<int> volumeId,
      Value<String> lastAnchor,
      Value<double> percentage,
      Value<DateTime> updateTime,
    });

final class $$ReadingProgressTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ReadingProgressTable,
          ReadingProgressData
        > {
  $$ReadingProgressTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VolumesTable _volumeIdTable(_$AppDatabase db) =>
      db.volumes.createAlias(
        $_aliasNameGenerator(db.readingProgress.volumeId, db.volumes.id),
      );

  $$VolumesTableProcessedTableManager get volumeId {
    final $_column = $_itemColumn<int>('volume_id')!;

    final manager = $$VolumesTableTableManager(
      $_db,
      $_db.volumes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_volumeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReadingProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get lastAnchor => $composableBuilder(
    column: $table.lastAnchor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => ColumnFilters(column),
  );

  $$VolumesTableFilterComposer get volumeId {
    final $$VolumesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableFilterComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get lastAnchor => $composableBuilder(
    column: $table.lastAnchor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => ColumnOrderings(column),
  );

  $$VolumesTableOrderingComposer get volumeId {
    final $$VolumesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableOrderingComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get lastAnchor => $composableBuilder(
    column: $table.lastAnchor,
    builder: (column) => column,
  );

  GeneratedColumn<double> get percentage => $composableBuilder(
    column: $table.percentage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updateTime => $composableBuilder(
    column: $table.updateTime,
    builder: (column) => column,
  );

  $$VolumesTableAnnotationComposer get volumeId {
    final $$VolumesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableAnnotationComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingProgressTable,
          ReadingProgressData,
          $$ReadingProgressTableFilterComposer,
          $$ReadingProgressTableOrderingComposer,
          $$ReadingProgressTableAnnotationComposer,
          $$ReadingProgressTableCreateCompanionBuilder,
          $$ReadingProgressTableUpdateCompanionBuilder,
          (ReadingProgressData, $$ReadingProgressTableReferences),
          ReadingProgressData,
          PrefetchHooks Function({bool volumeId})
        > {
  $$ReadingProgressTableTableManager(
    _$AppDatabase db,
    $ReadingProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> volumeId = const Value.absent(),
                Value<String> lastAnchor = const Value.absent(),
                Value<double> percentage = const Value.absent(),
                Value<DateTime> updateTime = const Value.absent(),
              }) => ReadingProgressCompanion(
                volumeId: volumeId,
                lastAnchor: lastAnchor,
                percentage: percentage,
                updateTime: updateTime,
              ),
          createCompanionCallback:
              ({
                Value<int> volumeId = const Value.absent(),
                required String lastAnchor,
                Value<double> percentage = const Value.absent(),
                Value<DateTime> updateTime = const Value.absent(),
              }) => ReadingProgressCompanion.insert(
                volumeId: volumeId,
                lastAnchor: lastAnchor,
                percentage: percentage,
                updateTime: updateTime,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReadingProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({volumeId = false}) {
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
                    if (volumeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.volumeId,
                                referencedTable:
                                    $$ReadingProgressTableReferences
                                        ._volumeIdTable(db),
                                referencedColumn:
                                    $$ReadingProgressTableReferences
                                        ._volumeIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $$ReadingProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingProgressTable,
      ReadingProgressData,
      $$ReadingProgressTableFilterComposer,
      $$ReadingProgressTableOrderingComposer,
      $$ReadingProgressTableAnnotationComposer,
      $$ReadingProgressTableCreateCompanionBuilder,
      $$ReadingProgressTableUpdateCompanionBuilder,
      (ReadingProgressData, $$ReadingProgressTableReferences),
      ReadingProgressData,
      PrefetchHooks Function({bool volumeId})
    >;
typedef $$GemsTableCreateCompanionBuilder =
    GemsCompanion Function({
      Value<int> id,
      required int volumeId,
      required String content,
      required String anchor,
      Value<DateTime> createTime,
      Value<String?> chapterTitle,
    });
typedef $$GemsTableUpdateCompanionBuilder =
    GemsCompanion Function({
      Value<int> id,
      Value<int> volumeId,
      Value<String> content,
      Value<String> anchor,
      Value<DateTime> createTime,
      Value<String?> chapterTitle,
    });

final class $$GemsTableReferences
    extends BaseReferences<_$AppDatabase, $GemsTable, Gem> {
  $$GemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VolumesTable _volumeIdTable(_$AppDatabase db) => db.volumes
      .createAlias($_aliasNameGenerator(db.gems.volumeId, db.volumes.id));

  $$VolumesTableProcessedTableManager get volumeId {
    final $_column = $_itemColumn<int>('volume_id')!;

    final manager = $$VolumesTableTableManager(
      $_db,
      $_db.volumes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_volumeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GemsTableFilterComposer extends Composer<_$AppDatabase, $GemsTable> {
  $$GemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get anchor => $composableBuilder(
    column: $table.anchor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chapterTitle => $composableBuilder(
    column: $table.chapterTitle,
    builder: (column) => ColumnFilters(column),
  );

  $$VolumesTableFilterComposer get volumeId {
    final $$VolumesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableFilterComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GemsTableOrderingComposer extends Composer<_$AppDatabase, $GemsTable> {
  $$GemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get anchor => $composableBuilder(
    column: $table.anchor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chapterTitle => $composableBuilder(
    column: $table.chapterTitle,
    builder: (column) => ColumnOrderings(column),
  );

  $$VolumesTableOrderingComposer get volumeId {
    final $$VolumesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableOrderingComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GemsTable> {
  $$GemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get anchor =>
      $composableBuilder(column: $table.anchor, builder: (column) => column);

  GeneratedColumn<DateTime> get createTime => $composableBuilder(
    column: $table.createTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chapterTitle => $composableBuilder(
    column: $table.chapterTitle,
    builder: (column) => column,
  );

  $$VolumesTableAnnotationComposer get volumeId {
    final $$VolumesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.volumeId,
      referencedTable: $db.volumes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolumesTableAnnotationComposer(
            $db: $db,
            $table: $db.volumes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GemsTable,
          Gem,
          $$GemsTableFilterComposer,
          $$GemsTableOrderingComposer,
          $$GemsTableAnnotationComposer,
          $$GemsTableCreateCompanionBuilder,
          $$GemsTableUpdateCompanionBuilder,
          (Gem, $$GemsTableReferences),
          Gem,
          PrefetchHooks Function({bool volumeId})
        > {
  $$GemsTableTableManager(_$AppDatabase db, $GemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> volumeId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> anchor = const Value.absent(),
                Value<DateTime> createTime = const Value.absent(),
                Value<String?> chapterTitle = const Value.absent(),
              }) => GemsCompanion(
                id: id,
                volumeId: volumeId,
                content: content,
                anchor: anchor,
                createTime: createTime,
                chapterTitle: chapterTitle,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int volumeId,
                required String content,
                required String anchor,
                Value<DateTime> createTime = const Value.absent(),
                Value<String?> chapterTitle = const Value.absent(),
              }) => GemsCompanion.insert(
                id: id,
                volumeId: volumeId,
                content: content,
                anchor: anchor,
                createTime: createTime,
                chapterTitle: chapterTitle,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GemsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({volumeId = false}) {
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
                    if (volumeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.volumeId,
                                referencedTable: $$GemsTableReferences
                                    ._volumeIdTable(db),
                                referencedColumn: $$GemsTableReferences
                                    ._volumeIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$GemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GemsTable,
      Gem,
      $$GemsTableFilterComposer,
      $$GemsTableOrderingComposer,
      $$GemsTableAnnotationComposer,
      $$GemsTableCreateCompanionBuilder,
      $$GemsTableUpdateCompanionBuilder,
      (Gem, $$GemsTableReferences),
      Gem,
      PrefetchHooks Function({bool volumeId})
    >;
typedef $$WebDavConfigsTableCreateCompanionBuilder =
    WebDavConfigsCompanion Function({
      Value<int> id,
      Value<String> url,
      Value<String> username,
      Value<String> password,
      Value<String> rootPath,
      Value<bool> keepLatestOnly,
      Value<bool> autoCheckNew,
      Value<bool> isEnabled,
      Value<DateTime?> lastSyncTime,
    });
typedef $$WebDavConfigsTableUpdateCompanionBuilder =
    WebDavConfigsCompanion Function({
      Value<int> id,
      Value<String> url,
      Value<String> username,
      Value<String> password,
      Value<String> rootPath,
      Value<bool> keepLatestOnly,
      Value<bool> autoCheckNew,
      Value<bool> isEnabled,
      Value<DateTime?> lastSyncTime,
    });

class $$WebDavConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $WebDavConfigsTable> {
  $$WebDavConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rootPath => $composableBuilder(
    column: $table.rootPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get keepLatestOnly => $composableBuilder(
    column: $table.keepLatestOnly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoCheckNew => $composableBuilder(
    column: $table.autoCheckNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WebDavConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $WebDavConfigsTable> {
  $$WebDavConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rootPath => $composableBuilder(
    column: $table.rootPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get keepLatestOnly => $composableBuilder(
    column: $table.keepLatestOnly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoCheckNew => $composableBuilder(
    column: $table.autoCheckNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WebDavConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WebDavConfigsTable> {
  $$WebDavConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  GeneratedColumn<String> get rootPath =>
      $composableBuilder(column: $table.rootPath, builder: (column) => column);

  GeneratedColumn<bool> get keepLatestOnly => $composableBuilder(
    column: $table.keepLatestOnly,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoCheckNew => $composableBuilder(
    column: $table.autoCheckNew,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncTime => $composableBuilder(
    column: $table.lastSyncTime,
    builder: (column) => column,
  );
}

class $$WebDavConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WebDavConfigsTable,
          WebDavConfig,
          $$WebDavConfigsTableFilterComposer,
          $$WebDavConfigsTableOrderingComposer,
          $$WebDavConfigsTableAnnotationComposer,
          $$WebDavConfigsTableCreateCompanionBuilder,
          $$WebDavConfigsTableUpdateCompanionBuilder,
          (
            WebDavConfig,
            BaseReferences<_$AppDatabase, $WebDavConfigsTable, WebDavConfig>,
          ),
          WebDavConfig,
          PrefetchHooks Function()
        > {
  $$WebDavConfigsTableTableManager(_$AppDatabase db, $WebDavConfigsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WebDavConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WebDavConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WebDavConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> rootPath = const Value.absent(),
                Value<bool> keepLatestOnly = const Value.absent(),
                Value<bool> autoCheckNew = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DateTime?> lastSyncTime = const Value.absent(),
              }) => WebDavConfigsCompanion(
                id: id,
                url: url,
                username: username,
                password: password,
                rootPath: rootPath,
                keepLatestOnly: keepLatestOnly,
                autoCheckNew: autoCheckNew,
                isEnabled: isEnabled,
                lastSyncTime: lastSyncTime,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
                Value<String> rootPath = const Value.absent(),
                Value<bool> keepLatestOnly = const Value.absent(),
                Value<bool> autoCheckNew = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DateTime?> lastSyncTime = const Value.absent(),
              }) => WebDavConfigsCompanion.insert(
                id: id,
                url: url,
                username: username,
                password: password,
                rootPath: rootPath,
                keepLatestOnly: keepLatestOnly,
                autoCheckNew: autoCheckNew,
                isEnabled: isEnabled,
                lastSyncTime: lastSyncTime,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WebDavConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WebDavConfigsTable,
      WebDavConfig,
      $$WebDavConfigsTableFilterComposer,
      $$WebDavConfigsTableOrderingComposer,
      $$WebDavConfigsTableAnnotationComposer,
      $$WebDavConfigsTableCreateCompanionBuilder,
      $$WebDavConfigsTableUpdateCompanionBuilder,
      (
        WebDavConfig,
        BaseReferences<_$AppDatabase, $WebDavConfigsTable, WebDavConfig>,
      ),
      WebDavConfig,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PreferencesTableTableTableManager get preferencesTable =>
      $$PreferencesTableTableTableManager(_db, _db.preferencesTable);
  $$ClcCategoriesTableTableManager get clcCategories =>
      $$ClcCategoriesTableTableManager(_db, _db.clcCategories);
  $$VolumesTableTableManager get volumes =>
      $$VolumesTableTableManager(_db, _db.volumes);
  $$VolumeLocationsTableTableManager get volumeLocations =>
      $$VolumeLocationsTableTableManager(_db, _db.volumeLocations);
  $$FragmentsTableTableManager get fragments =>
      $$FragmentsTableTableManager(_db, _db.fragments);
  $$ReadingProgressTableTableManager get readingProgress =>
      $$ReadingProgressTableTableManager(_db, _db.readingProgress);
  $$GemsTableTableManager get gems => $$GemsTableTableManager(_db, _db.gems);
  $$WebDavConfigsTableTableManager get webDavConfigs =>
      $$WebDavConfigsTableTableManager(_db, _db.webDavConfigs);
}
