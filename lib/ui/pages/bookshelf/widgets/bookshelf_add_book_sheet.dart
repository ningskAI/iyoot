import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/providers/service_registry.dart';
import 'package:i_reader/ui/widgets/td/td_themed_toast.dart';
import 'package:i_reader/utils/app_log.dart';
import 'package:path/path.dart' as path;
import 'package:tdesign_flutter/tdesign_flutter.dart';

/// 添加书籍底部弹层
class BookshelfAddBookSheet extends StatefulWidget {
  const BookshelfAddBookSheet({
    super.key,
    required this.uniqueFiles,
    required this.supportedFiles,
    required this.unsupportedFiles,
    required this.duplicateFiles,
    required this.duplicateInfo,
    required this.ref,
  });

  final List<File> uniqueFiles;
  final List<File> unsupportedFiles;
  final List<File> duplicateFiles;
  final List<File> supportedFiles;
  final Map<String, Book> duplicateInfo;
  final WidgetRef ref;

  @override
  State<StatefulWidget> createState() => _BookshelfAddBookSheet();
}

class _BookshelfAddBookSheet extends State<BookshelfAddBookSheet> {
  String currentHandlingFile = '';
  List<String> errorFiles = [];
  bool finished = false;
  bool skipDuplicates = true;
  Map<String, String> errorMessages = {};
  @override
  void initState() {
    super.initState();
  }

  Widget bookItem(
    BuildContext context,
    String filePath,
    Widget icon, {
    bool isDuplicate = false,
    String? duplicateTitle,
    String? errorMessage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 24, height: 24, child: icon),
            Expanded(
              child: Text(
                path.basename(filePath),
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            if (errorMessage != null)
              IconButton(
                icon: const Icon(Icons.info_outline, size: 16),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("错误"),
                      content: SelectableText(errorMessage),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("好"),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
        if (isDuplicate && duplicateTitle != null)
          Padding(
            padding: const EdgeInsets.only(left: 28, top: 2),
            child: Text(
              "与以下文件重复: ${duplicateTitle}",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        if (errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(left: 28, top: 2),
            child: Text(
              'Error: ${errorMessage.length > 50 ? "${errorMessage.substring(0, 50)}..." : errorMessage}',
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('添加${widget.supportedFiles.length}本书籍'),
      contentPadding: const EdgeInsets.all(16),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            const Text(
              '支持epub/mobi/azw3/fb2/txt/pdf',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xFF86909C),
              ),
            ),
            const SizedBox(height: 18),
            for (var file in widget.uniqueFiles)
              file.path == currentHandlingFile
                  ? bookItem(
                      context,
                      file.path,
                      Container(
                        padding: const EdgeInsets.all(3),
                        width: 20,
                        height: 20,
                        child: const CircularProgressIndicator(),
                      ),
                    )
                  : bookItem(
                      context,
                      file.path,
                      errorFiles.contains(file.path)
                          ? const Icon(Icons.error)
                          : const Icon(Icons.done),
                      errorMessage: errorFiles.contains(file.path)
                          ? errorMessages[file.path]
                          : null,
                    ),
            // show unsupported files
            if (widget.unsupportedFiles.isNotEmpty) ...[
              Divider(),
              SizedBox(height: 10),
              Text("${widget.unsupportedFiles.length}本书暂不支持"),
            ],
            for (var file in widget.unsupportedFiles)
              bookItem(context, file.path, const Icon(Icons.error)),

            // show duplicate files
            if (widget.duplicateFiles.isNotEmpty) ...[
              Divider(),
              const SizedBox(height: 10),
              Text("重复文件"),
            ],
            for (var file in widget.duplicateFiles)
              if (skipDuplicates)
                bookItem(
                  context,
                  file.path,
                  const Icon(Icons.double_arrow_rounded),
                  isDuplicate: true,
                  duplicateTitle: widget.duplicateInfo[file.path]?.title,
                )
              else
                file.path == currentHandlingFile
                    ? bookItem(
                        context,
                        file.path,
                        Container(
                          padding: const EdgeInsets.all(3),
                          width: 20,
                          height: 20,
                          child: const CircularProgressIndicator(),
                        ),
                        isDuplicate: true,
                        duplicateTitle: widget.duplicateInfo[file.path]?.title,
                      )
                    : bookItem(
                        context,
                        file.path,
                        errorFiles.contains(file.path)
                            ? const Icon(Icons.error)
                            : const Icon(Icons.done),
                        isDuplicate: true,
                        duplicateTitle: widget.duplicateInfo[file.path]?.title,
                        errorMessage: errorFiles.contains(file.path)
                            ? errorMessages[file.path]
                            : null,
                      ),

            // select skip duplicates
            if (widget.duplicateFiles.isNotEmpty) ...[
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: skipDuplicates,
                    onChanged: (value) {
                      setState(() {
                        skipDuplicates = value ?? true;
                      });
                    },
                  ),
                  Expanded(child: Text("跳过重复文件")),
                ],
              ),
            ],

            const SizedBox(height: 20),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            for (var file in widget.supportedFiles) {
              file.deleteSync();
            }
          },
          child: Text("取消"),
        ),
        if (widget.uniqueFiles.isNotEmpty ||
            (widget.duplicateFiles.isNotEmpty && !skipDuplicates))
          TextButton(
            onPressed: () async {
              if (finished) {
                Navigator.of(context).pop('dialog');
                return;
              }

              List<File> filesToImport = [...widget.uniqueFiles];
              if (!skipDuplicates) {
                filesToImport.addAll(widget.duplicateFiles);
              }

              for (var file in filesToImport) {
                setState(() {
                  currentHandlingFile = file.path;
                });
                try {
                  await readService(
                    AppServices.localBookService,
                  ).importBook(file, widget.ref);
                } catch (e, stackTrace) {
                  AppLog.instance.put('Failed to import ${file.path}: $e');
                  AppLog.instance.put('Stack trace: $stackTrace');
                  setState(() {
                    errorFiles.add(file.path);
                    errorMessages[file.path] = e.toString();
                  });
                }
              }

              // dumplicateFiles will be deleted if skipDuplicates is true
              // if skipDuplicates is false, they will be imported
              // and then deleted in the importBook function
              if (skipDuplicates) {
                for (var file in widget.duplicateFiles) {
                  file.deleteSync();
                }
              }

              setState(() {
                finished = true;
              });
            },
            child: Text(
              finished
                  ? "确定"
                  : "导入 ${widget.uniqueFiles.length + (skipDuplicates ? 0 : widget.duplicateFiles.length) - errorFiles.length}本书",
            ),
          ),
      ],
    );
  }
}
