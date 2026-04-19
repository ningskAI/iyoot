import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/providers/bookshelf_provider.dart';
import 'package:i_reader/providers/service_registry.dart';
import 'package:i_reader/ui/pages/bookshelf/widgets/bookshelf_empty_state.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';

class BookshelfPage extends ConsumerStatefulWidget {
  const BookshelfPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BookshelfState();
}

class _BookshelfState extends ConsumerState<BookshelfPage> {
  Widget body = Column();

  Widget _buildBookshelfHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '书架',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: HomePalette.primaryText(context),
                  ),
                ),
              ),
              _buildHeaderActionButton(
                icon: Icons.search_rounded,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _buildHeaderActionButton(icon: Icons.cloud_sync, onTap: () {}),
              const SizedBox(width: 10),
              PopupMenuButton<String>(
                padding: EdgeInsetsGeometry.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                position: PopupMenuPosition.under,
                onSelected: _handleMenuAction,
                itemBuilder: (context) => [
                  _buildPopupMenuItem(
                    "add_local",
                    Icons.add_box_outlined,
                    "添加本地",
                  ),
                  _buildPopupMenuItem(
                    "add_remote",
                    Icons.download_outlined,
                    "添加远程",
                  ),
                  _buildPopupMenuItem("sort_book", Icons.sort_outlined, "书籍排序"),
                ],
                child: IgnorePointer(
                  child: _buildHeaderActionButton(
                    icon: Icons.more_horiz_rounded,
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String value) {
    switch (value) {
      case 'add_local':
        _importLocalBooks();
        break;
      default:
        return;
    }
  }

  Future<void> _importLocalBooks() async {
    final books = await readService(
      AppServices.localBookService,
    ).importLocalFiles();
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    IconData icon,
    String text,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildHeaderActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: HomePalette.mutedCard(context),
            shape: BoxShape.circle,
            border: Border.all(color: HomePalette.lineColor(context)),
          ),
          child: Icon(icon, size: 22, color: HomePalette.primaryText(context)),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final bookShelfAsync = ref.watch(bookshelfBooksProvider);
    return bookShelfAsync.when(
      data: (books) {
        if (books.isEmpty) {
          return _buildEmptyState();
        }
        return _buildBooksList(books);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('加载失败: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _reloadBookshelf(showLoading: true);
              },
              child: const Text('重试'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _reloadBookshelf({bool showLoading = false}) {
    return ref
        .read(bookshelfBooksProvider.notifier)
        .reload(showLoading: showLoading);
  }

  Widget _buildBooksList(List<Book> books) {
    return Center();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: HomeSectionCard(
          margin: EdgeInsets.zero,
          child: BookshelfEmptyState(
            onSearchOnline: () {},
            onImportLocal: () {},
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: HomePageBackground(
        glowColors: const [Color(0xFF4F7CFF), Color(0xFF7C5CFF)],
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildBookshelfHeader(context),
              Expanded(child: _buildBody(context)),
            ],
          ),
        ),
      ),
    );
  }
}
