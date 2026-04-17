import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/widgets/card.dart';

class MineReadRankSection extends ConsumerWidget {
  const MineReadRankSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/icon_me_time.png",
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "阅读时长",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: [
                      Text("144小时5分钟", style: const TextStyle(fontSize: 14)),
                      Divider(height: 8),
                      Text(
                        "本月少于1分钟",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
