import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_reader/config/app_config.dart';
import 'package:i_reader/data/models/book_note.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/providers/booknote_provider.dart';
import 'package:i_reader/ui/pages/reading/reading_page.dart';
import 'package:i_reader/data/models/book_annotation.dart';
import 'package:i_reader/ui/pages/reading/widgets/context_menu/reader_note_menu.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExcerptMenu extends ConsumerStatefulWidget {
  final String annoCfi;
  final String annoContent;
  final int? id;
  final Function() onClose;
  final bool footnote;
  final BoxDecoration decoration;
  final void Function({bool? show}) toggleReaderNoteMenu;
  final Future<void> Function(int noteId) openReaderNoteMenu;
  final void Function(int noteId) onNoteCreated;
  final Axis axis;
  final bool reverse;

  const ExcerptMenu({
    super.key,
    required this.annoCfi,
    required this.annoContent,
    this.id,
    required this.onClose,
    required this.footnote,
    required this.decoration,
    required this.toggleReaderNoteMenu,
    required this.openReaderNoteMenu,
    required this.onNoteCreated,
    required this.axis,
    required this.reverse,
  });

  @override
  ExcerptMenuState createState() => ExcerptMenuState();
}

class ExcerptMenuState extends ConsumerState<ExcerptMenu> {
  bool deleteConfirm = false;
  int? noteId;
  BookNote? _currentNote;
  late String annoType;
  late String annoColor;
  String? _selectedAnnotationType; // 当前选中的标注类型（underline 或 highlight）
  bool _showAnnotationMenu = false; // 是否显示标注类型和颜色选择菜单
  bool _showColorPicker = false; // 是否显示颜色选择弹窗

  @override
  void initState() {
    super.initState();
    // 从配置中读取上次选择的类型和颜色
    annoType = AppConfig.getLastAnnotationType();
    annoColor = AppConfig.getLastAnnotationColor();
    _selectedAnnotationType = annoType;
    _initializeExistingNote();
  }

  Future<void> _initializeExistingNote() async {
    final existingId = widget.id;
    if (existingId == null) return;

    try {
      final notes = await ref.read(
        bookNoteNotifierProvider(
          epubPlayerKey.currentState!.widget.book.id,
        ).future,
      );
      final note = notes.firstWhere(
        (n) => n.id == existingId,
        orElse: () => throw Exception('Not found'),
      );

      if (!mounted) return;
      setState(() {
        _currentNote = note;
        noteId = note.id;
        annoType = note.type;
        annoColor = note.color;
        _selectedAnnotationType = note.type; // 设置已存在的标注类型
      });

      // If has reader note, open it automatically
      if (!widget.footnote &&
          note.readerNote != null &&
          note.readerNote!.isNotEmpty) {
        await widget.openReaderNoteMenu(note.id!);
      }
    } catch (_) {
      // Keep defaults when note cannot be loaded
    }
  }

  Future<BookNote?> _fetchLatestNote() async {
    final existingId = noteId ?? widget.id;
    if (existingId == null) return null;

    try {
      final notes = await ref.read(
        bookNoteNotifierProvider(
          epubPlayerKey.currentState!.widget.book.id,
        ).future,
      );
      return notes.firstWhere(
        (n) => n.id == existingId,
        orElse: () => throw Exception('Not found'),
      );
    } catch (_) {
      return null;
    }
  }

