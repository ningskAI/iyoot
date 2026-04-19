import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:i_reader/core/base/base_service.dart';
import 'package:i_reader/data/datasources/impl/book_datasource_impl.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/data/models/import_file_check.dart';
import 'package:i_reader/utils/app_log.dart';

class Md5Service extends BaseService {
  static final Md5Service instance = Md5Service._init();
  Md5Service._init();

  Future<String?> calculateFileMd5(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return null;
      }

      final bytes = await file.readAsBytes();
      final digest = md5.convert(bytes);
      return digest.toString();
    } catch (e) {
      AppLog.instance.put('Error calculating MD5 for $filePath: $e');
      return null;
    }
  }

  Future<Book?> checkDuplicateByMd5(String md5) async {
    return await BookDatasourceImpl().getBookByMd5(md5);
  }

  Future<List<ImportFileCheck>> checkImportFiles(List<String> filePaths) async {
    List<ImportFileCheck> results = [];
    for (final filePath in filePaths) {
      final md5 = await calculateFileMd5(filePath);
      Book? duplicateBook;
      if (md5 != null) {
        duplicateBook = await checkDuplicateByMd5(md5);
      }
      results.add(
        ImportFileCheck(
          filePath: filePath,
          isDuplicate: duplicateBook != null && !duplicateBook.isDeleted,
          duplicateBook: duplicateBook,
          isRestore: false,
        ),
      );
    }
    return results;
  }
}
