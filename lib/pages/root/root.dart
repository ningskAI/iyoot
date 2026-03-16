import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/modules/root/navigation_bar.dart';
import 'package:iyoot/modules/root/sidebar.dart';
import 'package:iyoot/provider/user_preferences_provider.dart';
import 'package:iyoot/routes/routes.gr.dart';

@RoutePage()
class RootPage extends ConsumerWidget{
  const RootPage({super.key});
  
  @override
  Widget build(BuildContext context, ref) {
    final isLandscape = MediaQuery.orientationOf(context) == Orientation.landscape;
    return Scaffold(
      body: Row(
        children: [
          Visibility(
            visible: isLandscape, child:  NextSidebar()
          ),
          Expanded(child: AutoRouter())
        ],
      ),
      bottomNavigationBar: Visibility(visible: !isLandscape,child: NextNavigationBar()),
    );
  }

}