  Future<BookNote> _persistNote({
    String? color,
    String? type,
    String? content,
  }) async {
    final existingNote = await _fetchLatestNote() ?? _currentNote;
    final now = DateTime.now();

    // 安全检查：确保 epubPlayerKey.currentState 不为空
    final currentState = epubPlayerKey.currentState;
    if (currentState == null) {
      throw StateError('Epub player state is not available');
    }

    final resolvedContent = (content ?? widget.annoContent).trim().isNotEmpty
        ? (content ?? widget.annoContent)
        : (existingNote?.content ?? widget.annoContent);
    final resolvedType = type ?? existingNote?.type ?? annoType;
    final resolvedColor = color ?? existingNote?.color ?? annoColor;

    final bookNote = BookNote(
      id: existingNote?.id ?? widget.id,
      bookId: existingNote?.bookId ?? currentState.widget.book.id,
      content: resolvedContent,
      cfi: existingNote?.cfi ?? widget.annoCfi,
      chapter: existingNote?.chapter ?? currentState.chapterTitle,
      type: resolvedType,
      color: resolvedColor,
      readerNote: existingNote?.readerNote,
      createTime: existingNote?.createTime ?? now,
      updateTime: now,
    );

    final notifier = ref.read(
      bookNoteNotifierProvider(bookNote.bookId).notifier,
    );
    final savedNote = await notifier.addNote(bookNote);

    // 安全检查：确保 widget 仍然挂载
    if (!mounted) {
      return savedNote;
    }

    widget.onNoteCreated(savedNote.id!);

    setState(() {
      _currentNote = savedNote;
      noteId = savedNote.id;
      annoType = resolvedType;
      annoColor = resolvedColor;
    });

    return savedNote;
  }

  Future<void> onColorSelected(String color, {bool close = false}) async {
    if (mounted) {
      setState(() {
        annoColor = color;
      });
    } else {
      annoColor = color;
    }

    final bookNote = await _persistNote(color: color);

    // 保存颜色配置
    await AppConfig.setLastAnnotationColor(color);

    // 安全检查：确保 epubPlayerKey.currentState 不为空且 widget 仍然挂载
    if (mounted) {
      epubPlayerKey.currentState?.addAnnotation(bookNote);
    }

    // 不自动关闭菜单，让用户可以自由选择颜色
  }

  Future<void> onTypeSelected(String type) async {
    if (mounted) {
      setState(() {
        annoType = type;
        _selectedAnnotationType = type;
      });
    } else {
      annoType = type;
      _selectedAnnotationType = type;
    }

    final bookNote = await _persistNote(type: type);

    // 保存类型配置
    await AppConfig.setLastAnnotationType(type);

    // 安全检查：确保 epubPlayerKey.currentState 不为空且 widget 仍然挂载
    if (mounted) {
      epubPlayerKey.currentState?.addAnnotation(bookNote);
    }
  }

  Widget iconButton({required Icon icon, required Function() onPressed}) {
    return IconButton(
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(),
      style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      icon: icon,
      onPressed: onPressed,
    );
  }

