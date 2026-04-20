import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/providers/bookshelf_import_provider.dart';
import 'package:i_reader/utils/app_log.dart';
import 'package:path/path.dart' as path;

/// 导入底部弹层 - 使用Riverpod管理状态，职责清晰
class BookshelfAddBookSheet extends ConsumerWidget {
  const BookshelfAddBookSheet({
    super.key,
    required this.supportedFiles,
    required this.unsupportedFiles,
    required this.uniqueFiles,
    required this.duplicateFiles,
    required this.duplicateInfo,
  });

  final List<File> supportedFiles;
  final List<File> unsupportedFiles;
  final List<File> uniqueFiles;
  final List<File> duplicateFiles;
  final Map<String, Book> duplicateInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progress = ref.watch(importProgressProvider);
    final skipDuplicates = ref.watch(_skipDuplicatesProvider);

    return AlertDialog(
      title: Text('添加${supportedFiles.length}本书籍'),
      contentPadding: const EdgeInsets.all(16),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            const Text(
              '支持epub/mobi/azw3/fb2/pdf',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xFF86909C),
              ),
            ),
            const SizedBox(height: 18),
            _buildFilesList(context, ref, progress, skipDuplicates),
            const SizedBox(height: 20),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _cleanup();
            Navigator.pop(context);
          },
          child: const Text("取消"),
        ),
        if (uniqueFiles.isNotEmpty ||
            (duplicateFiles.isNotEmpty && !skipDuplicates))
          TextButton(
            onPressed: progress.isImporting
                ? null
                : () => _handleImport(context, ref, skipDuplicates),
            child: Text(
              progress.completedFiles.isEmpty && !progress.isImporting
                  ? "导入 ${uniqueFiles.length + (skipDuplicates ? 0 : duplicateFiles.length)}本书"
                  : progress.isImporting
                  ? "导入中..."
                  : "确定",
            ),
          ),
      ],
    );
  }

  Widget _buildFilesList(
    BuildContext context,
    WidgetRef ref,
    ImportProgressState progress,
    bool skipDuplicates,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 支持的文件
        ...uniqueFiles.map(
          (file) => _buildFileItem(context, file.path, progress),
        ),

        // 不支持的文件
        if (unsupportedFiles.isNotEmpty) ...[
          const Divider(),
          const SizedBox(height: 10),
          Text("${unsupportedFiles.length}本书暂不支持"),
          ...unsupportedFiles.map(
            (file) => _buildFileItem(
              context,
              file.path,
              progress,
              isUnsupported: true,
            ),
          ),
        ],

        // 重复的文件
        if (duplicateFiles.isNotEmpty) ...[
          const Divider(),
          const SizedBox(height: 10),
          const Text("重复文件"),
          if (skipDuplicates)
            ...duplicateFiles.map(
              (file) => _buildFileItem(
                context,
                file.path,
                progress,
                isDuplicate: true,
                duplicateTitle: duplicateInfo[file.path]?.title,
                isSkipped: skipDuplicates,
              ),
            )
          else
            ...duplicateFiles.map(
              (file) => _buildFileItem(
                context,
                file.path,
                progress,
                isDuplicate: true,
                duplicateTitle: duplicateInfo[file.path]?.title,
              ),
            ),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: skipDuplicates,
                onChanged: (value) {
                  ref.read(_skipDuplicatesProvider.notifier).state =
                      value ?? true;
                },
              ),
              const Expanded(child: Text("跳过重复文件")),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildFileItem(
    BuildContext context,
    String filePath,
    ImportProgressState progress, {
    bool isUnsupported = false,
    bool isDuplicate = false,
    String? duplicateTitle,
    bool isSkipped = false,
  }) {
    final isProcessing =
        progress.currentFile == filePath && progress.isImporting;
    final isCompleted = progress.completedFiles.contains(filePath);
    final hasError = progress.errorFiles.contains(filePath);
    final errorMsg = progress.errorMessages[filePath];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildStatusIcon(
              isProcessing,
              isCompleted,
              hasError,
              isUnsupported,
              isSkipped,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                path.basename(filePath),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  overflow: TextOverflow.ellipsis,
                  color: isSkipped ? Colors.grey : Colors.black,
                ),
              ),
            ),
            if (hasError && errorMsg != null)
              IconButton(
                icon: const Icon(Icons.info_outline, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("错误"),
                      content: SelectableText(errorMsg),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("好"),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
        if (isDuplicate && duplicateTitle != null && !isSkipped)
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 2),
            child: Text(
              "与以下文件重复: $duplicateTitle",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        if (hasError && errorMsg != null)
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 2),
            child: Text(
              'Error: ${errorMsg.length > 50 ? "${errorMsg.substring(0, 50)}..." : errorMsg}',
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
        if (isCompleted)
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 2),
            child: Text(
              '已导入',
              style: TextStyle(fontSize: 10, color: Colors.green.shade600),
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildStatusIcon(
    bool isProcessing,
    bool isCompleted,
    bool hasError,
    bool isUnsupported,
    bool isSkipped,
  ) {
    if (isProcessing) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    if (hasError) {
      return SizedBox(
        width: 24,
        height: 24,
        child: Icon(Icons.error, color: Colors.red, size: 24),
      );
    }
    if (isUnsupported) {
      return SizedBox(
        width: 24,
        height: 24,
        child: Icon(Icons.not_interested, color: Colors.grey, size: 24),
      );
    }
    if (isSkipped) {
      return SizedBox(
        width: 24,
        height: 24,
        child: Icon(Icons.skip_next, color: Colors.grey, size: 24),
      );
    }
    if (isCompleted) {
      return SizedBox(width: 24, height: 24);
    }
    return const SizedBox(width: 24, height: 24);
  }

  Future<void> _handleImport(
    BuildContext context,
    WidgetRef ref,
    bool skipDuplicates,
  ) async {
    AppLog.instance.put('🔍 _handleImport start');

    // 防护：检查是否已经在导入中
    final currentState = ref.read(importProgressProvider);
    if (currentState.isImporting) {
      AppLog.instance.put('⚠️ Already importing, return');
      return;
    }

    List<File> filesToImport = [...uniqueFiles];
    if (!skipDuplicates) {
      filesToImport.addAll(duplicateFiles);
    }

    AppLog.instance.put(
      '📦 Importing ${filesToImport.length} files, skipDuplicates=$skipDuplicates',
    );

    try {
      AppLog.instance.put('⏳ Calling importBooks...');
      await ref
          .read(importProgressProvider.notifier)
          .importBooks(filesToImport: filesToImport);
      AppLog.instance.put('✓ importBooks completed');
    } catch (e) {
      AppLog.instance.put('❌ Import error: $e');
      return;
    }

    if (context.mounted) {
      AppLog.instance.put('🚪 Closing dialog');
      Navigator.pop(context);
    }
  }

  void _cleanup() {
    // 清理临时文件
    for (var file in supportedFiles) {
      try {
        file.deleteSync();
      } catch (_) {}
    }
  }
}

final _skipDuplicatesProvider = StateProvider<bool>((ref) => true);
