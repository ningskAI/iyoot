import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/collections/setting_type_tiles.dart';
import 'package:iyoot/l10n/generated/L10n.dart';
import 'package:iyoot/widgets/view_safe_area.dart';
class SettingsPage extends HookConsumerWidget{

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(L10n.of(context).navBarSettings),
      ),
      body: ViewSafeArea(
        child: buildList(context, theme),
      ),
    );
  }

  void toPage(SettingType type) {

  }

  Widget buildList(BuildContext context,ThemeData theme) {
    final padding = MediaQuery.viewPaddingOf(context);
    TextStyle titleStyle = theme.textTheme.titleMedium!;
    TextStyle subTitleStyle = theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.outline,
    );
    final items = getSettingTiles();
    return ListView(
      padding: EdgeInsets.only(bottom: padding.bottom + 100),
      children: items
          .take(items.length)
          .map((item) => ListTile(
            onTap: () => toPage(item.type) ,
            leading: item.icon,
            title: Text(item.type.title, style: titleStyle),
            subtitle: item.subtitle == null
                ? null
                : Text(item.subtitle!, style: subTitleStyle),
          ))
        .toList()
    );
  }

}