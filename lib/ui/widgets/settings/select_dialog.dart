import 'package:flutter/material.dart';

class SelectDialog<T> extends StatelessWidget {
  const SelectDialog({
    super.key,
    this.value,
    required this.values,
    required this.title,
    this.subtitleBuilder,
    this.toggleable = false,
    this.itemBuilder,
  });

  final T? value;
  final List<T> values;
  final String title;
  final Widget Function(T)? subtitleBuilder;
  final bool toggleable;
  final Widget Function(T, bool)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    final titleMedium = TextTheme.of(context).titleMedium!;
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      title: Text(title, style: titleMedium),
      constraints: subtitleBuilder != null
          ? const BoxConstraints(maxWidth: 320, minWidth: 320)
          : null,
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      content: Material(
        type: MaterialType.transparency,
        child: SingleChildScrollView(
          child: RadioGroup<T>(
            value: value,
            values: values,
            toggleable: toggleable,
            subtitleBuilder: subtitleBuilder,
            itemBuilder: itemBuilder,
            onChanged: (v) => Navigator.of(context).pop(v ?? value),
          ),
        ),
      ),
    );
  }
}

class RadioGroup<T> extends StatelessWidget {
  const RadioGroup({
    super.key,
    required this.value,
    required this.values,
    required this.onChanged,
    this.subtitleBuilder,
    this.toggleable = false,
    this.itemBuilder,
  });

  final T? value;
  final List<T> values;
  final ValueChanged<T?> onChanged;
  final Widget Function(T)? subtitleBuilder;
  final bool toggleable;
  final Widget Function(T, bool)? itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: values.map((item) {
        final selected = value == item;
        if (itemBuilder != null) {
          return InkWell(
            onTap: () => onChanged(toggleable && selected ? null : item),
            child: itemBuilder!(item, selected),
          );
        }
        return RadioListTile<T>(
          value: item,
          groupValue: value,
          onChanged: onChanged,
          toggleable: toggleable,
          title: Text(item.toString()),
          subtitle: subtitleBuilder?.call(item),
        );
      }).toList(),
    );
  }
}