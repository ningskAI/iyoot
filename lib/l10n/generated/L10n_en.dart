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
  String get webDavServerAddress => 'WebDav Server Address';

  @override
  String get webDavServerAddressHint => 'Enter your server address';

  @override
  String get webDavAccount => 'WebDav Account';

  @override
  String get webDavAccountHint => 'Enter your WebDav account';

  @override
  String get webDavPassword => 'WebDav Password';

  @override
  String get webDavPasswordHint => 'Enter your WebDav authorization password';

  @override
  String get webDavSubFolder => 'Sub-folder';

  @override
  String get webDavDeviceName => 'Device Name';

  @override
  String get syncReadingProgress => 'Sync Reading Progress';

  @override
  String get syncReadingProgressSummary =>
      'Sync reading progress when entering or exiting the reading interface';

  @override
  String get syncEnhancement => 'Sync Enhancement';

  @override
  String get syncEnhancementSummary =>
      'Sync cloud progress when re-entering the page (screen off, returning from background, etc.) or when the network becomes available. Syncing progress will ask.';

  @override
  String get backupPath => 'Backup Path';

  @override
  String get backup => 'Backup';

  @override
  String get backupSummary => 'Backup locally and to WebDav together';

  @override
  String get restore => 'Restore';

  @override
  String get restoreSummary =>
      'Priority to restore from WebDav, long press to restore from local';

  @override
  String get restoreIgnoreList => 'Restore Ignore List';

  @override
  String get restoreIgnoreListSummary =>
      'Ignore some content during restoration to facilitate different configurations for different phones';

  @override
  String get importOldData => 'Import Old Data';

  @override
  String get importOldDataSummary => 'Select the folder for old backup files';

  @override
  String get keepLatestBackupOnly => 'Keep Latest Backup Only';

  @override
  String get keepLatestBackupOnlySummary =>
      'Keep only the latest local backup file';

  @override
  String get autoCheckNewBackup => 'Auto Check for New Backup';

  @override
  String get autoCheckNewBackupSummary =>
      'Check for new backups when opening the software, and prompt whether to update if there is a new backup';
}
