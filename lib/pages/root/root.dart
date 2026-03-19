import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/modules/root/navigation_bar.dart';
import 'package:iyoot/modules/root/sidebar.dart';

class RootPage extends ConsumerWidget{
  final Widget child;
  const RootPage({super.key,required this.child});
  
  @override
  Widget build(BuildContext context, ref) {
    final isLandscape = MediaQuery.orientationOf(context) == Orientation.landscape;
    return Scaffold(
      body: Row(
        children: [
          Visibility(
            visible: isLandscape, child:  NextSidebar()
          ),
          Expanded(flex:1,child: child)
        ],
      ),
      bottomNavigationBar: Visibility(visible: !isLandscape,child: NextNavigationBar()),
    );
  }

}