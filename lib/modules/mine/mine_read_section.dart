import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iyoot/modules/mine/mine_read_section_item.dart';

class MineReadSection extends ConsumerWidget{
  const MineReadSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: MineReadSectionItem(
                  title: "在读",
                  subTitle: "累计26本",
                  iconPath: "assets/images/icon_me_copyright.png",
                ),
              ),
              SizedBox(width: 12,),
              Expanded(
                flex: 1,
                child: MineReadSectionItem(
                  title: "读完",
                  subTitle: "累计26本",
                  iconPath: "assets/images/icon_me_finishread.png",
                ),
              )
            ],
          ),
          SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: MineReadSectionItem(
                  title: "笔记",
                  subTitle: "累计7本",
                  iconPath: "assets/images/icon_me_note.png",
                ),
              ),
              SizedBox(width: 12,),
              Expanded(
                flex: 1,
                child: MineReadSectionItem(
                  title: "浏览记录",
                  subTitle: "尚未开发",
                  iconPath: "assets/images/icon_me_history.png",
                ),
              )
            ],
          )
        ]
    );
  }

}


