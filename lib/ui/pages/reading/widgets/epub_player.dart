import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/config/app_config.dart';
import 'package:i_reader/data/enums/translation_enums.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/data/models/book_note.dart';
import 'package:i_reader/data/models/book_style.dart';
import 'package:i_reader/data/models/bookmark.dart';
import 'package:i_reader/data/models/font_model.dart';
import 'package:i_reader/data/models/reading_info.dart';
import 'package:i_reader/data/models/reading_theme.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/providers/chapter_content_provider.dart';
import 'package:i_reader/providers/service_registry.dart';
import 'package:i_reader/ui/pages/reading/reading_page.dart';
import 'package:i_reader/utils/app_log.dart';
import 'package:i_reader/utils/color_utils.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/diagram.dart';
import '../models/types_and_icons.dart';
import 'package:i_reader/data/datasources/impl/book_note_datasource_impl.dart';
import 'package:i_reader/utils/platform.dart';
import 'package:i_reader/data/enums/reading_info.dart';
import 'package:i_reader/ui/pages/root/root.dart';
import 'package:i_reader/core/webview/generate_url.dart';
import 'package:battery_plus/battery_plus.dart';
import 'minute_clock.dart';

class EpubPlayer extends ConsumerStatefulWidget {
  final Book book;
  final String? cfi;
  final Function showOrHideAppBarAndBottomBar;
  final Function onLoadEnd;
  final List<ReadingTheme> initialThemes;
  final Function updateParent;

  const EpubPlayer({
    super.key,
    required this.showOrHideAppBarAndBottomBar,
    required this.book,
    this.cfi,
    required this.onLoadEnd,
    required this.initialThemes,
    required this.updateParent,
  });

  @override
  ConsumerState<EpubPlayer> createState() => EpubPlayerState();
}

