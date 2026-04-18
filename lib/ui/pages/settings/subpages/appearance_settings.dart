import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/config/app_theme.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/ui/widgets/settings/select_dialog.dart';
import 'package:i_reader/ui/widgets/view_safe_area.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final padding = MediaQuery.viewPaddingOf(context);
    final themeMode = ref.watch(themeModeProvider);
    var themeType = "";
    switch (themeMode) {
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
              onTap: () => _showThemeModeDialog(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeModeDialog(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.read(themeModeProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('选择主题模式'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('浅色'),
              value: ThemeMode.light,
              groupValue: currentThemeMode,
              onChanged: (value) {
                if (value != null) {
                  setThemeMode(ref, value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('深色'),
              value: ThemeMode.dark,
              groupValue: currentThemeMode,
              onChanged: (value) {
                if (value != null) {
                  setThemeMode(ref, value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('跟随系统'),
              value: ThemeMode.system,
              groupValue: currentThemeMode,
              onChanged: (value) {
                if (value != null) {
                  setThemeMode(ref, value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
