import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iyoot/app/app_style.dart';

@RoutePage()
class RootPage extends HookConsumerWidget{
  const RootPage({super.key});
  
  @override
  Widget build(BuildContext context, ref) {
      return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(toolbarHeight: 0),
        body: Padding(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
          ),
          child: Row(
              children: [
                Expanded(
                  flex: 1, child: Container(color: Colors.grey,),

                ),
                Expanded(
                  flex: 2, child: Container(color: Colors.red,),

                )
              ]
          ),
        ),
      );
  }

}