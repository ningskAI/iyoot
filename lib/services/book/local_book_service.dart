import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:i_reader/core/base/base_service.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/utils/app_log.dart';
import 'package:i_reader/utils/file_utils.dart';
import 'package:i_reader/utils/platform.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class LocalBookService extends BaseService {
  static final LocalBookService instance = LocalBookService._init();
  LocalBookService._init();

  Future<List<Book>> importLocalFiles({List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions:
            allowedExtensions ?? ["epub", "mobi", "azw3", "fb2", "txt", "pdf"],
        allowMultiple: true,
      );
      if (result == null || result.files.isEmpty) {
        return [];
      }
      List<PlatformFile> files = result.files;
      AppLog.instance.putDebug('importBook files: ${files.toString()}');
      List<File> fileList = [];
      if (!kIsAndroid) {
        fileList = await Future.wait(
          files.map((file) async {
            return _copyToTempFile(sourcePath: file.path!, fileName: file.name);
          }).toList(),
        );
      } else {
        fileList = files.map((file) => File(file.path!)).toList();
      }
    } catch (e) {
      rethrow;
    }
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
}
