import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/models/setting_type_tiles.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/ui/widgets/d_list_tile.dart';
import 'package:i_reader/ui/widgets/view_safe_area.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(L10n.of(context).navBarSettings)),
      body: ViewSafeArea(child: buildList(context, theme)),
    );
  }

  void toPage(BuildContext context, String? route) {
    if (route == null) return;
    context.pushNamed(route);
  }

  Widget buildList(BuildContext context, ThemeData theme) {
    final padding = MediaQuery.viewPaddingOf(context);
    final items = getSettingTiles(context);
    return ListView(
      padding: EdgeInsets.only(bottom: padding.bottom + 100),
      children: items
          .take(items.length)
          .map(
            (item) => DListTile(
              onTap: () => toPage(context, item.route),
              icon: item.icon,
              iconColor: item.iconColor,
              title: item.title,
              subtitle: item.subtitle,
              trailing: item.trailing,
            ),
          )
          .toList(),
    );
  }
}
