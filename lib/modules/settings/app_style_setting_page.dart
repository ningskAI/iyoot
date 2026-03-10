import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iyoot/app/app_style.dart';
import 'package:iyoot/app/controller/app_settings_controller.dart';
import 'package:iyoot/widgets/settings/settings_card.dart';

class AppStyleSettingPage extends GetView<AppSettingsController> {
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
                    RadioListTile(
                        title: const Text(
                          "跟随系统"
                        ),
                        visualDensity: VisualDensity.compact,
                        value: 0,
                      contentPadding: AppStyle.edgeInsetsH12,
                      groupValue: controller.themeMode.value,
                      onChanged: (e) {
                          controller.setTheme(e ?? 0);
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text(
                        "浅色模式",
                      ),
                      visualDensity: VisualDensity.compact,
                      value: 1,
                      contentPadding: AppStyle.edgeInsetsH12,
                      groupValue: controller.themeMode.value,
                      onChanged: (e) {
                        controller.setTheme(e ?? 1);
                      },
                    ),
                    RadioListTile<int>(
                      title: const Text(
                        "深色模式",
                      ),
                      visualDensity: VisualDensity.compact,
                      value: 2,
                      contentPadding: AppStyle.edgeInsetsH12,
                      groupValue: controller.themeMode.value,
                      onChanged: (e) {
                        controller.setTheme(e ?? 2);
                      },
                    ),
                  ],
                )
            ),
          )
        ],
      ),
    );
  }

}