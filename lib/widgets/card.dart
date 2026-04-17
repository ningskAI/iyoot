import 'package:flutter/material.dart';
import 'package:i_reader/collections/app_style.dart';

class CardView extends StatelessWidget {
  final Widget child;
  const CardView({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.withAlpha(50)
          : Colors.white70,
      shape: RoundedRectangleBorder(borderRadius: AppStyle.radius12),
      child: Container(
        decoration: BoxDecoration(borderRadius: AppStyle.radius12),
        child: child,
      ),
    );
  }
}
