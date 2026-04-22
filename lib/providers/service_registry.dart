import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/services/about/heap_dump_service.dart';
import 'package:i_reader/services/about/log_save_service.dart';
import 'package:i_reader/services/book/book_import_orchestrator.dart';
import 'package:i_reader/services/book/local_book_service.dart';
import 'package:i_reader/services/crash_log_service.dart';
import 'package:i_reader/services/local_config_service.dart';
import 'package:i_reader/services/md5_service.dart';
import 'package:i_reader/services/statusbar/statusbar_service.dart';
import 'package:i_reader/services/web/web_service_manager.dart';

ProviderContainer _appProviderContainer = ProviderContainer();

ProviderContainer get appProviderContainer => _appProviderContainer;

T readService<T>(Object provider) {
  return _appProviderContainer.read(provider as dynamic);
}

abstract final class AppServices {
  static final localBookService = Provider<LocalBookService>((ref) {
    return LocalBookService.instance;
  });
  static final webserviceManager = Provider<WebServiceManager>((ref) {
    return WebServiceManager.instance;
  });
  static final md5Service = Provider<Md5Service>((ref) {
    return Md5Service.instance;
  });
  static final bookImportOrchestrator = Provider<BookImportOrchestrator>((ref) {
    return BookImportOrchestrator.instance;
  });
  static final crashLogService = Provider<CrashLogService>((ref) {
    return CrashLogService.instance;
  });
  static final heapDumpService = Provider<HeapDumpService>((ref) {
    return HeapDumpService.instance;
  });
  static final logSaveService = Provider<LogSaveService>((ref) {
    return LogSaveService.instance;
  });
  static final localConfigService = Provider<LocalConfigService>((ref) {
    return LocalConfigService.instance;
  });
  static final statusbarService = Provider<StatusbarService>((ref) {
    return StatusbarService.instance;
  });
}
