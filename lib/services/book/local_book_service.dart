import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:i_reader/core/base/base_service.dart';
import 'package:i_reader/core/webview/generate_url.dart';
import 'package:i_reader/core/webview/td_headless_webview.dart';
import 'package:i_reader/data/datasources/impl/book_datasource_impl.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/providers/service_registry.dart';
import 'package:i_reader/ui/pages/root/root.dart';
import 'package:i_reader/utils/app_log.dart';
import 'package:i_reader/utils/file_utils.dart';
import 'package:i_reader/utils/platform.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

TDHeadlessWebView? headlessInAppWebView;

class LocalBookService extends BaseService {
  static final LocalBookService instance = LocalBookService._init();
  LocalBookService._init();

  static const List<String> supportedExtensions = [
    "epub",
    "mobi",
    "azw3",
    "fb2",
    "pdf",
  ];

  Future<List<File>> pickLocalFiles({List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions ?? supportedExtensions,
        allowMultiple: true,
      );
      if (result == null || result.files.isEmpty) {
        return [];
      }
      List<PlatformFile> results = result.files;
      AppLog.instance.putDebug('pickLocalFiles files: ${results.toString()}');
      List<File> fileList = [];
      if (!kIsAndroid) {
        fileList = await Future.wait(
          results.map((file) async {
            return _copyToTempFile(sourcePath: file.path!, fileName: file.name);
          }).toList(),
        );
      } else {
        fileList = results.map((file) => File(file.path!)).toList();
      }
      return fileList;
    } catch (e) {
      rethrow;
    }
  }

  /// 检查并分类导入文件 - 职责单一：只做文件检查分类
  Future<Map<String, dynamic>> checkImportFilesAdvanced(
    List<File> fileList,
  ) async {
    // 分类：支持和不支持
    final supportedFiles = _filterSupportedFiles(fileList);
    final unsupportedFiles = _filterUnsupportedFiles(fileList);

    // 检查重复
    final filePaths = supportedFiles.map((f) => f.path).toList();
    final checkResults = await readService(
      AppServices.md5Service,
    ).checkImportFiles(filePaths);

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

    return {
      'supportedFiles': supportedFiles,
      'unsupportedFiles': unsupportedFiles,
      'uniqueFiles': uniqueFiles,
      'duplicateFiles': duplicateFiles,
      'duplicateInfo': duplicateInfo,
    };
  }

  List<File> _filterSupportedFiles(List<File> files) {
    return files.where((file) {
      final ext = file.path.split('.').last.toLowerCase();
      return supportedExtensions.contains(ext);
    }).toList();
  }

  List<File> _filterUnsupportedFiles(List<File> files) {
    return files.where((file) {
      final ext = file.path.split('.').last.toLowerCase();
      return !supportedExtensions.contains(ext);
    }).toList();
  }

  Future<File> _copyToTempFile({
    required String sourcePath,
    required String fileName,
  }) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath = p.join(tempDir.path, fileName);
    final targetFile = File(targetPath);
    if (await targetFile.exists()) {
      await targetFile.delete();
    }
    return File(sourcePath).copy(targetPath);
  }

  Future<void> importBook(File file) async {
    try {
      AppLog.instance.put('📌 importBook start: ${file.path}');

      String? md5 = await readService(
        AppServices.md5Service,
      ).calculateFileMd5(file.path);

      AppLog.instance.put('✓ MD5 calculated: $md5');

      await getBookMetadata(file, md5: md5);

      AppLog.instance.put('✓ Metadata extracted');
      AppLog.instance.put('✓ importBook complete');
    } catch (e, st) {
      AppLog.instance.put('❌ importBook error: $e');
      AppLog.instance.put('Stack: $st');
      rethrow;
    }
  }

  Future<void> getBookMetadata(File file, {Book? book, String? md5}) async {
    final server = readService(AppServices.webserviceManager);
    String serverFileName = await server.setTempFile(file);

    String cfi = '';

    String bookUrl = "http://127.0.0.1:${server.port}/$serverFileName";
    AppLog.instance.put("import start: book url: $bookUrl");

    late Completer<void> webviewCompleter;

    TDHeadlessWebView webview = TDHeadlessWebView(
      webViewEnvironment: webViewEnvironment,
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        useShouldInterceptAjaxRequest: false,
        useShouldInterceptFetchRequest: false,
        useOnLoadResource: false,
        useShouldOverrideUrlLoading: false,
        mediaPlaybackRequiresUserGesture: false,
        allowFileAccessFromFileURLs: true,
        allowUniversalAccessFromFileURLs: true,
      ),
      initialUrlRequest: URLRequest(
        url: WebUri(generateUrl(bookUrl, cfi, importing: true)),
      ),
      onWebViewCreated: (controller) {
        webviewCompleter = Completer<void>();
        controller.addJavaScriptHandler(
          handlerName: 'onMetadata',
          callback: (args) async {
            try {
              AppLog.instance.put('onMetadata called: $args');
              Map<String, dynamic> metadata = args[0];
              String title = metadata['title'] ?? 'Unknown';
              dynamic authorData = metadata['author'];
              String author = authorData is String
                  ? authorData
                  : authorData
                            ?.map(
                              (author) =>
                                  author is String ? author : author['name'],
                            )
                            ?.join(', ') ??
                        'Unknown';

              // base64 cover
              String cover = metadata['cover'] ?? '';
              String description = metadata['description'] ?? '';
              await saveBook(
                file,
                title,
                author,
                description,
                md5,
                cover,
                provideBook: book,
              );
              AppLog.instance.put('✓ saveBook complete');

              // Signal completion
              await headlessInAppWebView?.dispose();
              headlessInAppWebView = null;

              if (!webviewCompleter.isCompleted) {
                webviewCompleter.complete();
              }
            } catch (e) {
              AppLog.instance.put('❌ onMetadata error: $e');
              if (!webviewCompleter.isCompleted) {
                webviewCompleter.completeError(e);
              }
            }
          },
        );
      },
      onLoadStop: (controller, url) async {
        AppLog.instance.put('WebView loaded: $url');
      },
      onLoadError: (controller, url, code, message) {
        AppLog.instance.put('WebView load error: $url code=$code msg=$message');
        if (!webviewCompleter.isCompleted) {
          webviewCompleter.completeError(
            Exception('WebView load error: $message'),
          );
        }
      },
      onLoadHttpError: (controller, url, statusCode, description) {
        AppLog.instance.put(
          'WebView HTTP error: $url status=$statusCode desc=$description',
        );
      },
      onConsoleMessage: (controller, consoleMessage) {
        AppLog.instance.put(
          'WebView console: ${consoleMessage.messageLevel} ${consoleMessage.message}',
        );
        if (consoleMessage.messageLevel == ConsoleMessageLevel.ERROR) {
          if (!webviewCompleter.isCompleted) {
            webviewCompleter.completeError(
              Exception('Webview: ${consoleMessage.message}'),
            );
          }
        }
      },
    );

    await webview.run();
    headlessInAppWebView = webview;

    // 等待元数据提取完成或超时（30秒）
    try {
      await webviewCompleter.future.timeout(const Duration(seconds: 30));
    } catch (e) {
      AppLog.instance.put('WebView timeout or error: $e');
      await headlessInAppWebView?.dispose();
      headlessInAppWebView = null;
      rethrow;
    }
  }

  Future<void> saveBook(
    File file,
    String title,
    String author,
    String description,
    String? md5,
    String cover, {
    Book? provideBook,
  }) async {
    // Extract original filename (without extension)
    final fileNameWithoutExt = p.basenameWithoutExtension(file.path);

    // Use original filename if title is invalid
    final effectiveTitle = (title == 'Unknown' || title.trim().isEmpty)
        ? fileNameWithoutExt
        : title;

    final newBookName =
        '${effectiveTitle.length > 20 ? effectiveTitle.substring(0, 20) : effectiveTitle}-${DateTime.now().millisecondsSinceEpoch}'
            .replaceAll(RegExp(r'[<>:"/\\|?*]'), '_')
            .replaceAll('\n', '')
            .replaceAll('\r', '')
            .trim();

    final extension = file.path.split('.').last;

    final dbFilePath = 'file/$newBookName.$extension';
    final filePath = await FileUtils.getBasePath(dbFilePath);
    String? dbCoverPath = 'cover/$newBookName';

    await file.copy(filePath);
    // remove cached file
    file.delete();

    dbCoverPath = await saveImageToLocal(cover, dbCoverPath);
    if (md5 != null) {
      provideBook ??= await BookDatasourceImpl().getBookByMd5(md5);
    }

    Book book = Book(
      id: provideBook != null ? provideBook.id : -1,
      title: provideBook?.title ?? effectiveTitle,
      coverPath: dbCoverPath,
      filePath: dbFilePath,
      lastReadPosition: provideBook?.lastReadPosition ?? '',
      readingPercentage: provideBook?.readingPercentage ?? 0,
      author: provideBook?.author ?? author,
      isDeleted: 0,
      rating: provideBook?.rating ?? 0.0,
      md5: md5,
      createTime: provideBook?.createTime ?? DateTime.now(),
      updateTime: DateTime.now(),
      groupId: -1,
    );

    try {
      int insertResult = await BookDatasourceImpl().insertBook(book);
      await headlessInAppWebView?.dispose();
      headlessInAppWebView = null;
    } catch (e) {
      AppLog.instance.put('Error saving book to database: $e');
    }

    return;
  }

  Future<String> saveImageToLocal(String? imageFile, String name) async {
    if (imageFile == null) {
      return name;
    }
    try {
      // image is base64 encoded
      // data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD//gA8Q1JFQVRPUjogZ2...
      final List<String> parts = imageFile.split(',');
      final String base64String = parts[1];
      final Uint8List pngBytes = base64.decode(base64String);
      final extension = parts[0].split('/')[1].split(';')[0];

      name = '$name.$extension';
      final path = await FileUtils.getBasePath(name);

      final file = File(path);
      await file.writeAsBytes(pngBytes);

      return name;
    } catch (e) {
      AppLog.instance.put('Error saving image\n$e');
      return name;
    }
  }
}
