import 'package:auto_route/auto_route.dart';
import 'package:iyoot/collections/next_icons.dart';
import 'package:iyoot/l10n/generated/L10n.dart';
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

List<SideBarTiles> getNavbarTileList(BuildContext context) => [
  SideBarTiles(
      id: "home",
      pathPrefix: "/home",
      route: const HomeRoute(),
      icon: NextIcons.home,
      selectedIcon: NextIcons.homeSelected,
      title: L10n.of(context).navbarRead)
  ,
  SideBarTiles(
      id: "bookshelf",
      pathPrefix: "/bookshelf",
      route: const BookshelfRoute(),
      icon: NextIcons.bookshelf,
      selectedIcon: NextIcons.bookshelfSelected,
      title: L10n.of(context).navBarBookshelf
  ),
  SideBarTiles(
      id: "store",
      pathPrefix: "/store",
      route: const StoreRoute(),
      icon: NextIcons.store,
      selectedIcon: NextIcons.storeSelected,
      title: L10n.of(context).navBarLibrary
  ),
  SideBarTiles(
      id: "statistics",
      pathPrefix: "/statistics",
      route: const StatisticsRoute(),
      icon: NextIcons.statistics,
      selectedIcon: NextIcons.statisticsSelected,
      title: L10n.of(context).navBarStatistics
  ),
  SideBarTiles(
      id: "note",
      pathPrefix: "/note",
      route: const NoteRoute(),
      icon: NextIcons.note,
      selectedIcon: NextIcons.noteSelected,
      title: L10n.of(context).navBarNote
  ),
  SideBarTiles(
      id: "mine",
      pathPrefix: "/mine",
      route: const MineRoute(),
      icon: NextIcons.mine,
      selectedIcon: NextIcons.mineSelected,
      title: L10n.of(context).navMine
  )
];