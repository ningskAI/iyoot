import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/config/app_theme.dart';
import 'package:i_reader/ui/modules/mine/mine_booklist_section.dart';
import 'package:i_reader/ui/modules/mine/mine_read_rank_section.dart';
import 'package:remixicon/remixicon.dart';
import 'package:i_reader/ui/modules/mine/mine_read_section.dart';

class MinePage extends ConsumerWidget {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: Colors.transparent,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarColor: Colors.transparent,
            ),
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: ListView(
            padding: EdgeInsets.all(4),
            children: [
              SizedBox(height: 12),
              ListTile(
                leading: Image.asset(
                  'assets/images/logo.png',
                  width: 56,
                  height: 56,
                ),
                title: const Text("阅然", style: TextStyle(height: 1.0)),
                subtitle: const Text("但行好事，莫问前程"),
                trailing: const Icon(Icons.chevron_right),
              ),
              SizedBox(height: 40),
              MineReadRankSection(),
              SizedBox(height: 20),
              MineReadSection(),
              SizedBox(height: 20),
              MineBooklistSection(),
              SizedBox(height: 30),
              ListTile(
                leading: const Icon(Remix.settings_line),
                title: const Text("设置"),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  context.push("/settings");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
