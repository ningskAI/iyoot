import 'package:auto_route/auto_route.dart';
import 'package:iyoot/collections/next_icons.dart';
import 'package:iyoot/routes/routes.gr.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SideBarTiles {
  final IconData icon;
  final IconData selectedIcon;
  final String title;
  final String id;
  final String pathPrefix;
  final PageRouteInfo route;

  SideBarTiles({
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.id,
    required this.route,
    required this.pathPrefix
  });
}

List<SideBarTiles> getNavbarTileList() => [
  SideBarTiles(
      id: "home",
      pathPrefix: "/home",
      route: const HomeRoute(),
      icon: NextIcons.home,
      selectedIcon: NextIcons.homeSelected,
      title: "阅读"
  ),
  SideBarTiles(
      id: "bookshelf",
      pathPrefix: "/bookshelf",
      route: const BookshelfRoute(),
      icon: NextIcons.bookshelf,
      selectedIcon: NextIcons.bookshelfSelected,
      title: "书架"
  ),
  SideBarTiles(
      id: "statistics",
      pathPrefix: "/statistics",
      route: const StatisticsRoute(),
      icon: NextIcons.statistics,
      selectedIcon: NextIcons.statisticsSelected,
      title: "分析"
  ),
  SideBarTiles(
      id: "mine",
      pathPrefix: "/mine",
      route: const MineRoute(),
      icon: NextIcons.mine,
      selectedIcon: NextIcons.mineSelected,
      title: "我的"
  )
];

List<SideBarTiles> getSideBarTileList() => [
  SideBarTiles(
      id: "home",
      pathPrefix: "/home",
      route: const HomeRoute(),
      icon: NextIcons.home,
      selectedIcon: NextIcons.homeSelected,
      title: "阅读"
  ),
  SideBarTiles(
      id: "bookshelf",
      pathPrefix: "/bookshelf",
      route: const BookshelfRoute(),
      icon: NextIcons.bookshelf,
      selectedIcon: NextIcons.bookshelfSelected,
      title: "书架"
  ),
  SideBarTiles(
      id: "statistics",
      pathPrefix: "/statistics",
      route: const StatisticsRoute(),
      icon: NextIcons.statistics,
      selectedIcon: NextIcons.statisticsSelected,
      title: "分析"
  ),
  SideBarTiles(
      id: "mine",
      pathPrefix: "/mine",
      route: const MineRoute(),
      icon: NextIcons.mine,
      selectedIcon: NextIcons.mineSelected,
      title: "我的"
  )
];