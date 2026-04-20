import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/providers/bookshelf_provider.dart';
import 'package:i_reader/providers/service_registry.dart';
import 'package:i_reader/ui/pages/bookshelf/widgets/bookshelf_add_book_sheet.dart';
import 'package:i_reader/ui/pages/bookshelf/widgets/bookshelf_empty_state.dart';
import 'package:i_reader/ui/widgets/book_cover.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';

class BookshelfPage extends ConsumerStatefulWidget {
  const BookshelfPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookshelfState();
}

class _BookshelfState extends ConsumerState<BookshelfPage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  Widget _buildBookshelfHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '书架',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: HomePalette.primaryText(context),
                  ),
                ),
              ),
              _buildHeaderActionButton(
                icon: Icons.search_rounded,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _buildHeaderActionButton(icon: Icons.cloud_sync, onTap: () {}),
              const SizedBox(width: 10),
              PopupMenuButton<String>(
                padding: EdgeInsetsGeometry.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                position: PopupMenuPosition.under,
                onSelected: _handleMenuAction,
                itemBuilder: (context) => [
                  _buildPopupMenuItem(
                    "add_local",
                    Icons.add_box_outlined,
                    "添加本地",
                  ),
                  _buildPopupMenuItem(
                    "add_remote",
                    Icons.download_outlined,
                    "添加远程",
                  ),
                  _buildPopupMenuItem("sort_book", Icons.sort_outlined, "书籍排序"),
                ],
                child: IgnorePointer(
                  child: _buildHeaderActionButton(
                    icon: Icons.more_horiz_rounded,
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String value) {
    switch (value) {
      case 'add_local':
        _pickLocalBooks();
        break;
      default:
        return;
    }
  }

  Future<void> _pickLocalBooks() async {
    if (!mounted) return;

    // 显示加载对话框
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final bookService = readService(AppServices.localBookService);
      final books = await bookService.pickLocalFiles();

      if (!mounted) return;
      // 使用 go_router 的 context.pop() 关闭对话框
      context.pop();

      if (books.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('未选择文件或导入失败')));
        return;
      }

      checkDuplicatesAndShowDialog(books, context, ref);
    } catch (e) {
      if (mounted) {
        context.pop(); // 发生错误也确保关闭对话框
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('导入异常: $e')));
      }
    }
  }

  void checkDuplicatesAndShowDialog(
    List<File> fileList,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final allowBookExtensions = ["epub", "mobi", "azw3", "fb2", "pdf"];
    List<File> supportedFiles = fileList.where((file) {
      return allowBookExtensions.contains(
        file.path.split('.').last.toLowerCase(),
      );
    }).toList();

    List<File> unsupportedFiles = fileList.where((file) {
      return !allowBookExtensions.contains(
        file.path.split('.').last.toLowerCase(),
      );
    }).toList();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("计算MD5"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("MD5计算中..."),
          ],
        ),
      ),
    );

    try {
      final filePaths = supportedFiles.map((f) => f.path).toList();
      final checkResults = await readService(
        AppServices.md5Service,
      ).checkImportFiles(filePaths);

      if (!mounted) return;
      context.pop(); // 关闭 MD5 计算对话框

      List<File> duplicateFiles = [];
      List<File> uniqueFiles = [];
      Map<String, Book> duplicateInfo = {};

      for (int i = 0; i < supportedFiles.length; i++) {
        final file = supportedFiles[i];
        final result = checkResults[i];

        if (result.isDuplicate && result.duplicateBook != null) {
          duplicateFiles.add(file);
          duplicateInfo[file.path] = result.duplicateBook!;
        } else {
          uniqueFiles.add(file);
        }
      }

      _showAddBookDialog(
        supportedFiles,
        unsupportedFiles,
        uniqueFiles,
        duplicateFiles,
        duplicateInfo,
      );
    } catch (e) {
      if (mounted) {
        context.pop(); // 失败时关闭对话框
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('分析失败: $e')));
      }
    }
  }

  void _showAddBookDialog(
    List<File> supportedFiles,
    List<File> unsupportedFiles,
    List<File> uniqueFiles,
    List<File> duplicateFiles,
    Map<String, Book> duplicateInfo,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BookshelfAddBookSheet(
        supportedFiles: supportedFiles,
        unsupportedFiles: unsupportedFiles,
        uniqueFiles: uniqueFiles,
        duplicateFiles: duplicateFiles,
        duplicateInfo: duplicateInfo,
        ref: ref,
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    IconData icon,
    String text,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildHeaderActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: HomePalette.mutedCard(context),
            shape: BoxShape.circle,
            border: Border.all(color: HomePalette.lineColor(context)),
          ),
          child: Icon(icon, size: 22, color: HomePalette.primaryText(context)),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bookShelfAsync = ref.watch(bookshelfBooksProvider);
    return bookShelfAsync.when(
      data: (books) {
        if (books.isEmpty) {
          return _buildEmptyState();
        }
        return _buildBooksList(books);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('加载失败: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _reloadBookshelf(showLoading: true);
              },
              child: const Text('重试'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reloadBookshelf({bool showLoading = false}) {
    return ref
        .read(bookshelfBooksProvider.notifier)
        .reload(showLoading: showLoading);
  }

  Widget _buildBooksList(List<Book> books) {
    List<int> lockedIndices = [];
    for (int i = 0; i < books.length; i++) {
      // folder can't be dragged
      lockedIndices.add(i);
    }
    return ReorderableBuilder(
      enableDraggable: false,
      lockedIndices: lockedIndices,
      scrollController: _scrollController,
      children: [
        for (final book in books)
          BookCover(key: ValueKey(book.id.toString()), book: book),
      ],
      builder: (children) => LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = (constraints.maxWidth / 120).floor();
          crossAxisCount = crossAxisCount.clamp(2, 8);
          return Expanded(
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 32,
                crossAxisSpacing: 24,
                childAspectRatio: 0.7,
              ),
              itemCount: children.length,
              itemBuilder: (context, index) => children[index],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: HomeSectionCard(
          margin: EdgeInsets.zero,
          child: BookshelfEmptyState(
            onSearchOnline: () {},
            onImportLocal: () {},
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: HomePageBackground(
        glowColors: const [Color(0xFF4F7CFF), Color(0xFF7C5CFF)],
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildBookshelfHeader(context),
              Expanded(child: _buildBody(context)),
            ],
          ),
        ),
      ),
    );
  }
}
