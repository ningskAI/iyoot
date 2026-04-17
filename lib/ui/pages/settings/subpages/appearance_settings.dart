import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/provider/user_preferences_provider.dart';
import 'package:i_reader/ui/widgets/settings/select_dialog.dart';
import 'package:i_reader/widgets/view_safe_area.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = MediaQuery.viewPaddingOf(context);
    final preferences = ref.watch(userPreferencesProvider);
    final preferencesNotifier = ref.watch(userPreferencesProvider.notifier);
    var themeType = "";
    switch (preferences.themeMode) {
      case ThemeMode.system:
        themeType = L10n.of(context).settingsSystemMode;
        break;
      case ThemeMode.dark:
        themeType = L10n.of(context).settingsDarkMode;
      case ThemeMode.light:
        themeType = L10n.of(context).settingsLightMode;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(L10n.of(context).settingsAppearance)),
      body: ViewSafeArea(
        child: ListView(
          padding: EdgeInsets.only(bottom: padding.bottom + 100),
          children: [
            ListTile(
              leading: const Icon(Icons.flashlight_on_outlined),
              title: Text("主题模式"),
              subtitle: Text("当前模式: $themeType"),
              onTap: () =>
                  showThemeTypeDialog(context, ref, preferences.themeMode),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showThemeTypeDialog(
    BuildContext context,
    WidgetRef ref,
    ThemeMode themeMode,
  ) async {
    final loc = L10n.of(context);
    final themeOptions = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];
    await showDialog<ThemeMode>(
      context: context,
      builder: (context) => SelectDialog<ThemeMode>(
        title: loc.settingsTheme,
        value: themeMode,
        values: themeOptions.toList(),
        subtitleBuilder: (mode) {
          switch (mode) {
            case ThemeMode.light:
              return Text(loc.settingsLightMode);
            case ThemeMode.dark:
              return Text(loc.settingsDarkMode);
            case ThemeMode.system:
              return Text(loc.settingsSystemMode);
          }
        },
      ),
    ).then((selectMode) {
      if (selectMode != null) {
        ref.read(userPreferencesProvider.notifier).setThemeMode(selectMode);
      }
    });
  }
}
