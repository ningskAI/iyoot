// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:iyoot/pages/home/home.dart' as _i1;
import 'package:iyoot/pages/live/live.dart' as _i2;
import 'package:iyoot/pages/mine/mine.dart' as _i3;
import 'package:iyoot/pages/music/music.dart' as _i4;
import 'package:iyoot/pages/root/root.dart' as _i5;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.LivePage]
class LiveRoute extends _i6.PageRouteInfo<void> {
  const LiveRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LiveRoute.name,
          initialChildren: children,
        );

  static const String name = 'LiveRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.LivePage();
    },
  );
}

/// generated route for
/// [_i3.MinePage]
class MineRoute extends _i6.PageRouteInfo<void> {
  const MineRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MineRoute.name,
          initialChildren: children,
        );

  static const String name = 'MineRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.MinePage();
    },
  );
}

/// generated route for
/// [_i4.MusicPage]
class MusicRoute extends _i6.PageRouteInfo<void> {
  const MusicRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MusicRoute.name,
          initialChildren: children,
        );

  static const String name = 'MusicRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.MusicPage();
    },
  );
}

/// generated route for
/// [_i5.RootPage]
class RootRoute extends _i6.PageRouteInfo<void> {
  const RootRoute({List<_i6.PageRouteInfo>? children})
      : super(
          RootRoute.name,
          initialChildren: children,
        );

  static const String name = 'RootRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.RootPage();
    },
  );
}
