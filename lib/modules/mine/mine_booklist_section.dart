import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/collections/app_style.dart';
import 'package:iyoot/modules/mine/mine_read_section_item.dart';
import 'package:iyoot/widgets/card.dart';

class MineBooklistSection extends HookConsumerWidget{
  const MineBooklistSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 20
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/icon_me_booklist.png", width: 24, height: 24,),
            const SizedBox(width: 12,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "书单",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12,),
                  Text(
                    "1个",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}


