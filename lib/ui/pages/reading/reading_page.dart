import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/config/app_config.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/data/models/reading_theme.dart';
import 'package:i_reader/providers/service_registry.dart';
import 'package:i_reader/ui/pages/reading/widgets/epub_player.dart';
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
  bool bottomBarOffstage = true;

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

          Offstage(
            offstage: bottomBarOffstage,
            child: SafeArea(
              top: false,
              child: Stack(
                children: [
                  Scaffold(
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      title: Text(
                        widget.book.title,
                        style: const TextStyle(fontSize: 18),
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
                          icon: Icon(Icons.more_horiz_outlined),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showOrHideAppBarAndBottomBar(false);
                            },
                            behavior: HitTestBehavior.opaque,
                            onVerticalDragUpdate: (details) {},
                            onVerticalDragEnd: (details) {},
                            child: Container(color: Colors.transparent),
                          ),
                        ),
                        _buildBottomBar(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.bookmark_outline),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.data_usage),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.color_lens),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.text_format),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
