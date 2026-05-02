import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/providers/bookshelf_provider.dart';
import 'package:i_reader/ui/pages/home/widgets/home_page_indicator.dart';
import 'package:i_reader/ui/pages/home/widgets/home_page_view.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentPage = 0;

  void updateCurrentPage(int index) {
    if (mounted) setState(() => _currentPage = index);
  }

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(bookshelfBooksProvider);
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: HomePageBackground(
        glowColors: const [Color(0xFF4F7CFF), Color(0xFF7C5CFF)],
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWideScreen ? 40 : 16,
              vertical: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      '最近阅读',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: HomePalette.primaryText(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                HomePageIndicator(
                  booksAsync: booksAsync,
                  currentPage: _currentPage,
                  onPageChanged: updateCurrentPage,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: HomePageView(
                    booksAsync: booksAsync,
                    currentPage: _currentPage,
                    onPageChanged: updateCurrentPage,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
