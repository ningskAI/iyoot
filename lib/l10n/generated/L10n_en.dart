// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'L10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'iYooT';

  @override
  String get navbarRead => 'Read';

  @override
  String get navBarBookshelf => 'Bookshelf';

  @override
  String get navBarLibrary => 'Library';

  @override
  String get navBarStatistics => 'Statistics';

  @override
  String get navBarNote => 'Notes';

  @override
  String get navMine => 'Mine';

  @override
  String get navBarSettings => 'Settings';

  @override
  String get settingsAppearance => 'Appearance Settings';

  @override
  String get settingsRead => 'Read Settings';

  @override
  String get settingsSync => 'Sync Settings';

  @override
  String get settingsInterface => 'Interface Settings';

  @override
  String get settingsTheme => 'Theme Mode';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get settingsLightMode => 'Light Mode';

  @override
  String get settingsSystemMode => 'System Mode';

  @override
  String get settingBackup => 'Backup and Restore';

  @override
  String get webDavSettings => 'WebDav Settings';

  @override
  String get webDavServerAddress => 'Address';

  @override
  String get webDavAccount => 'Account';

  @override
  String get webDavPassword => 'Password';

  @override
  String get webDavSubFolder => 'Path';

  @override
  String get saveConfig => 'Save Settings';

  @override
  String get testConnection => 'Test Connection';

  @override
  String get syncReadingProgress => 'Sync Reading Progress';

  @override
  String get syncReadingProgressSummary =>
      'Sync reading progress when entering/exiting reading interface';

  @override
  String get syncEnhancement => 'Enhanced Sync';

  @override
  String get syncEnhancementSummary =>
      'Sync cloud progress when re-entering or network available, will prompt for sync';

  @override
  String get backupPath => 'Backup Path';

  @override
  String get backup => 'Backup';

  @override
  String get backupSummary => 'Backup to Local and WebDav together';

  @override
  String get restore => 'Restore';

  @override
  String get restoreSummary => 'Priority from WebDav, long press for Local';

  @override
  String get restoreIgnoreList => 'Restore Ignore List';

  @override
  String get restoreIgnoreListSummary =>
      'Ignore certain items during restoration for different device configurations';

  @override
  String get importOldData => 'Import Old Data';

  @override
  String get importOldDataSummary =>
      'Select folder containing old backup files';

  @override
  String get keepLatestBackupOnly => 'Keep Latest Backup Only';

  @override
  String get keepLatestBackupOnlySummary =>
      'Only keep the most recent local backup file';

  @override
  String get autoCheckNewBackup => 'Auto Check for New Backup';

  @override
  String get autoCheckNewBackupSummary =>
      'Check for new backups on startup and prompt for update';
}
