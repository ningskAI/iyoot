import 'package:i_reader/data/models/toc.dart';
import 'package:i_reader/ui/pages/reading/reading_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_toc.g.dart';

@Riverpod(keepAlive: true)
class BookToc extends _$BookToc {
  @override
  List<Toc> build() {
    return [];
  }

  void setToc(List<Toc> tocItems) {
    state = tocItems;
  }

  Future<void> refresh(String bookId) async {
    epubPlayerKey.currentState?.refreshToc();
  }
}
