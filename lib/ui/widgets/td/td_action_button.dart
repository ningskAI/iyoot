import 'package:flutter/material.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';

/// 头部动作按钮
class TDActionButton extends StatelessWidget {
  const TDActionButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: HomePalette.mutedCard(context),
            shape: BoxShape.circle,
            border: Border.all(color: HomePalette.lineColor(context)),
          ),
          child: Icon(icon, size: 22, color: HomePalette.primaryText(context)),
        ),
      ),
    );
  }
}
