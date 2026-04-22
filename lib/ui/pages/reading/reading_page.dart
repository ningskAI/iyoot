import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/config/app_config.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/data/models/reading_theme.dart';
import 'package:i_reader/providers/service_registry.dart';
import 'package:i_reader/ui/pages/reading/widgets/epub_player.dart';
import 'package:i_reader/ui/pages/reading/widgets/toc_widget.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ReadingPage extends ConsumerStatefulWidget {
  final Book book;
  final String? initialCfi;
  final List<ReadingTheme> initialThemes;

  const ReadingPage({
    super.key,
    required this.book,
    this.initialCfi,
    required this.initialThemes,
  });

  @override
  ConsumerState<ReadingPage> createState() => ReadingPageState();
}

final GlobalKey<ReadingPageState> readingPageKey =
    GlobalKey<ReadingPageState>();
final epubPlayerKey = GlobalKey<EpubPlayerState>();

class ReadingPageState extends ConsumerState<ReadingPage> {
  static const empty = SizedBox.shrink();

  // 控制整个 Overlay 层是否可见
  bool bottomBarOffstage = true;
  // 独立控制 AppBar 的显示（当点击底部按钮时隐藏）
  bool _isAppBarVisible = true;

  Timer? _awakeTimer;

  Future<void> setAwakeTimer(int minutes) async {
    _awakeTimer?.cancel();
    _awakeTimer = null;
    WakelockPlus.enable();
    _awakeTimer = Timer.periodic(Duration(minutes: minutes), (timer) {
      WakelockPlus.disable();
      _awakeTimer?.cancel();
      _awakeTimer = null;
    });
  }

  void resetAwakeTimer() {
    setAwakeTimer(AppConfig.getAwakeTime());
  }

  void showBottomBar() {
    setState(() {
      readService(AppServices.statusbarService).showStatusBarWithoutResize();
      bottomBarOffstage = false;
      _isAppBarVisible = true; // 唤起时默认重置 AppBar 为可见
    });
  }

  void hideBottomBar() {
    setState(() {
      readService(AppServices.statusbarService).hideStatusBar();
      bottomBarOffstage = true;
    });
  }

  void showOrHideAppBarAndBottomBar(bool show) {
    if (show) {
      showBottomBar();
    } else {
      hideBottomBar();
    }
  }

  Future<void> onLoadEnd() async {}

  void updateState() {
    if (mounted) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. 底层阅读器
          GestureDetector(
            onTap: () {
              showOrHideAppBarAndBottomBar(true);
            },
            child: EpubPlayer(
              key: epubPlayerKey,
              showOrHideAppBarAndBottomBar: showOrHideAppBarAndBottomBar,
              book: widget.book,
              onLoadEnd: onLoadEnd,
              initialThemes: widget.initialThemes,
              updateParent: updateState,
            ),
          ),

          // 2. 控制层 Overlay
          Offstage(
            offstage: bottomBarOffstage,
            child: SafeArea(
              top: false,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                extendBodyBehindAppBar: true,
                // 根据 _isAppBarVisible 决定是否显示 AppBar
                appBar: _isAppBarVisible
                    ? AppBar(
                        title: Text(
                          widget.book.title,
                          style: const TextStyle(fontSize: 16),
                        ),
                        leading: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.auto_awesome),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.bookmark_outline),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_horiz_outlined),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 8),
                        ],
                      )
                    : null,
                body: Column(
                  children: [
                    // 中间透明占位区域：点击关闭整个控制层
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showOrHideAppBarAndBottomBar(false);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: // 底部操作面板
                    _buildBottomBar(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      color: Theme.of(context).bottomSheetTheme.backgroundColor ?? Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomAction(
                icon: Icons.menu_outlined,
                onPressed: () {
                  // 点击菜单：先隐藏 AppBar，再弹出目录
                  setState(() => _isAppBarVisible = false);

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    constraints: const BoxConstraints(
                      minWidth: double.infinity,
                    ),
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: TocWidget(
                          currentHref: "",
                          onTocTap: (toc) {
                            Navigator.pop(context);
                            epubPlayerKey.currentState?.goToHref(toc.href);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              _buildBottomAction(
                icon: Icons.bookmark_outline,
                onPressed: () => setState(() => _isAppBarVisible = false),
              ),
              _buildBottomAction(
                icon: Icons.data_usage,
                onPressed: () => setState(() => _isAppBarVisible = false),
              ),
              _buildBottomAction(
                icon: Icons.color_lens,
                onPressed: () => setState(() => _isAppBarVisible = false),
              ),
              _buildBottomAction(
                icon: Icons.text_format,
                onPressed: () => setState(() => _isAppBarVisible = false),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildBottomAction({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(icon: Icon(icon), onPressed: onPressed);
  }
}
