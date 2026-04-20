import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/providers/bookshelf_provider.dart';
import 'package:i_reader/providers/service_registry.dart';
import 'package:i_reader/ui/pages/bookshelf/widgets/bookshelf_add_book_sheet.dart';
import 'package:i_reader/ui/pages/bookshelf/widgets/bookshelf_body.dart';
import 'package:i_reader/ui/pages/bookshelf/widgets/bookshelf_header.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';

class BookshelfPage extends ConsumerStatefulWidget {
  const BookshelfPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookshelfState();
}

class _BookshelfState extends ConsumerState<BookshelfPage>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  bool _isDialogShowing = false; // 防止对话框重复打开

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: HomePageBackground(
        glowColors: const [Color(0xFF4F7CFF), Color(0xFF7C5CFF)],
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              BookshelfHeader(
                onSearch: () {},
                onSync: () {},
                onMenuSelected: _handleMenuAction,
              ),
              Expanded(child: _buildBody()),
            ],
          ),
        ),
      ),
    );
  }

  void _handleMenuAction(String value) {
    // 防护：如果对话框已显示，直接返回
    if (_isDialogShowing) {
      return;
    }

    switch (value) {
      case 'add_local':
        _pickAndImportBooks();
        break;
      default:
        return;
    }
  }

  /// 文件选择和导入的完整流程
  Future<void> _pickAndImportBooks() async {
    if (!mounted) return;

    // Step 1: 显示加载对话框并选择文件
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final orchestrator = ref.read(AppServices.bookImportOrchestrator);
      final selectedFiles = await orchestrator.selectFiles();

      if (!mounted) return;
      context.pop();

      if (selectedFiles.isEmpty) {
        _showSnackBar('未选择文件');
        return;
      }

      // Step 2: 检查和分类文件
      _showCheckingDialog();

      final checkResult = await orchestrator.checkAndCategorizeFiles(
        selectedFiles,
      );

      if (!mounted) return;
      context.pop();

      // Step 3: 显示导入对话框
      _showImportDialog(
        checkResult['supportedFiles'] ?? [],
        checkResult['unsupportedFiles'] ?? [],
        checkResult['uniqueFiles'] ?? [],
        checkResult['duplicateFiles'] ?? [],
        checkResult['duplicateInfo'] ?? {},
      );
    } catch (e) {
      if (mounted) {
        context.pop();
        _showSnackBar('导入异常: $e');
      }
    }
  }

  void _showCheckingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        title: Text("计算MD5"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("MD5计算中..."),
          ],
        ),
      ),
    );
  }

  void _showImportDialog(
    List<File> supportedFiles,
    List<File> unsupportedFiles,
    List<File> uniqueFiles,
    List<File> duplicateFiles,
    Map<String, dynamic> duplicateInfo,
  ) {
    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BookshelfAddBookSheet(
        supportedFiles: supportedFiles,
        unsupportedFiles: unsupportedFiles,
        uniqueFiles: uniqueFiles,
        duplicateFiles: duplicateFiles,
        duplicateInfo: duplicateInfo.cast(),
      ),
    ).then((_) {
      _isDialogShowing = false;
      // 导入完成后刷新书架
      _reloadBookshelf();
    });
  }

  Widget _buildBody() {
    return BookshelfBody(
      scrollController: _scrollController,
      onReload: (showLoading) => _reloadBookshelf(showLoading),
    );
  }

  Future<void> _reloadBookshelf([bool showLoading = false]) {
    return ref
        .read(bookshelfBooksProvider.notifier)
        .reload(showLoading: showLoading);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
