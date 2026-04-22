import 'package:flutter/material.dart';
import 'diagram.dart';
import 'package:i_reader/ui/widgets/td/td_dropdown_button.dart';

class PageTurnDropdown extends StatelessWidget {
  const PageTurnDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final PageTurningType value;
  final ValueChanged<PageTurningType?> onChanged;

  String _getLabel(BuildContext context, PageTurningType type) {
    switch (type) {
      case PageTurningType.none:
        return "无操作";
      case PageTurningType.prev:
        return "上一页";
      case PageTurningType.next:
        return "下一页";
      case PageTurningType.menu:
        return "菜单";
    }
  }

  @override
  Widget build(BuildContext context) {
    return TDDropdownButton<PageTurningType>(
      value: value,
      items: PageTurningType.values
          .map(
            (type) => DropdownItem<PageTurningType>(
              value: type,
              label: _getLabel(context, type),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
