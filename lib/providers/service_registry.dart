import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/services/book/local_book_service.dart';
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
}
