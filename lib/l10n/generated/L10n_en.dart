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
  String get navBarNote => 'Note';

  @override
  String get navMine => 'Mine';

  @override
  String get navBarSettings => 'Setting';
}
