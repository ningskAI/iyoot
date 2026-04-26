import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/data/models/book_extra.dart';
import 'package:i_reader/providers/booknote_provider.dart';
import 'package:i_reader/ui/pages/note/widgets/book_note_tile.dart';
import 'package:i_reader/ui/widgets/book_cover.dart';
import 'package:i_reader/ui/widgets/card.dart';
import 'package:i_reader/ui/widgets/highlight_digit.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';
import 'package:i_reader/ui/widgets/td/td_action_button.dart';
import 'package:i_reader/ui/widgets/td/td_appbar.dart';

class BookNotesPage extends ConsumerStatefulWidget {
  const BookNotesPage({super.key, required this.book});

  final BookExtra book;

  @override
  ConsumerState<BookNotesPage> createState() => _BookNotesPageState();
}

class _BookNotesPageState extends ConsumerState<BookNotesPage> {
  @override
  void dispose() {
    // Reset filter when leaving the page to avoid carrying over state
    ref
        .read(bookNoteNotifierProvider(widget.book.bookId).notifier)
        .resetFilter();
    super.dispose();
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
              TDAppbar(
                title: "笔记",
                actions: [
                  // Filter Button
                  TDActionButton(
                    icon: Icons.filter_list,
                    onTap: () => _showFilterDialog(context),
                  ),
                  TDActionButton(icon: Icons.import_export, onTap: () {}),
                ],
              ),
              const SizedBox(height: 10),
              // 修复点 1: Expanded 必须作为 Column 的直接子组件
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _bookInfo(
                        context,
                        widget.book,
                        widget.book.numberOfNotes,
                      ),
                      const SizedBox(height: 16),
                      // 修复点 2: 列表部分也需要 Expanded 来占据剩余空间
                      Expanded(child: _buildNotesList()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    // Simplified filter options:
    // 0: All (no filter)
    // 1: Highlight (underline + highlight)
    // 2: Note (has readerNote)
    // 3: Bookmark

    int selectedFilter = 0; // Default: All

    // Sync with current state is tricky without exposing internal state of notifier fully,
    // but we can approximate or just default to 0 if we don't track it locally.
    // For better UX, we might want to read the current filter state from the notifier if exposed.
    // Assuming we default to 0 or try to infer from previous local state if we kept it.
    // Since we removed _selectedTypes, we'll default to 0 (All) or you might want to store last selectedFilter index.

    // If you want to persist the last selected filter mode, you could add an int _lastFilterIndex to the state.
    // For now, let's assume we start at 0 or you can enhance this later.

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle bar
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const Text(
                    '筛选笔记',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Filter buttons - 4 options
                  Row(
                    children: [
                      _buildFilterButton(
                        '全部',
                        Icons.apps,
                        selectedFilter == 0,
                        () => setModalState(() => selectedFilter = 0),
                      ),
                      _buildFilterButton(
                        '高亮',
                        Icons.highlight,
                        selectedFilter == 1,
                        () => setModalState(() => selectedFilter = 1),
                      ),
                      _buildFilterButton(
                        '笔记',
                        Icons.sticky_note_2,
                        selectedFilter == 2,
                        () => setModalState(() => selectedFilter = 2),
                      ),
                      _buildFilterButton(
                        '书签',
                        Icons.bookmark,
                        selectedFilter == 3,
                        () => setModalState(() => selectedFilter = 3),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: OutlinedButton(
                          onPressed: () {
                            ref
                                .read(
                                  bookNoteNotifierProvider(
                                    widget.book.bookId,
                                  ).notifier,
                                )
                                .resetFilter();
                            Navigator.pop(ctx);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            side: BorderSide(color: Colors.grey[300]!),
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            '重置',
                            style: TextStyle(
                              color: Color(0xFF666666),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 5,
                        child: ElevatedButton(
                          onPressed: () {
                            final notifier = ref.read(
                              bookNoteNotifierProvider(
                                widget.book.bookId,
                              ).notifier,
                            );

                            if (selectedFilter == 0) {
                              // All - reset filter
                              notifier.resetFilter();
                            } else if (selectedFilter == 1) {
                              // Highlight - filter by underline and highlight types
                              notifier.filterByTypes([
                                'underline',
                                'highlight',
                              ]);
                            } else if (selectedFilter == 2) {
                              // Note - filter by hasNote
                              notifier.filterByHasNote(true);
                            } else if (selectedFilter == 3) {
                              // Bookmark - filter by bookmark type
                              notifier.filterByTypes(['bookmark']);
                            }
                            Navigator.pop(ctx);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A90E2),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            '确认',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterButton(
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE8F2FF) : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF4A90E2) : Colors.grey[300]!,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF4A90E2)
                    : const Color(0xFF666666),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? const Color(0xFF4A90E2)
                      : const Color(0xFF666666),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotesList() {
    // Use the correct provider from file1
    final bookNoteAsync = ref.watch(
      bookNoteNotifierProvider(widget.book.bookId),
    );

    return bookNoteAsync.when(
      data: (bookmarks) {
        if (bookmarks.isEmpty) {
          return const Center(
            child: Text('暂无笔记', style: TextStyle(color: Colors.white70)),
          );
        }

        String? previousChapter;

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 20),
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final bookmark = bookmarks[index];
            final currentChapter = bookmark.chapter;

            List<Widget> children = [];

            // Check if we need to display a chapter header
            if (currentChapter != previousChapter) {
              children.add(
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 4,
                  ),
                  child: Text(
                    currentChapter ?? '未命名章节',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
              previousChapter = currentChapter;
            }

            // Add the note tile
            children.add(BookNoteTile(note: bookmark));

            // Add separator if it's not the last item
            if (index < bookmarks.length - 1) {
              children.add(const SizedBox(height: 12));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            );
          },
        );
      },
      loading: () => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text("加载中...", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      error: (error, stack) => Center(
        child: Text(
          '加载书签失败: $error',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _bookInfo(
    BuildContext context,
    BookExtra bookExtra,
    int numberOfNotes,
  ) {
    TextStyle titleStyle = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
      fontFamily: 'SourceHanSerif',
    );
    return CardView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bookExtra.title, style: titleStyle, maxLines: 1),
                      const SizedBox(height: 10),
                      _notesStatistic(context, numberOfNotes, bookExtra),
                    ],
                  ),
                ),
                const SizedBox(width: 30),
                Hero(
                  tag: bookExtra.coverFullPath,
                  child: BookCover(
                    book: Book(
                      id: bookExtra.bookId,
                      title: bookExtra.title,
                      author: bookExtra.author,
                      coverPath: bookExtra.coverPath,
                      filePath: bookExtra.filePath,
                      lastReadPosition: "",
                      readingPercentage: bookExtra.readingPercentage,
                      groupId: -1,
                      isDeleted: 0,
                      rating: 0,
                      createTime: DateTime.now(),
                      updateTime: DateTime.now(),
                    ),
                    height: 100,
                    width: 75,
                    radius: 5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _notesStatistic(
    BuildContext context,
    int numberOfNotes,
    BookExtra bookExtra,
  ) {
    TextStyle digitStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.bodyLarge!.color,
    );
    TextStyle textStyle = TextStyle(
      fontSize: 14,
      color: Theme.of(context).textTheme.bodyLarge!.color,
      fontFamily: 'SourceHanSerif',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HighlightDigit(
          str: "${bookExtra.numberOfNotes}条笔记",
          textStyle: textStyle,
          digitStyle: digitStyle,
        ),
        Text('读到${(bookExtra.readingPercentage * 100).toStringAsFixed(2)}%'),
      ],
    );
  }
}
