import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/ui/modules/root/navigation_bar.dart';

class RootPage extends ConsumerWidget {
  final Widget child;
  const RootPage({super.key, required this.child});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Row(
        children: [Expanded(flex: 1, child: Container(child: child))],
      ),
      bottomNavigationBar: Visibility(
        visible: true,
        child: NextNavigationBar(),
      ),
    );
  }
}
