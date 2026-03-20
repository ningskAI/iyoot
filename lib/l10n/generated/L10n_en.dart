// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'L10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'iReader';

  @override
  String get navbarRead => 'Read';

  @override
  String get navBarBookshelf => 'BookShelf';

  @override
  String get navBarLibrary => 'BookStore';

  @override
  String get navBarStatistics => 'Statistics';

  @override
  String get navBarNote => 'Notes';

  @override
  String get navMine => 'Mine';

  @override
  String get navBarSettings => 'Setting';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsRead => 'Read';

  @override
  String get settingsSync => 'Sync';

  @override
  String get settingsInterface => 'Interface';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsDarkMode => 'Dark';

  @override
  String get settingsLightMode => 'Light';

  @override
  String get settingsSystemMode => 'System';
}
