import 'package:go_router/go_router.dart';
import 'package:i_reader/main.dart';
import 'package:i_reader/ui/pages/about/about_page.dart';
import 'package:i_reader/ui/pages/bookshelf/bookshelf_page.dart';
import 'package:i_reader/ui/pages/home/home.dart';
import 'package:i_reader/ui/pages/mine/mine_page.dart';
import 'package:i_reader/ui/pages/note/note.dart';
import 'package:i_reader/ui/pages/root/root.dart';
import 'package:i_reader/ui/pages/settings/settings_page.dart';
import 'package:i_reader/ui/pages/settings/subpages/appearance_settings.dart';
import 'package:i_reader/ui/pages/statistics/statistics.dart';
import 'package:i_reader/ui/pages/store/store.dart';

final router = GoRouter(
  initialLocation: "/home",
  navigatorKey: navigatorKey,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return RootPage(child: child);
      },
      routes: [
        GoRoute(path: "/home", builder: (_, _) => HomePage()),
        GoRoute(path: "/bookshelf", builder: (_, _) => BookshelfPage()),
        GoRoute(path: "/store", builder: (_, _) => StorePage()),
        GoRoute(path: "/statistics", builder: (_, _) => StatisticsPage()),
        GoRoute(path: "/note", builder: (_, _) => NotePage()),
        GoRoute(path: "/mine", builder: (_, _) => MinePage()),
      ],
    ),
    GoRoute(path: "/settings", builder: (_, _) => SettingsPage()),
    GoRoute(
      name: "appearance",
      path: "/settings/appearance",
      builder: (_, _) => AppearanceSettingsPage(),
    ),
    GoRoute(
      name: "about",
      path: "/settings/about",
      builder: (_, _) => AboutPage(),
    ),
  ],
);
