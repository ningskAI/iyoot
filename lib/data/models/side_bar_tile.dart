import 'package:flutter/material.dart';
import 'package:i_reader/core/constants/next_icons.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SideBarTile {
  final IconData icon;
  final IconData selectedIcon;
  final String title;
  final int id;
  final String pathPrefix;

  SideBarTile({
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.id,
    required this.pathPrefix,
  });
}

List<SideBarTile> getNavbarTileList(BuildContext context) => [
  SideBarTile(
    id: 0,
    pathPrefix: "/home",
    icon: NextIcons.home,
    selectedIcon: NextIcons.homeSelected,
    title: L10n.of(context).navbarRead,
  ),
  SideBarTile(
    id: 1,
    pathPrefix: "/bookshelf",
    icon: NextIcons.bookshelf,
    selectedIcon: NextIcons.bookshelfSelected,
    title: L10n.of(context).navBarBookshelf,
  ),
  SideBarTile(
    id: 4,
    pathPrefix: "/note",
    icon: NextIcons.note,
    selectedIcon: NextIcons.noteSelected,
    title: L10n.of(context).navBarNote,
  ),
  SideBarTile(
    id: 5,
    pathPrefix: "/mine",
    icon: NextIcons.mine,
    selectedIcon: NextIcons.mineSelected,
    title: L10n.of(context).navMine,
  ),
];