class EpubPlayerState extends ConsumerState<EpubPlayer>
    with TickerProviderStateMixin {
  late InAppWebViewController webViewController;
  late ContextMenu contextMenu;
  String cfi = '';
  double percentage = 0.0;
  String chapterTitle = '';
  String chapterHref = '';
  int chapterCurrentPage = 0;
  int chapterTotalPages = 0;
  OverlayEntry? contextMenuEntry;
  AnimationController? _animationController;
  Animation<double>? _animation;
  bool showHistory = false;
  bool canGoBack = false;
  bool canGoForward = false;
  late Book book;
  String? backgroundColor;
  String? textColor;
  Timer? styleTimer;
  String bookmarkCfi = '';
  bool bookmarkExists = false;
  String? _lastSelectionContextText;
  bool _selectionClearLocked = false;
  bool _selectionClearPending = false;

  // Scroll wheel debounce
  Timer? _scrollDebounceTimer;
  double _accumulatedScrollDelta = 0;
  static const double _scrollThreshold = 50.0;

  // to know anytime if we are on top of navigation stack
  bool get _isTopOfNavigationStack =>
      ModalRoute.of(context)?.isCurrent ?? false;

  void prevPage() {
    webViewController.evaluateJavascript(source: 'prevPage()');
  }

  void nextPage() {
    webViewController.evaluateJavascript(source: 'nextPage()');
  }

  void prevChapter() {
    webViewController.evaluateJavascript(
      source: '''
      prevSection()
      ''',
    );
  }

  void nextChapter() {
    webViewController.evaluateJavascript(
      source: '''
      nextSection()
      ''',
    );
  }

  void setTranslationMode(TranslationModeEnum mode) {
    webViewController.evaluateJavascript(
      source:
          '''
      if (typeof reader.view !== 'undefined' && reader.view.setTranslationMode) {
        reader.view.setTranslationMode('${mode.code}');
      }
      ''',
    );
  }

  Future<void> goToPercentage(double value) async {
    await webViewController.evaluateJavascript(
      source:
          '''
      goToPercent($value); 
      ''',
    );
  }

  void setSelectionClearLocked(bool locked) {
    _selectionClearLocked = locked;
    if (!locked && _selectionClearPending) {
      _selectionClearPending = false;
      _lastSelectionContextText = null;
      removeOverlay();
    }
  }

  void changeTheme(ReadingTheme readTheme) {
    textColor = readTheme.textColor;
    backgroundColor = readTheme.backgroundColor;

    String bc = ColorUtils.convertDartColorToJs(readTheme.backgroundColor);
    String tc = ColorUtils.convertDartColorToJs(readTheme.textColor);

    webViewController.evaluateJavascript(
      source:
          '''
      changeStyle({
        backgroundColor: '#$bc',
        fontColor: '#$tc',
      })
      ''',
    );
  }

  void changeStyle(BookStyle? bookStyle) {
    styleTimer?.cancel();

    styleTimer = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      BookStyle style =
          bookStyle ??
          BookStyle(
            fontSize: 1.4,
            fontFamily: 'Arial',
            fontWeight: 400,
            lineHeight: 1.8,
            letterSpacing: 0.0,
            wordSpacing: 0.0,
            paragraphSpacing: 1.0,
            sideMargin: 6.0,
            topMargin: 90.0,
            bottomMargin: 50.0,
            indent: 0,
            maxColumnCount: 0,
            headingFontSize: 1.0,
            columnThreshold: 720.0,
          );
      webViewController.evaluateJavascript(
        source:
            '''
      changeStyle({
        fontSize: ${style.fontSize},
        spacing: ${style.lineHeight},
        fontWeight: ${style.fontWeight},
        paragraphSpacing: ${style.paragraphSpacing},
        topMargin: ${style.topMargin},
        bottomMargin: ${style.bottomMargin},
        sideMargin: ${style.sideMargin},
        letterSpacing: ${style.letterSpacing},
        textIndent: ${style.indent},
        maxColumnCount: ${style.maxColumnCount},
        columnThreshold: ${style.columnThreshold},
        useBookStyles: true,
        headingFontSize: ${style.headingFontSize},
      })
      ''',
      );
    });
  }

  void changeBgimgEffect() {
    // TODO
    if (!mounted) return;
  }

  void changeFont(FontModel font) {
    webViewController.evaluateJavascript(
      source:
          '''
      changeStyle({
        fontName: '${font.name}',
        fontPath: '${font.path}',
      })
    ''',
    );
  }

  void goToHref(String href) =>
      webViewController.evaluateJavascript(source: "goToHref('$href')");

  void goToCfi(String cfi) =>
      webViewController.evaluateJavascript(source: "goToCfi('$cfi')");

  void addAnnotation(BookNote bookNote) {
    final noteContent = (bookNote.content)
        .replaceAll('\n', ' ')
        .replaceAll("'", "\\'");
    webViewController.evaluateJavascript(
      source:
          '''
      addAnnotation({
        id: ${bookNote.id},
        type: '${bookNote.type}',
        value: '${bookNote.cfi}',
        color: '#${bookNote.color}',
        note: '$noteContent',
      })
      ''',
    );
  }

  void addBookmark(BookmarkModel bookmark) {
    webViewController.evaluateJavascript(
      source:
          '''
      addAnnotation({
        id: ${bookmark.id},
        type: 'bookmark',
        value: '${bookmark.cfi}',
        color: '#000000',
        note: 'None',
      })
      ''',
    );
  }

  void addBookmarkHere() {
    webViewController.evaluateJavascript(
      source: '''
      addBookmarkHere()
      ''',
    );
  }

  void removeAnnotation(String cfi) =>
      webViewController.evaluateJavascript(source: "removeAnnotation('$cfi')");

  void clearSearch() {
    // TODO clear search results in tocSearchProvider as well
    _clearSearchHighlights();
  }

  void search(String text) {
    final sanitized = text.trim();
    if (sanitized.isEmpty) {
      clearSearch();
      return;
    }
    _clearSearchHighlights();
    // TODO
    // ref.read(tocSearchProvider.notifier).start(sanitized);
    webViewController.evaluateJavascript(
      source:
          '''
      search('$sanitized', {
        'scope': 'book',
        'matchCase': false,
        'matchDiacritics': false,
        'matchWholeWords': false,
      })
    ''',
    );
  }

  void _clearSearchHighlights() {
    webViewController.evaluateJavascript(source: "clearSearch()");
  }

  Future<void> initTts({String? fromCfi}) async {
    if (fromCfi != null && fromCfi.isNotEmpty) {
      await webViewController.evaluateJavascript(
        source: "window.ttsFromCfi('$fromCfi')",
      );
    } else {
      await webViewController.evaluateJavascript(source: "window.ttsHere()");
    }
  }

  void ttsStop() => webViewController.evaluateJavascript(source: "ttsStop()");

  Future<String> ttsNext() async =>
      (await webViewController.callAsyncJavaScript(
        functionBody: "return await ttsNext()",
      ))?.value;

  Future<String> ttsPrev() async =>
      (await webViewController.callAsyncJavaScript(
        functionBody: "return await ttsPrev()",
      ))?.value;

  Future<String> ttsPrevSection() async =>
      (await webViewController.callAsyncJavaScript(
        functionBody: "return await ttsPrevSection()",
      ))?.value;

  Future<String> ttsNextSection() async =>
      (await webViewController.callAsyncJavaScript(
        functionBody: "return await ttsNextSection()",
      ))?.value;

  Future<String> ttsPrepare() async =>
      (await webViewController.evaluateJavascript(source: "ttsPrepare()"));
  Future<bool> isFootNoteOpen() async => (await webViewController
      .evaluateJavascript(source: "window.isFootNoteOpen()"));

  void backHistory() {
    webViewController.evaluateJavascript(source: "back()");
  }

  void forwardHistory() {
    webViewController.evaluateJavascript(source: "forward()");
  }

  void refreshToc() {
    webViewController.evaluateJavascript(source: "refreshToc()");
  }

  Future<String> theChapterContent() async =>
      await webViewController.evaluateJavascript(source: "theChapterContent()");

  Future<String> previousContent(int count) async => await webViewController
      .evaluateJavascript(source: "previousContent($count)");

  Future<String> _getCurrentChapterContent({int? maxCharacters}) async {
    final raw = await theChapterContent();
    return _normalizeChapterContent(raw, maxCharacters);
  }

  Future<String> _getChapterContentByHref(
    String href, {
    int? maxCharacters,
  }) async {
    if (href.isEmpty) {
      return '';
    }

    final result = await webViewController.callAsyncJavaScript(
      functionBody:
          'return await getChapterContentByHref("${href.replaceAll('"', '\\"')}")',
    );

    final value = result?.value;
    if (value is String) {
      return _normalizeChapterContent(value, maxCharacters);
    }
    return '';
  }

  String _normalizeChapterContent(String? content, int? maxCharacters) {
    if (content == null || content.isEmpty) {
      return '';
    }
    final trimmed = content.trim();
    if (maxCharacters != null &&
        maxCharacters > 0 &&
        trimmed.length > maxCharacters) {
      return trimmed.substring(0, maxCharacters);
    }
    return trimmed;
  }

  void _registerChapterContentBridge() {
    ref
        .read(chapterContentBridgeProvider.notifier)
        .state = ChapterContentHandlers(
      fetchCurrentChapter: ({int? maxCharacters}) =>
          _getCurrentChapterContent(maxCharacters: maxCharacters),
      fetchChapterByHref: (href, {int? maxCharacters}) =>
          _getChapterContentByHref(href, maxCharacters: maxCharacters),
    );
  }

  Future<void> _handleExternalLink(dynamic rawLink) async {
    String? normalizeExternalLink(dynamic raw) {
      if (raw == null) {
        return null;
      }
      if (raw is String && raw.trim().isNotEmpty) {
        return raw.trim();
      }
      if (raw is Map && raw['href'] is String) {
        final href = raw['href'].toString().trim();
        return href.isEmpty ? null : href;
      }
      return null;
    }

    final link = normalizeExternalLink(rawLink);
    if (!mounted || link == null) {
      return;
    }

    final uri = Uri.tryParse(link);
    if (uri == null || uri.scheme.isEmpty || uri.scheme == 'javascript') {
      AppLog.instance.put('Ignored invalid external link: $link');
      return;
    }

    final shouldOpen = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final l10n = L10n.of(dialogContext);
        return AlertDialog(
          title: Text("打开外部链接"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("是否打开以下链接？"),
              const SizedBox(height: 8),
              SelectableText(link),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text("取消"),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text("打开"),
            ),
          ],
        );
      },
    );

    if (shouldOpen != true) {
      return;
    }

    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened) {
      AppLog.instance.put('Failed to open external link: $link');
    }
  }

  void onClick(Map<String, dynamic> location) {
    readingPageKey.currentState?.resetAwakeTimer();
    if (contextMenuEntry != null) {
      removeOverlay();
      return;
    }
    final x = location['x'];
    final y = location['y'];
    final part = coordinatesToPart(x, y);

    PageTurningType action;
    final currentPageTurningType = AppConfig.getPageTurningType();
    final pageTurningType = pageTurningTypes[currentPageTurningType];
    action = pageTurningType[part];
    if (action == PageTurningType.prev) {
      action = PageTurningType.next;
    } else if (action == PageTurningType.next) {
      action = PageTurningType.prev;
    }

    switch (action) {
      case PageTurningType.prev:
        prevPage();
        break;
      case PageTurningType.next:
        nextPage();
        break;
      case PageTurningType.menu:
        widget.showOrHideAppBarAndBottomBar(true);
        break;
      case PageTurningType.none:
        break;
    }
  }

  Future<void> renderAnnotations(InAppWebViewController controller) async {
    List<BookNote> annotationList = await BookNoteDatasourceImpl()
        .selectBookNotesByBookId(widget.book.id);
    String allAnnotations = jsonEncode(
      annotationList.map((e) => e.toJson()).toList(),
    ).replaceAll('\'', '\\\'');
    controller.evaluateJavascript(
      source:
          '''
     const allAnnotations = $allAnnotations
     renderAnnotations()
    ''',
    );
  }

  void getThemeColor() {
    // TODO
    textColor = "FF343434";
    backgroundColor = "FFFBFBF3";
  }

  Future<void> setHandler(InAppWebViewController controller) async {
    controller.addJavaScriptHandler(
      handlerName: 'onLoadEnd',
      callback: (args) {
        widget.onLoadEnd();
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'onRelocated',
      callback: (args) {
        Map<String, dynamic> location = args[0];
        if (cfi == location['cfi']) return;
        // if (chapterHref != location['chapterHref']) {
        //   refreshToc();
        // }
        setState(() {
          cfi = location['cfi'] ?? '';
          percentage =
              double.tryParse(location['percentage'].toString()) ?? 0.0;
          chapterTitle = location['chapterTitle'] ?? '';
          chapterHref = location['chapterHref'] ?? '';
          chapterCurrentPage = location['chapterCurrentPage'] ?? 0;
          chapterTotalPages = location['chapterTotalPages'] ?? 0;
          bookmarkExists = location['bookmark']['exists'] ?? false;
          bookmarkCfi = location['bookmark']['cfi'] ?? '';
        });
        // 更新阅读时长
        widget.updateParent();
        saveReadingProgress();
        readingPageKey.currentState?.resetAwakeTimer();
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onClick',
      callback: (args) {
        Map<String, dynamic> location = args[0];
        onClick(location);
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onExternalLink',
      callback: (args) async {
        final payload = args.isNotEmpty ? args.first : null;
        await _handleExternalLink(payload);
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onSetToc',
      callback: (args) {
        // List<dynamic> t = args[0];
        // final toc = t.map((i) => TocItem.fromJson(i)).toList();
        // ref.read(bookTocProvider.notifier).setToc(toc);
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onSelectionEnd',
      callback: (args) {
        removeOverlay();
        Map<String, dynamic> location = args[0];
        String cfi = location['cfi'];
        String text = location['text'];
        bool footnote = location['footnote'];
        final rawContextText = location['contextText']?.toString();
        _lastSelectionContextText = (rawContextText?.trim().isEmpty ?? true)
            ? null
            : rawContextText;
        double left = (location['pos']['left'] as num).toDouble();
        double top = (location['pos']['top'] as num).toDouble();
        double right = (location['pos']['right'] as num).toDouble();
        double bottom = (location['pos']['bottom'] as num).toDouble();
        // TODO
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onSelectionCleared',
      callback: (args) {
        if (_selectionClearLocked) {
          _selectionClearPending = true;
          return;
        }
        _lastSelectionContextText = null;
        removeOverlay();
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onAnnotationClick',
      callback: (args) {
        Map<String, dynamic> annotation = args[0];

        if (annotation['annotation'] == null) {
          AppLog.instance.put('Invalid annotation click event: $annotation');
          return;
        }

        int id = annotation['annotation']['id'];
        String cfi = annotation['annotation']['value'];
        String note = annotation['annotation']['note'];
        final rawContextText = annotation['contextText']?.toString();
        _lastSelectionContextText = (rawContextText?.trim().isEmpty ?? true)
            ? null
            : rawContextText;
        double left = (annotation['pos']['left'] as num).toDouble();
        double top = (annotation['pos']['top'] as num).toDouble();
        double right = (annotation['pos']['right'] as num).toDouble();
        double bottom = (annotation['pos']['bottom'] as num).toDouble();
        // TODO distinguish between different annotation types (highlight, note, bookmark) and pass that info to the context menu
        // showContextMenu(
        //   context,
        //   left,
        //   top,
        //   right,
        //   bottom,
        //   note,
        //   cfi,
        //   id,
        //   false,
        //   Axis.horizontal,
        //   contextText: _lastSelectionContextText,
        // );
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onSearch',
      callback: (args) {
        Map<String, dynamic> search = args[0];
        // TODO handle search results and progress updates, e.g. by updating a provider that the TOC search widget listens to
        // setState(() {
        //   final tocSearch = ref.read(tocSearchProvider.notifier);
        //   if (search['process'] != null) {
        //     final progress = search['process'].toDouble();
        //     tocSearch.updateProgress(progress);
        //   } else {
        //     tocSearch.addResult(SearchResultModel.fromJson(search));
        //   }
        // });
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'renderAnnotations',
      callback: (args) {
        renderAnnotations(controller);
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onPushState',
      callback: (args) {
        Map<String, dynamic> state = args[0];
        if (!mounted) return;
        setState(() {
          canGoBack = state['canGoBack'];
          canGoForward = state['canGoForward'];
          showHistory = canGoBack || canGoForward;
        });
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onImageClick',
      callback: (args) {
        String image = args[0];
        // TODO 显示图片预览界面
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onFootnoteClose',
      callback: (args) {
        removeOverlay();
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'onPullUp',
      callback: (args) {
        widget.showOrHideAppBarAndBottomBar(true);
      },
    );
    controller.addJavaScriptHandler(
      handlerName: 'handleBookmark',
      callback: (args) async {
        // TODO
      },
    );
  }

  Future<void> onWebViewCreated(InAppWebViewController controller) async {
    if (kIsAndroid) {
      await InAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    webViewController = controller;
    setHandler(controller);
    _registerChapterContentBridge();
  }

  void removeOverlay() {
    _selectionClearLocked = false;
    _selectionClearPending = false;
    if (contextMenuEntry == null || contextMenuEntry?.mounted == false) return;
    contextMenuEntry?.remove();
    contextMenuEntry = null;
  }

  @override
  void initState() {
    readService(AppServices.statusbarService).hideStatusBar();
    book = widget.book;
    getThemeColor();

    contextMenu = ContextMenu(
      settings: ContextMenuSettings(hideDefaultSystemContextMenuItems: true),
      onCreateContextMenu: (hitTestResult) async {
        // webViewController.evaluateJavascript(source: "showContextMenu()");
      },
      onHideContextMenu: () {
        // removeOverlay();
      },
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> saveReadingProgress() async {}

  @override
  void dispose() {
    readService(AppServices.statusbarService).hideStatusBar();
    _scrollDebounceTimer?.cancel();
    _animationController?.dispose();
    saveReadingProgress();
    removeOverlay();
    super.dispose();
  }

  InAppWebViewSettings initialSettings = InAppWebViewSettings(
    supportZoom: false,
    transparentBackground: true,
    useHybridComposition: true,
  );

  bool get isDarkMode => AppConfig.getThemeMode() == 2;

  void changeReadingInfo() {
    setState(() {});
  }

  Widget _buildHistoryCapsule() {
    final l10n = L10n.of(context);
    final buttonColor = Color(int.parse('0x$textColor')).withAlpha(200);

    // Common button style for all history navigation buttons
    final buttonStyle = TextButton.styleFrom(
      minimumSize: const Size(0, 32),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
    );

    // Helper method to create history navigation buttons
    Widget createHistoryButton(
      IconData icon,
      String label,
      VoidCallback onPressed,
    ) {
      return TextButton.icon(
        icon: Icon(icon, size: 18, color: buttonColor),
        label: Text(label, style: TextStyle(color: buttonColor, fontSize: 14)),
        onPressed: onPressed,
        style: buttonStyle,
      );
    }

    // Build buttons list
    final List<Widget> buttons = [];

    if (canGoBack) {
      buttons.add(createHistoryButton(Icons.arrow_back, "后退", backHistory));
    }

    buttons.add(
      createHistoryButton(
        Icons.close,
        "关闭",
        () => setState(() => showHistory = false),
      ),
    );

    if (canGoForward) {
      buttons.add(
        createHistoryButton(Icons.arrow_forward, "前进", forwardHistory),
      );
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              height: 32,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainer.withAlpha(123),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 0.5,
                ),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: buttons),
            ),
          ),
        ),
      ),
    );
  }

  Widget readingInfoWidget() {
    if (chapterCurrentPage == 0 && percentage == 0.0) {
      return const SizedBox();
    }

    final readingInfoColor = Color(int.parse('0x$textColor')).withAlpha(150);
    final iconColor = Color(int.parse('0x$textColor'));

    Widget getWidget(ReadingInfoEnum readingInfoEnum, TextStyle textStyle) {
      final batteryTextStyle = TextStyle(
        color: iconColor,
        fontSize: (textStyle.fontSize ?? 10) - 1,
      );
      final batteryIconSize = (textStyle.fontSize ?? 10) * 2.7;

      final chapterTitleWidget = Text(
        (chapterCurrentPage == 1 ? widget.book.title : chapterTitle),
        style: textStyle,
      );

      final chapterProgressWidget = Text(
        '$chapterCurrentPage/$chapterTotalPages',
        style: textStyle,
      );

      final bookProgressWidget = Text(
        '${(percentage * 100).toStringAsFixed(2)}%',
        style: textStyle,
      );

      final timeWidget = MinuteClock(textStyle: textStyle);

      final batteryWidget = FutureBuilder(
        future: Battery().batteryLevel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    (textStyle.fontSize ?? 10) * 0.08,
                    2,
                    0,
                  ),
                  child: Text('${snapshot.data}', style: batteryTextStyle),
                ),
                Icon(
                  HeroIcons.battery_0,
                  size: batteryIconSize,
                  color: iconColor,
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      );

      Widget batteryAndTimeWidget() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [batteryWidget, const SizedBox(width: 5), timeWidget],
      );

      switch (readingInfoEnum) {
        case ReadingInfoEnum.chapterTitle:
          return chapterTitleWidget;
        case ReadingInfoEnum.chapterProgress:
          return chapterProgressWidget;
        case ReadingInfoEnum.bookProgress:
          return bookProgressWidget;
        case ReadingInfoEnum.battery:
          return batteryWidget;
        case ReadingInfoEnum.time:
          return timeWidget;
        case ReadingInfoEnum.batteryAndTime:
          return batteryAndTimeWidget();
        case ReadingInfoEnum.none:
          return const SizedBox(width: 30);
      }
    }

    final readingInfo = ReadingInfoModel();

    final headerTextStyle = TextStyle(
      color: readingInfoColor,
      fontSize: readingInfo.header.fontSize,
    );
    final footerTextStyle = TextStyle(
      color: readingInfoColor,
      fontSize: readingInfo.footer.fontSize,
    );

    List<Widget> headerWidgets = [
      getWidget(readingInfo.header.left, headerTextStyle),
      getWidget(readingInfo.header.center, headerTextStyle),
      getWidget(readingInfo.header.right, headerTextStyle),
    ];

    List<Widget> footerWidgets = [
      getWidget(readingInfo.footer.left, footerTextStyle),
      getWidget(readingInfo.footer.center, footerTextStyle),
      getWidget(readingInfo.footer.right, footerTextStyle),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: readingInfo.header.verticalMargin,
            left: readingInfo.header.leftMargin,
            right: readingInfo.header.rightMargin,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: headerWidgets,
          ),
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(
            bottom: readingInfo.footer.verticalMargin,
            left: readingInfo.footer.leftMargin,
            right: readingInfo.footer.rightMargin,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: footerWidgets,
          ),
        ),
      ],
    );
  }

  Widget buildWebviewWithIOSWorkaround(
    BuildContext context,
    String url,
    String initialCfi,
  ) {
    final webView = InAppWebView(
      webViewEnvironment: webViewEnvironment,
      initialUrlRequest: URLRequest(
        url: WebUri(
          generateUrl(
            url,
            initialCfi,
            backgroundColor: backgroundColor,
            textColor: textColor,
            isDarkMode: Theme.of(context).brightness == Brightness.dark,
          ),
        ),
      ),
      initialSettings: initialSettings,
      contextMenu: contextMenu,
      onLoadStop: (controller, uri) => onWebViewCreated(controller),
    );

    if (!kIsIOS) {
      return SizedBox.expand(child: webView);
    }

    return SizedBox.expand(child: Stack(children: [webView]));
  }

  @override
  Widget build(BuildContext context) {
    String uri = Uri.encodeComponent(widget.book.fileFullPath);
    String url = 'http://127.0.0.1:${AppConfig.getLastServerPort()}/book/$uri';
    String initialCfi = widget.cfi ?? widget.book.lastReadPosition;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          buildWebviewWithIOSWorkaround(context, url, initialCfi),
          readingInfoWidget(),
          if (showHistory) _buildHistoryCapsule(),
        ],
      ),
    );
  }

  int coordinatesToPart(double x, double y) {
    if (x < 0.33) {
      if (y < 0.33) {
        return 0;
      } else if (y < 0.66) {
        return 3;
      } else {
        return 6;
      }
    } else if (x < 0.66) {
      if (y < 0.33) {
        return 1;
      } else if (y < 0.66) {
        return 4;
      } else {
        return 7;
      }
    } else {
      if (y < 0.33) {
        return 2;
      } else if (y < 0.66) {
        return 5;
      } else {
        return 8;
      }
    }
  }
}
