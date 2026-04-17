import 'package:i_reader/core/constants/next_icons.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SideBarTiles {
  final IconData icon;
  final IconData selectedIcon;
  final String title;
  final int id;
  final String pathPrefix;

  SideBarTiles({
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.id,
    required this.pathPrefix,
  });
}

List<SideBarTiles> getNavbarTileList(BuildContext context) => [
  SideBarTiles(
    id: 0,
    pathPrefix: "/home",
    icon: NextIcons.home,
    selectedIcon: NextIcons.homeSelected,
    title: L10n.of(context).navbarRead,
  ),
  SideBarTiles(
    id: 1,
    pathPrefix: "/bookshelf",
    icon: NextIcons.bookshelf,
    selectedIcon: NextIcons.bookshelfSelected,
    title: L10n.of(context).navBarBookshelf,
  ),
  SideBarTiles(
    id: 4,
    pathPrefix: "/note",
    icon: NextIcons.note,
    selectedIcon: NextIcons.noteSelected,
    title: L10n.of(context).navBarNote,
  ),
  SideBarTiles(
    id: 5,
    pathPrefix: "/mine",
    icon: NextIcons.mine,
    selectedIcon: NextIcons.mineSelected,
    title: L10n.of(context).navMine,
  ),
];
