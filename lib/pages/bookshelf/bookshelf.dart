import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class BookshelfPage extends HookConsumerWidget{

  const BookshelfPage({super.key});


  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}