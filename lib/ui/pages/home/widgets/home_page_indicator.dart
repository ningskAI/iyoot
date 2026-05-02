import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';

class HomePageIndicator extends StatelessWidget {
  final AsyncValue<List<Book>> booksAsync;
  final int currentPage;
  final Function(int) onPageChanged;

  const HomePageIndicator({
    super.key,
    required this.booksAsync,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return booksAsync.when(
      data: (books) {
        final recentBooks = books
            .where((book) => book.isDeleted == 0)
            .take(3)
            .toList();
        if (recentBooks.length <= 1) return const SizedBox.shrink();

        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              recentBooks.length,
              (index) => GestureDetector(
                onTap: () => onPageChanged(index),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? HomePalette.accent
                        : HomePalette.textTertiary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
