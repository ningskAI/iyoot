import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart' as material;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/app/log.dart';
import 'package:iyoot/app/utils.dart';
import 'package:iyoot/common/core_log.dart';
import 'package:iyoot/extensions/theme.dart';
import 'package:iyoot/models/common/theme/theme_color_type.dart';
import 'package:iyoot/models/database/database.dart';
import 'package:iyoot/pages/other/debug_log_page.dart';
import 'package:iyoot/provider/database/database.dart';
import 'package:iyoot/provider/user_preferences/user_preferences_provider.dart';
import 'package:iyoot/routes/routes.dart';
import 'package:iyoot/services/logger/logger.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWith((ref) => database),
      ],
      observers: const [
        AppLoggerProviderObserver(),
      ],
      child: IYoot(),
    ),
  );
}


class IYoot extends HookConsumerWidget {

  const IYoot({super.key});


  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(userPreferencesProvider.select((s) => s.themeMode));
    final router = useMemoized(() => AppRouter(ref), []);
    return ShadcnApp.router(
      routerConfig: router.config(),
      debugShowCheckedModeBanner: false,
      title: 'iYooT',
      builder: (context, child) {
        child = ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.invertedStylus,
            }
          ),
          child: child!,
        );

        return child;
      },
      theme: ThemeData(
        radius: .5,
        iconTheme: const IconThemeProperties(),
        surfaceOpacity: .8,
        surfaceBlur: 10,
      ),
      themeMode: themeMode,
    );

  }

}
