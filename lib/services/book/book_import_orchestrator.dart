import 'dart:io';

import 'package:i_reader/core/base/base_service.dart';
import 'package:i_reader/providers/service_registry.dart';

/// 导入流程协调Service - 职责：协调各个步骤，但不涉及UI逻辑
class BookImportOrchestrator extends BaseService {
  static final BookImportOrchestrator instance = BookImportOrchestrator._init();
  BookImportOrchestrator._init();

  /// 第一步：选择文件
  Future<List<File>> selectFiles() async {
    return await readService(AppServices.localBookService).pickLocalFiles();
  }

  /// 第二步：检查并分类文件
  Future<Map<String, dynamic>> checkAndCategorizeFiles(List<File> files) async {
    return await readService(
      AppServices.localBookService,
    ).checkImportFilesAdvanced(files);
  }

  /// 单个文件导入 - 职责清晰，只做导入
  Future<void> importFile(File file) async {
    return await readService(AppServices.localBookService).importBook(file);
  }
}
