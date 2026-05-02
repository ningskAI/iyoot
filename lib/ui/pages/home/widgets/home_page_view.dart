import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/ui/pages/home/widgets/home_book_card.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';

class HomePageView extends StatefulWidget {
  final AsyncValue<List<Book>> booksAsync;
  final int currentPage;
  final Function(int) onPageChanged;

  const HomePageView({
    super.key,
    required this.booksAsync,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.currentPage,
      viewportFraction: 1.0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.booksAsync.when(
      data: (books) {
        final recentBooks = books
            .where((book) => book.isDeleted == 0)
            .take(3)
            .toList();
        if (recentBooks.isEmpty) return _buildEmptyState();

        return PageView.builder(
          controller: _pageController,
          itemCount: recentBooks.length,
          physics: const PageScrollPhysics(),
          onPageChanged: (index) => widget.onPageChanged(index),
          itemBuilder: (context, index) =>
              HomeBookCard(book: recentBooks[index]),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text(
          '加载失败: $error',
          style: TextStyle(color: HomePalette.secondaryText(context)),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_outlined,
            size: 56,
            color: HomePalette.textTertiary,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无阅读记录',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: HomePalette.secondaryText(context),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '导入书籍开始阅读',
            style: TextStyle(fontSize: 13, color: HomePalette.textTertiary),
          ),
        ],
      ),
    );
  }
}
