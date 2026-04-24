import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/core/event/app_events.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/providers/event_bus_provider.dart';
import 'package:i_reader/providers/service_registry.dart';
import 'package:i_reader/services/book/local_book_service.dart';
import 'package:i_reader/utils/app_log.dart';

/// 导入文件检查结果
class ImportFileCheckState {
  final bool isLoading;
  final List<File> supportedFiles;
  final List<File> unsupportedFiles;
  final List<File> uniqueFiles;
  final List<File> duplicateFiles;
  final Map<String, Book> duplicateInfo;
  final String? error;

  ImportFileCheckState({
    this.isLoading = false,
    this.supportedFiles = const [],
    this.unsupportedFiles = const [],
    this.uniqueFiles = const [],
    this.duplicateFiles = const [],
    this.duplicateInfo = const {},
    this.error,
  });

  ImportFileCheckState copyWith({
    bool? isLoading,
    List<File>? supportedFiles,
    List<File>? unsupportedFiles,
    List<File>? uniqueFiles,
    List<File>? duplicateFiles,
    Map<String, Book>? duplicateInfo,
    String? error,
  }) {
    return ImportFileCheckState(
      isLoading: isLoading ?? this.isLoading,
      supportedFiles: supportedFiles ?? this.supportedFiles,
      unsupportedFiles: unsupportedFiles ?? this.unsupportedFiles,
      uniqueFiles: uniqueFiles ?? this.uniqueFiles,
      duplicateFiles: duplicateFiles ?? this.duplicateFiles,
      duplicateInfo: duplicateInfo ?? this.duplicateInfo,
      error: error,
    );
  }
}

/// 导入过程状态
class ImportProgressState {
  final bool isImporting;
  final List<String> completedFiles;
  final List<String> errorFiles;
  final Map<String, String> errorMessages;
  final String? currentFile;

  ImportProgressState({
    this.isImporting = false,
    this.completedFiles = const [],
    this.errorFiles = const [],
    this.errorMessages = const {},
    this.currentFile,
  });

  ImportProgressState copyWith({
    bool? isImporting,
    List<String>? completedFiles,
    List<String>? errorFiles,
    Map<String, String>? errorMessages,
    String? currentFile,
  }) {
    return ImportProgressState(
      isImporting: isImporting ?? this.isImporting,
      completedFiles: completedFiles ?? this.completedFiles,
      errorFiles: errorFiles ?? this.errorFiles,
      errorMessages: errorMessages ?? this.errorMessages,
      currentFile: currentFile,
    );
  }
}

/// 文件检查Provider - 职责：检查并分类文件
class ImportFileCheckNotifier extends StateNotifier<ImportFileCheckState> {
  ImportFileCheckNotifier() : super(ImportFileCheckState());

  /// 检查并分类文件
  Future<void> checkFiles(List<File> files) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await LocalBookService.instance.checkImportFilesAdvanced(
        files,
      );

      state = state.copyWith(
        isLoading: false,
        supportedFiles: result['supportedFiles'] ?? [],
        unsupportedFiles: result['unsupportedFiles'] ?? [],
        uniqueFiles: result['uniqueFiles'] ?? [],
        duplicateFiles: result['duplicateFiles'] ?? [],
        duplicateInfo: result['duplicateInfo'] ?? {},
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() {
    state = ImportFileCheckState();
  }
}

/// 导入进度Provider - 职责：追踪导入过程
class ImportProgressNotifier extends StateNotifier<ImportProgressState> {
  final Ref ref;

  ImportProgressNotifier(this.ref) : super(ImportProgressState());

  /// 执行批量导入
  Future<void> importBooks({required List<File> filesToImport}) async {
    AppLog.instance.put(
      '📥 importBooks called, files: ${filesToImport.length}',
    );

    // 防护：如果已经在导入中，直接返回
    if (state.isImporting) {
      AppLog.instance.put('⚠️ Already importing, returning early');
      return;
    }

    state = state.copyWith(isImporting: true);
    AppLog.instance.put('🚀 Starting import, isImporting=true');

    for (var file in filesToImport) {
      AppLog.instance.put('📄 Processing: ${file.path}');
      state = state.copyWith(currentFile: file.path);
      try {
        AppLog.instance.put('⏳ Calling importBook...');
        await readService(AppServices.localBookService).importBook(file);
        AppLog.instance.put('✓ importBook done');

        state = state.copyWith(
          completedFiles: [...state.completedFiles, file.path],
        );
        AppLog.instance.put('✓ Added to completedFiles');

        // 每个文件导入完成后触发事件
        try {
          ref
              .read(eventBusProvider)
              .fire(
                BookCollectionChangedEvent(reason: 'book_added', bookUrl: ""),
              );
          AppLog.instance.put('✓ Event fired for file');
        } catch (eEvent) {
          AppLog.instance.put('⚠️ Event fire error: $eEvent');
        }
      } catch (e) {
        AppLog.instance.put('❌ Error importing: $e');
        state = state.copyWith(
          errorFiles: [...state.errorFiles, file.path],
          errorMessages: {...state.errorMessages, file.path: e.toString()},
        );
      }
    }

    state = state.copyWith(isImporting: false, currentFile: null);
    AppLog.instance.put('✅ All imports done, isImporting=false');
  }

  void reset() {
    state = ImportProgressState();
  }
}

/// 文件检查Provider
final importFileCheckProvider =
    StateNotifierProvider<ImportFileCheckNotifier, ImportFileCheckState>(
      (ref) => ImportFileCheckNotifier(),
    );

/// 导入进度Provider
final importProgressProvider =
    StateNotifierProvider<ImportProgressNotifier, ImportProgressState>(
      (ref) => ImportProgressNotifier(ref),
    );
