import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/app/app_style.dart';
import 'package:iyoot/app/utils.dart';
import 'package:remixicon/remixicon.dart';

@RoutePage()
class MinePage extends HookConsumerWidget{

  const MinePage({super.key});


  @override
  Widget build(BuildContext context, ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Get.isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
          systemNavigationBarColor: Colors.transparent)
          : SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor: Colors.transparent),
        child: SafeArea(
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
                title: const Text(
                  "iYooT",
                  style: TextStyle(height: 1.0)
                ),
                subtitle: const Text("但行好事，莫问前程"),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Get.dialog(AboutDialog(
                    applicationIcon: Image.asset(
                      'assets/images/logo.png',
                      width: 48,
                      height: 48,
                    ),
                    applicationName: "iYooT",
                    applicationVersion: "但行好事，莫问前程",
                    applicationLegalese: "Ver ${Utils.packageInfo.version}",
                  ));
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
                  ListTile(
                    leading: const Icon(Remix.history_line),
                    title: const Text("观看记录"),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey
                    ),
                    onTap: () {

                    }
                  ),
                ]
              ),
              Divider(
                indent: 12,
                endIndent: 12,
                color: Colors.grey.withAlpha(25),
              ),
              ListTile(
                  leading: const Icon(Remix.account_circle_fill),
                  title: const Text("账号管理"),
                  trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey
                  ),
                  onTap: () {

                  }
              ),
              Divider(
                indent: 12,
                endIndent: 12,
                color: Colors.grey.withAlpha(25),
              ),
              ListTile(
                  leading: const Icon(Icons.devices),
                  title: const Text("数据同步"),
                  trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey
                  ),
                  onTap: () {

                  }
              ),
              Divider(
                indent: 12,
                endIndent: 12,
                color: Colors.grey.withAlpha(25),
              ),
              ListTile(
                  leading: const Icon(Remix.link),
                  title: const Text("链接解析"),
                  trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey
                  ),
                  onTap: () {

                  }
              ),
              Divider(
                indent: 12,
                endIndent: 12,
                color: Colors.grey.withAlpha(25),
              ),
              ListTile(
                  leading: const Icon(Remix.settings_line),
                  title: const Text("设置"),
                  trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.grey
                  ),
                  onTap: () {
                    Get.toNamed('/setting');
                  }
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
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    ),
                    onTap: Utils.showStatement,
                  ),
                ],
              ),
            ],
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