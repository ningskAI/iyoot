import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/providers/bookshelf_provider.dart';
import 'package:i_reader/ui/widgets/book_cover.dart';

/// 书架内容区域
class BookshelfBody extends ConsumerWidget {
  const BookshelfBody({
    super.key,
    required this.scrollController,
    required this.onReload,
  });

  final ScrollController scrollController;
  final Function(bool) onReload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookShelfAsync = ref.watch(bookshelfBooksProvider);

    return bookShelfAsync.when(
      data: (books) {
        if (books.isEmpty) {
          return const Center(child: Text('书架为空'));
        }
        return BooksList(books: books, scrollController: scrollController);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          ErrorWidget(error: error, onRetry: () => onReload(true)),
    );
  }
}

/// 书籍列表Widget
class BooksList extends StatelessWidget {
  const BooksList({
    super.key,
    required this.books,
    required this.scrollController,
  });

  final List<Book> books;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    List<int> lockedIndices = [];
    for (int i = 0; i < books.length; i++) {
      lockedIndices.add(i);
    }

    return ReorderableBuilder(
      enableDraggable: false,
      lockedIndices: lockedIndices,
      scrollController: scrollController,
      children: [
        for (final book in books)
          BookCover(key: ValueKey(book.id.toString()), book: book),
      ],
      builder: (children) => LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = (constraints.maxWidth / 120).floor();
          crossAxisCount = crossAxisCount.clamp(2, 8);
          return SizedBox(
            height: constraints.maxHeight,
            child: GridView.builder(
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 32,
                crossAxisSpacing: 24,
                childAspectRatio: 0.7,
              ),
              itemCount: children.length,
              itemBuilder: (context, index) => children[index],
            ),
          );
        },
      ),
    );
  }
}

/// 错误显示Widget
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('加载失败: $error'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('重试')),
          ],
        ),
      ),
    );
  }
}
