import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  final Widget child;
  const CardView({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey.withAlpha(50)
          : Colors.white60,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: child,
      ),
    );
  }
}
