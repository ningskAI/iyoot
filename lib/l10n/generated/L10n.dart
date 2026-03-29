import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'L10n_en.dart' deferred as L10n_en;
import 'L10n_zh.dart' deferred as L10n_zh;

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/L10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'iYooT'**
  String get appName;

  /// No description provided for @navbarRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get navbarRead;

  /// No description provided for @navBarBookshelf.
  ///
  /// In en, this message translates to:
  /// **'Bookshelf'**
  String get navBarBookshelf;

  /// No description provided for @navBarLibrary.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get navBarLibrary;

  /// No description provided for @navBarStatistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get navBarStatistics;

  /// No description provided for @navBarNote.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get navBarNote;

  /// No description provided for @navMine.
  ///
  /// In en, this message translates to:
  /// **'Mine'**
  String get navMine;

  /// No description provided for @navBarSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navBarSettings;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance Settings'**
  String get settingsAppearance;

  /// No description provided for @settingsRead.
  ///
  /// In en, this message translates to:
  /// **'Read Settings'**
  String get settingsRead;

  /// No description provided for @settingsSync.
  ///
  /// In en, this message translates to:
  /// **'Sync Settings'**
  String get settingsSync;

  /// No description provided for @settingsInterface.
  ///
  /// In en, this message translates to:
  /// **'Interface Settings'**
  String get settingsInterface;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get settingsTheme;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @settingsLightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get settingsLightMode;

  /// No description provided for @settingsSystemMode.
  ///
  /// In en, this message translates to:
  /// **'System Mode'**
  String get settingsSystemMode;

  /// No description provided for @settingBackup.
  ///
  /// In en, this message translates to:
  /// **'Backup and Restore'**
  String get settingBackup;

  /// No description provided for @webDavSettings.
  ///
  /// In en, this message translates to:
  /// **'WebDav Settings'**
  String get webDavSettings;

  /// No description provided for @webDavServerAddress.
  ///
  /// In en, this message translates to:
  /// **'WebDav Server Address'**
  String get webDavServerAddress;

  /// No description provided for @webDavServerAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your server address'**
  String get webDavServerAddressHint;

  /// No description provided for @webDavAccount.
  ///
  /// In en, this message translates to:
  /// **'WebDav Account'**
  String get webDavAccount;

  /// No description provided for @webDavAccountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your WebDav account'**
  String get webDavAccountHint;

  /// No description provided for @webDavPassword.
  ///
  /// In en, this message translates to:
  /// **'WebDav Password'**
  String get webDavPassword;

  /// No description provided for @webDavPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your WebDav authorization password'**
  String get webDavPasswordHint;

  /// No description provided for @webDavSubFolder.
  ///
  /// In en, this message translates to:
  /// **'Sub-folder'**
  String get webDavSubFolder;

  /// No description provided for @webDavDeviceName.
  ///
  /// In en, this message translates to:
  /// **'Device Name'**
  String get webDavDeviceName;

  /// No description provided for @syncReadingProgress.
  ///
  /// In en, this message translates to:
  /// **'Sync Reading Progress'**
  String get syncReadingProgress;

  /// No description provided for @syncReadingProgressSummary.
  ///
  /// In en, this message translates to:
  /// **'Sync reading progress when entering or exiting the reading interface'**
  String get syncReadingProgressSummary;

  /// No description provided for @syncEnhancement.
  ///
  /// In en, this message translates to:
  /// **'Sync Enhancement'**
  String get syncEnhancement;

  /// No description provided for @syncEnhancementSummary.
  ///
  /// In en, this message translates to:
  /// **'Sync cloud progress when re-entering the page (screen off, returning from background, etc.) or when the network becomes available. Syncing progress will ask.'**
  String get syncEnhancementSummary;

  /// No description provided for @backupPath.
  ///
  /// In en, this message translates to:
  /// **'Backup Path'**
  String get backupPath;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @backupSummary.
  ///
  /// In en, this message translates to:
  /// **'Backup locally and to WebDav together'**
  String get backupSummary;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @restoreSummary.
  ///
  /// In en, this message translates to:
  /// **'Priority to restore from WebDav, long press to restore from local'**
  String get restoreSummary;

  /// No description provided for @restoreIgnoreList.
  ///
  /// In en, this message translates to:
  /// **'Restore Ignore List'**
  String get restoreIgnoreList;

  /// No description provided for @restoreIgnoreListSummary.
  ///
  /// In en, this message translates to:
  /// **'Ignore some content during restoration to facilitate different configurations for different phones'**
  String get restoreIgnoreListSummary;

  /// No description provided for @importOldData.
  ///
  /// In en, this message translates to:
  /// **'Import Old Data'**
  String get importOldData;

  /// No description provided for @importOldDataSummary.
  ///
  /// In en, this message translates to:
  /// **'Select the folder for old backup files'**
  String get importOldDataSummary;

  /// No description provided for @keepLatestBackupOnly.
  ///
  /// In en, this message translates to:
  /// **'Keep Latest Backup Only'**
  String get keepLatestBackupOnly;

  /// No description provided for @keepLatestBackupOnlySummary.
  ///
  /// In en, this message translates to:
  /// **'Keep only the latest local backup file'**
  String get keepLatestBackupOnlySummary;

  /// No description provided for @autoCheckNewBackup.
  ///
  /// In en, this message translates to:
  /// **'Auto Check for New Backup'**
  String get autoCheckNewBackup;

  /// No description provided for @autoCheckNewBackupSummary.
  ///
  /// In en, this message translates to:
  /// **'Check for new backups when opening the software, and prompt whether to update if there is a new backup'**
  String get autoCheckNewBackupSummary;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return lookupL10n(locale);
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

Future<L10n> lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10n_en.loadLibrary().then((dynamic _) => L10n_en.L10nEn());
    case 'zh':
      return L10n_zh.loadLibrary().then((dynamic _) => L10n_zh.L10nZh());
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
