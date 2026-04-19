import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/config/app_theme.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';
import 'package:i_reader/ui/widgets/td/td_appbar.dart';
import 'package:i_reader/ui/widgets/td/td_list_tile.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    return HomePageBackground(
      glowColors: const [Color(0xFF4F7CFF), Color(0xFF7C5CFF)],
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              TDAppbar(title: L10n.of(context).settingsAppearance),
              Expanded(
                child: Column(
                  children: [
                    TDListTile(
                      icon: Icons.flashlight_on_outlined,
                      iconColor: const Color(0xFF8B5CF6),
                      title: "主题模式",
                      subtitle: "当前模式: $themeType",
                      onTap: () => _showThemeModeDialog(context, ref),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
