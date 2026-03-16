import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/routes/routes.gr.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  final WidgetRef ref;

  AppRouter(this.ref) : super(navigatorKey: rootNavigatorKey);

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RootRoute.page,
      path: "/",
      initial: true,
      children: [
        AutoRoute(
          path: "home",
          page: HomeRoute.page,
          initial: true
        ),
        AutoRoute(
          path: "music",
          page: MusicRoute.page,
        ),
        AutoRoute(
          path: "live",
          page: LiveRoute.page
        ),
        AutoRoute(
          path: "mine",
          page: MineRoute.page
        )
      ]
    )
  ];

}