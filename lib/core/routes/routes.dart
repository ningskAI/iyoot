import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/main.dart';
import 'package:i_reader/ui/pages/about/about_page.dart';
import 'package:i_reader/ui/pages/bookshelf/bookshelf_page.dart';
import 'package:i_reader/ui/pages/home/home_page.dart';
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
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return RootPage(child: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(),
          routes: [
            GoRoute(
              path: "/home",
              pageBuilder: (_, __) => NoTransitionPage(child: HomePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(),
          routes: [
            GoRoute(
              path: "/bookshelf",
              pageBuilder: (_, __) => NoTransitionPage(child: BookshelfPage()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(),
          routes: [
            GoRoute(
              path: "/store",
              pageBuilder: (_, __) => NoTransitionPage(child: StorePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(),
          routes: [
            GoRoute(
              path: "/statistics",
              pageBuilder: (_, __) => NoTransitionPage(child: StatisticsPage()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(),
          routes: [
            GoRoute(
              path: "/note",
              pageBuilder: (_, __) => NoTransitionPage(child: NotePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(),
          routes: [
            GoRoute(
              path: "/mine",
              pageBuilder: (_, __) => NoTransitionPage(child: MinePage()),
            ),
          ],
        ),
      ],
    ),
    GoRoute(path: "/settings", builder: (_, __) => SettingsPage()),
    GoRoute(
      name: "appearance",
      path: "/settings/appearance",
      builder: (_, __) => AppearanceSettingsPage(),
    ),
    GoRoute(
      name: "about",
      path: "/settings/about",
      builder: (_, __) => AboutPage(),
    ),
  ],
);
