// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'L10n.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class L10nZh extends L10n {
  L10nZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '阅然';

  @override
  String get navbarRead => '阅读';

  @override
  String get navBarBookshelf => '书架';

  @override
  String get navBarLibrary => '藏书';

  @override
  String get navBarStatistics => '分析';

  @override
  String get navBarNote => '笔记';

  @override
  String get navMine => '我的';
}
