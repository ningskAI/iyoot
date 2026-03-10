import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iyoot/app/app_style.dart';
import 'package:iyoot/utils/storage_pref.dart';
import 'package:iyoot/widgets/settings/settings_card.dart';

class AppStyleSettingPage extends StatelessWidget {
  const AppStyleSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("外观设置"),
      ),
      body: ListView(
        padding: AppStyle.edgeInsetsA12,
        children: [
          Padding(
            padding: AppStyle.edgeInsetsA12.copyWith(top: 0),
            child: Text(
              "显示主题",
              style: Get.textTheme.titleSmall,
            ),
          ),
          SettingsCard(
            child: Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  ],
                )
            ),
          )
        ],
      ),
    );
  }

}