  // 显示移除选项对话框
  void _showRemoveOptions() {
    final hasNote = _currentNote?.readerNote?.isNotEmpty == true;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '移除选项',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // 仅移除笔记
              if (hasNote)
                ListTile(
                  leading: const Icon(
                    Icons.sticky_note_2_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    '仅移除笔记',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    Navigator.pop(ctx);
                    final targetId = noteId ?? widget.id;
                    if (targetId != null) {
                      final bookId = epubPlayerKey.currentState!.widget.book.id;
                      final noteToUpdate = BookNote(
                        id: targetId,
                        bookId: bookId,
                        cfi: widget.annoCfi,
                        content: widget.annoContent,
                        type: annoType,
                        color: annoColor,
                        readerNote: null, // 清除笔记
                        chapter: epubPlayerKey.currentState!.chapterTitle,
                        createTime: _currentNote?.createTime ?? DateTime.now(),
                        updateTime: DateTime.now(),
                      );

                      await ref
                          .read(bookNoteNotifierProvider(bookId).notifier)
                          .addNote(noteToUpdate);
                      epubPlayerKey.currentState!.addAnnotation(noteToUpdate);

                      // 更新本地状态
                      setState(() {
                        _currentNote = noteToUpdate;
                      });
                    }
                  },
                ),
              // 移除高亮和笔记
              ListTile(
                leading: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
                title: const Text(
                  '移除高亮和笔记',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  final targetId = noteId ?? widget.id;
                  if (targetId != null) {
                    final notifier = ref.read(
                      bookNoteNotifierProvider(
                        epubPlayerKey.currentState!.widget.book.id,
                      ).notifier,
                    );
                    notifier.removeNote(id: targetId);
                    epubPlayerKey.currentState!.removeAnnotation(
                      widget.annoCfi,
                    );
                  }
                  widget.onClose();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // 显示颜色选择对话框
  void _showColorPickerDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2E),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Color list and Underline button in a Row
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Color list
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: notesColors.map((color) {
                      final isSelected =
                          annoColor == color &&
                          _selectedAnnotationType != 'underline';
                      return GestureDetector(
                        onTap: () async {
                          Navigator.pop(ctx);
                          // Set type to highlight if it was underline, or keep current if already highlight
                          final targetType =
                              _selectedAnnotationType == 'underline'
                              ? 'highlight'
                              : (_selectedAnnotationType ?? 'highlight');
                          await onTypeSelected(targetType);
                          await onColorSelected(color);
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Color(int.parse('0xff$color')),
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 3)
                                : null,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : null,
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 12,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 16),
                  // Underline button
                  GestureDetector(
                    onTap: () async {
                      Navigator.pop(ctx);
                      // Toggle underline: if already underline, switch to highlight, else switch to underline
                      final newType = _selectedAnnotationType == 'underline'
                          ? 'highlight'
                          : 'underline';
                      await onTypeSelected(newType);
                      // Use current color
                      await onColorSelected(annoColor);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedAnnotationType == 'underline'
                            ? Color(
                                int.parse('0xff$annoColor'),
                              ).withOpacity(0.3)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedAnnotationType == 'underline'
                              ? Color(int.parse('0xff$annoColor'))
                              : Colors.white54,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Icons.format_underline,
                        color: _selectedAnnotationType == 'underline'
                            ? Color(int.parse('0xff$annoColor'))
                            : Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasNote = _currentNote?.readerNote?.isNotEmpty == true;
    final hasAnnotation = noteId != null || widget.id != null;

    // 深色背景的操作菜单（复制、高亮标记、添加笔记、查询等）
    Widget operatorMenu = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Flex(
        direction: widget.axis,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Copy
          _buildOperatorItem(
            icon: const Icon(Icons.copy, color: Colors.white, size: 20),
            text: '复制',
            onTap: () {
              Clipboard.setData(ClipboardData(text: widget.annoContent));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('已复制')));
              widget.onClose();
            },
          ),
          // Highlight/Annotation button - 点击弹出颜色选择对话框
          if (!widget.footnote)
            _buildOperatorItem(
              icon: Icon(
                Icons.highlight,
                color: const Color(0xFFFFD700),
                size: 20,
              ),
              text: '高亮标记',
              onTap: () async {
                // 如果已经存在标注，则打开颜色选择器以允许修改
                if (hasAnnotation) {
                  _showColorPickerDialog();
                } else {
                  // 如果是新标注，直接使用上次配置立即高亮
                  await onTypeSelected(annoType);
                  await onColorSelected(annoColor);
                  widget.onClose();
                }
              },
            ),
          // Add/Edit Note - 添加笔记按钮
          if (!widget.footnote)
            _buildOperatorItem(
              icon: Icon(
                hasNote ? Icons.sticky_note_2 : Icons.edit_note,
                color: hasNote ? const Color(0xFFFFD700) : Colors.white,
                size: 20,
              ),
              text: hasNote ? '编辑笔记' : '添加笔记',
              onTap: () async {
                // 点击添加笔记时，如果还没有标注，使用上次配置创建标注
                if (noteId == null && widget.id == null) {
                  // 使用上次保存的类型和颜色
                  await onTypeSelected(annoType);
                  await onColorSelected(annoColor);
                }

                // 然后打开笔记编辑界面
                final targetId = noteId ?? widget.id;
                if (targetId != null) {
                  await widget.openReaderNoteMenu(targetId);
                } else {
                  widget.toggleReaderNoteMenu(show: true);
                }
              },
            ),
          // Remove Button - 只在已有标注时才显示
          if (hasAnnotation)
            _buildOperatorItem(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
                size: 20,
              ),
              text: '移除',
              onTap: _showRemoveOptions,
            ),
          // Bookmark - 书摘（暂时不做，但按钮必须存在）
          _buildOperatorItem(
            icon: const Icon(
              Icons.bookmark_border,
              color: Colors.white,
              size: 20,
            ),
            text: '书摘',
            onTap: () {
              // TODO: 实现书摘功能
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('书摘功能开发中...')));
              widget.onClose();
            },
          ),
          // Web search
          _buildOperatorItem(
            icon: const Icon(Icons.search, color: Colors.white, size: 20),
            text: '查询',
            onTap: () {
              widget.onClose();
              launchUrl(
                Uri.parse(
                  'https://www.bing.com/search?q=${widget.annoContent}',
                ),
                mode: LaunchMode.externalApplication,
              );
            },
          ),
        ],
      ),
    );

    // Build children list and reverse if needed
    var innerChildren = <Widget>[
      SingleChildScrollView(scrollDirection: widget.axis, child: operatorMenu),
    ];

    if (widget.reverse) {
      innerChildren = innerChildren.reversed.toList();
    }

    return Expanded(
      child: Flex(
        direction: flipAxis(widget.axis),
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction: flipAxis(widget.axis),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: innerChildren,
          ),
        ],
      ),
    );
  }

  Widget _buildOperatorItem({
    required Icon icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 3),
            Text(
              text,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Show context menu for text selection or annotation click
Future<void> showContextMenu(
  BuildContext context,
  double left,
  double top,
  double right,
  double bottom,
  String annoContent,
  String annoCfi,
  int? annoId,
  bool footnote,
  Axis axis, {
  String? contextText,
}) async {
  final playerKey = epubPlayerKey.currentState;
  if (playerKey == null) return;

  bool isNewNote = false;

  // Auto-highlight logic (optional - can be enabled via settings later)
  // For now, we skip auto-mark and let user choose manually

  final renderBox =
      epubPlayerKey.currentContext?.findRenderObject() as RenderBox?;
  final renderBoxSize = renderBox?.size;

  final mediaQuery = MediaQuery.of(context);
  final double screenHeight = renderBoxSize?.height ?? mediaQuery.size.height;
  final double screenWidth = renderBoxSize?.width ?? mediaQuery.size.width;
  final double keyboardInset = mediaQuery.viewInsets.bottom;

  final Offset localToGlobal =
      renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;

  final viewportRect = Rect.fromLTWH(
    localToGlobal.dx,
    localToGlobal.dy,
    screenWidth,
    screenHeight,
  );

  final selectionRect = Rect.fromLTRB(
    localToGlobal.dx + left * screenWidth,
    localToGlobal.dy + top * screenHeight,
    localToGlobal.dx + right * screenWidth,
    localToGlobal.dy + bottom * screenHeight,
  );

  const double horizontalMargin = 16;
  const double verticalMargin = 16;
  const double gap = 12;

  final double maxMenuWidth = math.min(
    350,
    math.max(120, screenWidth - horizontalMargin * 2),
  );
  final double effectiveHeight = math.max(0, screenHeight - keyboardInset);
  final double maxHeightCandidate = effectiveHeight - verticalMargin * 2;
  final double rawMaxHeight = math.min(
    footnote ? 350 : 550,
    math.max(200, maxHeightCandidate),
  );
  final double maxMenuHeight = math.max(
    0,
    math.min(rawMaxHeight, maxHeightCandidate),
  );

  final menuConstraints = BoxConstraints(
    maxWidth: maxMenuWidth,
    maxHeight: maxMenuHeight,
  );

  final initialPlacement = _resolveMenuPlacement(
    axis: axis,
    selectionRect: selectionRect,
    viewportRect: viewportRect,
    menuSize: Size(maxMenuWidth, maxMenuHeight),
    horizontalMargin: horizontalMargin,
    verticalMargin: verticalMargin,
    gap: gap,
    bottomInset: keyboardInset,
  );

  playerKey.removeOverlay();

  void onClose() {
    playerKey.webViewController.evaluateJavascript(source: 'clearSelection()');
    playerKey.removeOverlay();
  }

  final decoration = BoxDecoration(
    color: const Color(0xFF2C2C2E),
    borderRadius: BorderRadius.circular(12),
  );

  playerKey.contextMenuEntry = OverlayEntry(
    builder: (context) {
      return _ContextMenuOverlay(
        axis: axis,
        selectionRect: selectionRect,
        viewportRect: viewportRect,
        annoContent: annoContent,
        annoCfi: annoCfi,
        annoId: annoId,
        footnote: footnote,
        contextText: contextText,
        decoration: decoration,
        onClose: onClose,
        menuConstraints: menuConstraints,
        initialPlacement: initialPlacement,
        showTranslationDefault: false,
        horizontalMargin: horizontalMargin,
        verticalMargin: verticalMargin,
        gap: gap,
        initialBottomInset: keyboardInset,
      );
    },
  );

  Overlay.of(context).insert(playerKey.contextMenuEntry!);
}

class _MenuPlacement {
  const _MenuPlacement({required this.offset, required this.shouldReverse});

  final Offset offset;
  final bool shouldReverse;
}

double _clampWithin(double value, double min, double max) {
  if (min > max) return min;
  return value.clamp(min, max);
}

_MenuPlacement _resolveMenuPlacement({
  required Axis axis,
  required Rect selectionRect,
  required Rect viewportRect,
  required Size menuSize,
  required double horizontalMargin,
  required double verticalMargin,
  required double gap,
  required double bottomInset,
}) {
  final double menuWidth = menuSize.width;
  final double menuHeight = menuSize.height;

  final double clampedViewportBottom = math.max(
    viewportRect.top,
    viewportRect.bottom - bottomInset,
  );

  if (axis == Axis.horizontal) {
    final double spaceAbove = selectionRect.top - viewportRect.top;
    final double spaceBelow = clampedViewportBottom - selectionRect.bottom;
    final bool placeBelow =
        (spaceBelow >= menuHeight + gap) || (spaceBelow >= spaceAbove);

    final double minTop = viewportRect.top + verticalMargin;
    final double maxTop = clampedViewportBottom - menuHeight - verticalMargin;
    double desiredTop = placeBelow
        ? selectionRect.bottom + gap
        : selectionRect.top - menuHeight - gap;
    desiredTop = _clampWithin(desiredTop, minTop, maxTop);

    final double minLeft = viewportRect.left + horizontalMargin;
    final double maxLeft = viewportRect.right - menuWidth - horizontalMargin;
    double desiredLeft = selectionRect.center.dx - menuWidth / 2;
    desiredLeft = _clampWithin(desiredLeft, minLeft, maxLeft);

    return _MenuPlacement(
      offset: Offset(desiredLeft, desiredTop),
      shouldReverse: !placeBelow,
    );
  }

  final double spaceLeft = selectionRect.left - viewportRect.left;
  final double spaceRight = viewportRect.right - selectionRect.right;
  final bool placeRight =
      (spaceRight >= menuWidth + gap) || (spaceRight >= spaceLeft);

  final double minLeft = viewportRect.left + horizontalMargin;
  final double maxLeft = viewportRect.right - menuWidth - horizontalMargin;
  double desiredLeft = placeRight
      ? selectionRect.right + gap
      : selectionRect.left - menuWidth - gap;
  desiredLeft = _clampWithin(desiredLeft, minLeft, maxLeft);

  final double minTop = viewportRect.top + verticalMargin;
  final double maxTop = clampedViewportBottom - menuHeight - verticalMargin;
  double desiredTop = selectionRect.center.dy - menuHeight / 2;
  desiredTop = _clampWithin(desiredTop, minTop, maxTop);

  return _MenuPlacement(
    offset: Offset(desiredLeft, desiredTop),
    shouldReverse: !placeRight,
  );
}

Axis flipAxis(Axis axis) =>
    axis == Axis.horizontal ? Axis.vertical : Axis.horizontal;

class _ContextMenuOverlay extends StatefulWidget {
  const _ContextMenuOverlay({
    required this.axis,
    required this.selectionRect,
    required this.viewportRect,
    required this.annoContent,
    required this.annoCfi,
    required this.annoId,
    required this.footnote,
    this.contextText,
    required this.decoration,
    required this.onClose,
    required this.menuConstraints,
    required this.initialPlacement,
    required this.showTranslationDefault,
    required this.horizontalMargin,
    required this.verticalMargin,
    required this.gap,
    required this.initialBottomInset,
  });

  final Axis axis;
  final Rect selectionRect;
  final Rect viewportRect;
  final String annoContent;
  final String annoCfi;
  final int? annoId;
  final bool footnote;
  final String? contextText;
  final BoxDecoration decoration;
  final VoidCallback onClose;
  final BoxConstraints menuConstraints;
  final _MenuPlacement initialPlacement;
  final bool showTranslationDefault;
  final double horizontalMargin;
  final double verticalMargin;
  final double gap;
  final double initialBottomInset;

  @override
  State<_ContextMenuOverlay> createState() => _ContextMenuOverlayState();
}

class _ContextMenuOverlayState extends State<_ContextMenuOverlay>
    with WidgetsBindingObserver {
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey<ReaderNoteMenuState> _readerNoteMenuKey =
      GlobalKey<ReaderNoteMenuState>();

  late Offset _position;
  late bool _reverse;
  bool _showReaderNoteMenu = false;
  bool _waitingForFirstMeasurement = true;
  late BoxConstraints _menuConstraints;
  late double _bottomInset;
  int? _noteId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _position = widget.initialPlacement.offset;
    _reverse = widget.initialPlacement.shouldReverse;
    _noteId = widget.annoId;
    _bottomInset = widget.initialBottomInset;
    _menuConstraints = _buildConstraints(widget.initialBottomInset);
    _scheduleRecalculate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    epubPlayerKey.currentState?.setSelectionClearLocked(false);
    super.dispose();
  }

  BoxConstraints _buildConstraints(double bottomInset) {
    final original = widget.menuConstraints;
    final double availableHeight = math.max(
      0,
      widget.viewportRect.height - bottomInset - widget.verticalMargin * 2,
    );

    double maxHeight;
    if (original.hasBoundedHeight) {
      maxHeight = math.min(original.maxHeight, availableHeight);
    } else {
      maxHeight = availableHeight;
    }
    maxHeight = math.max(0, maxHeight);

    final double minHeight = math.min(original.minHeight, maxHeight);

    return BoxConstraints(
      minWidth: original.minWidth,
      maxWidth: original.maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }

  void _scheduleRecalculate({Duration delay = Duration.zero}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (delay == Duration.zero) {
        _updatePlacement();
      } else {
        Future.delayed(delay, () {
          if (!mounted) return;
          _updatePlacement();
        });
      }
    });
  }

  @override
  void didChangeMetrics() {
    if (!mounted) return;
    _scheduleRecalculate();
  }

  void _updatePlacement() {
    final renderBox = _menuKey.currentContext?.findRenderObject() as RenderBox?;
    final double currentBottomInset = MediaQuery.of(context).viewInsets.bottom;
    final newConstraints = _buildConstraints(currentBottomInset);

    if (renderBox == null) {
      final bool needsStateUpdate =
          (_bottomInset - currentBottomInset).abs() > 0.5 ||
          _menuConstraints.maxHeight != newConstraints.maxHeight;

      if (needsStateUpdate) {
        setState(() {
          _bottomInset = currentBottomInset;
          _menuConstraints = newConstraints;
        });
      }
      return;
    }

    final size = renderBox.size;
    final placement = _resolveMenuPlacement(
      axis: widget.axis,
      selectionRect: widget.selectionRect,
      viewportRect: widget.viewportRect,
      menuSize: size,
      horizontalMargin: widget.horizontalMargin,
      verticalMargin: widget.verticalMargin,
      gap: widget.gap,
      bottomInset: currentBottomInset,
    );

    final bool positionChanged =
        (_position.dx - placement.offset.dx).abs() > 0.5 ||
        (_position.dy - placement.offset.dy).abs() > 0.5;

    final bool bottomInsetChanged =
        (_bottomInset - currentBottomInset).abs() > 0.5;
    final bool constraintsChanged =
        _menuConstraints.maxHeight != newConstraints.maxHeight;

    final bool shouldUpdate =
        _waitingForFirstMeasurement ||
        positionChanged ||
        _reverse != placement.shouldReverse ||
        bottomInsetChanged ||
        constraintsChanged;

    if (shouldUpdate) {
      setState(() {
        _position = placement.offset;
        _reverse = placement.shouldReverse;
        _bottomInset = currentBottomInset;
        _menuConstraints = newConstraints;
        _waitingForFirstMeasurement = false;
      });
    }
  }

  void _toggleReaderNoteMenu({bool? show}) {
    final target = show ?? !_showReaderNoteMenu;
    epubPlayerKey.currentState?.setSelectionClearLocked(target);
    setState(() {
      _showReaderNoteMenu = target;
    });
    _scheduleRecalculate(
      delay: _showReaderNoteMenu
          ? const Duration(milliseconds: 300)
          : Duration.zero,
    );
  }

  Future<void> _openReaderNoteMenu(int noteId) async {
    _toggleReaderNoteMenu(show: true);
    if (_readerNoteMenuKey.currentState == null) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    await _readerNoteMenuKey.currentState?.showNoteDialog(noteId);
    _scheduleRecalculate(delay: const Duration(milliseconds: 300));
  }

  void _handleNoteCreated(int noteId) {
    if (_noteId == noteId) return;
    setState(() {
      _noteId = noteId;
    });
  }

  void _handleReaderNoteVisibilityChange(bool visible) {
    epubPlayerKey.currentState?.setSelectionClearLocked(visible);
    if (_showReaderNoteMenu == visible) return;
    setState(() {
      _showReaderNoteMenu = visible;
    });
    _scheduleRecalculate(
      delay: visible ? const Duration(milliseconds: 300) : Duration.zero,
    );
  }

  void _handleReaderNoteSizeChanged() {
    _scheduleRecalculate();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onTap: widget.onClose,
        child: IgnorePointer(
          ignoring: _waitingForFirstMeasurement,
          child: Opacity(
            opacity: _waitingForFirstMeasurement ? 0 : 1,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                key: _menuKey,
                color: Colors.transparent,
                constraints: _menuConstraints,
                child: _buildFlexContent(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFlexContent() {
    final children = <Widget>[
      Flex(
        direction: flipAxis(widget.axis),
        mainAxisSize: MainAxisSize.min,
        children: [
          Flex(
            direction: widget.axis,
            mainAxisSize: MainAxisSize.min,
            children: [
              ExcerptMenu(
                annoCfi: widget.annoCfi,
                annoContent: widget.annoContent,
                id: widget.annoId,
                onClose: widget.onClose,
                footnote: widget.footnote,
                decoration: widget.decoration,
                toggleReaderNoteMenu: _toggleReaderNoteMenu,
                openReaderNoteMenu: _openReaderNoteMenu,
                onNoteCreated: _handleNoteCreated,
                axis: widget.axis,
                reverse: _reverse,
              ),
            ],
          ),
        ],
      ),
      if (_showReaderNoteMenu) ...[
        const SizedBox.square(dimension: 10),
        Flex(
          direction: widget.axis,
          mainAxisSize: MainAxisSize.min,
          children: [
            ReaderNoteMenu(
              key: _readerNoteMenuKey,
              noteId: _noteId,
              decoration: widget.decoration,
              axis: widget.axis,
              onVisibilityChange: _handleReaderNoteVisibilityChange,
              onSizeChanged: _handleReaderNoteSizeChanged,
            ),
          ],
        ),
      ],
    ];

    // Apply reverse by reversing the list if needed
    final finalChildren = _reverse ? children.reversed.toList() : children;

    return Flex(
      direction: flipAxis(widget.axis),
      mainAxisSize: MainAxisSize.min,
      children: finalChildren,
    );
  }
}
