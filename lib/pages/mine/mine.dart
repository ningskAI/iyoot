import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/collections/app_style.dart';
import 'package:iyoot/modules/mine/mine_booklist_section.dart';
import 'package:iyoot/modules/mine/mine_read_rank_section.dart';
import 'package:remixicon/remixicon.dart';
import 'package:iyoot/modules/mine/mine_read_section.dart';

class MinePage extends HookConsumerWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.transparent,
      ),
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            padding: AppStyle.edgeInsetsA4,
            children: [
              AppStyle.vGap12,
              ListTile(
                leading: Image.asset(
                  'assets/images/logo.png',
                  width: 56,
                  height: 56,
                ),
                title: const Text("阅然", style: TextStyle(height: 1.0)),
                subtitle: const Text("但行好事，莫问前程"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Get.dialog(
                    AboutDialog(
                      applicationIcon: Image.asset(
                        'assets/images/logo.png',
                        width: 48,
                        height: 48,
                      ),
                      applicationName: "iyoot",
                      applicationVersion: "但行好事，莫问前程",
                    ),
                  );
                },
              ),
              SizedBox(height: 40,),
              MineReadRankSection(),
              SizedBox(height: 20,),
              MineReadSection(),
              SizedBox(height: 20,),
              MineBooklistSection(),
              SizedBox(height: 30,),
              ListTile(
                leading: const Icon(Remix.settings_line),
                title: const Text("设置"),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  context.push("/settings");
                },
              ),
              Divider(
                indent: 12,
                endIndent: 12,
                color: Colors.grey.withAlpha(25),
              ),
              _buildCard(
                context,
                children: [
                  const ListTile(
                    leading: Icon(Remix.error_warning_line),
                    title: Text("免责声明"),
                    trailing: Icon(Icons.chevron_right, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required List<Widget> children}) {
    return Theme(
      data: Theme.of(context).copyWith(
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(borderRadius: AppStyle.radius8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
