import 'package:flutter/material.dart';
import 'package:i_reader/config/app_theme.dart';
import 'package:i_reader/ui/widgets/card.dart';

class MineReadSectionItem extends StatelessWidget {
  final String title; // 如：在读
  final String subTitle; // 如：累计26本
  final String iconPath; // 图标

  const MineReadSectionItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.iconPath,
  }); // 再度

  @override
  Widget build(BuildContext context) {
    return CardView(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(subTitle, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
