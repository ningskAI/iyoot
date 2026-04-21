import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:i_reader/ui/widgets/td/td_themed_navigation_bar.dart';

WebViewEnvironment? webViewEnvironment;

class RootPage extends StatefulWidget {
  final Widget child;
  const RootPage({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _RootState();
}

class _RootState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initData());
  }

  Future<void> initData() async {}

  @override
  Widget build(BuildContext context) {
    // 手机模式：内容 + 底边栏
    return Scaffold(
      body: Container(child: widget.child),
      bottomNavigationBar: Visibility(
        visible: true,
        child: NextNavigationBar(orientation: Axis.horizontal),
      ),
    );
  }
}
