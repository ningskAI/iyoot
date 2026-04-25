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
  // Set of currently selected filter types
  final Set<String> _selectedTypes = {};

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
    // Define available note types.
    final List<String> availableTypes = ['note', 'underline', 'bookmark'];
    
    // Temporary state for the dialog
    Set<String> tempSelectedTypes = Set.from(_selectedTypes);
    // 兼容 'note' 和 'highlight' 类型
    String activeTab = tempSelectedTypes.isEmpty ? 'note' : tempSelectedTypes.first;
    if (activeTab == 'highlight') activeTab = 'note';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                    '筛选你要的笔记',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Type selection tabs - 4 columns layout
                  Row(
                    children: [
                      ...availableTypes.map((type) {
                        String label;
                        IconData? icon;
                        switch (type) {
                          case 'highlight':
                          case 'note':
                            label = '想法';
                            icon = Icons.record_voice_over;
                            break;
                          case 'underline':
                            label = '划线';
                            icon = Icons.format_underline;
                            break;
                          case 'bookmark':
                            label = '书签';
                            icon = Icons.bookmark;
                            break;
                          default:
                            label = type;
                        }
                        
                        final isSelected = tempSelectedTypes.contains(type);
                        
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    tempSelectedTypes.remove(type);
                                    if (activeTab == type && tempSelectedTypes.isNotEmpty) {
                                      activeTab = tempSelectedTypes.first;
                                    }
                                  } else {
                                    tempSelectedTypes.add(type);
                                    activeTab = type;
                                  }
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected ? const Color(0xFF4A90E2) : Colors.grey[300]!,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (icon != null) ...[
                                      Icon(icon, size: 16, color: isSelected ? const Color(0xFF4A90E2) : const Color(0xFF666666)),
                                      const SizedBox(width: 4),
                                    ],
                                    Text(
                                      label,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: isSelected ? const Color(0xFF4A90E2) : const Color(0xFF666666),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      // Add "点评" button (disabled placeholder)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1.5,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat_bubble_outline, size: 16, color: Color(0xFF666666)),
                              SizedBox(width: 4),
                              Text(
                                '点评',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  // Sub-options area for note/highlight
                  if (activeTab == 'note' || activeTab == 'highlight')
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '笔记类型',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF999999),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildTypeIconWithIcon(Icons.record_voice_over, activeTab == 'note'),
                              const SizedBox(width: 16),
                              _buildTypeIconWithIcon(Icons.format_underline, activeTab == 'underline'),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            '笔记颜色',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF999999),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              _buildColorCircle(const Color(0xFF66CCFF)),
                              const SizedBox(width: 12),
                              _buildColorCircle(const Color(0xFFFF0000)),
                              const SizedBox(width: 12),
                              _buildColorCircle(const Color(0xFF00FF00)),
                              const SizedBox(width: 12),
                              _buildColorCircle(const Color(0xFFEB3BFF)),
                              const SizedBox(width: 12),
                              _buildColorCircle(const Color(0xFFFFD700)),
                            ],
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '划线类型',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildTypeIcon('A', false),
                            const SizedBox(width: 16),
                            _buildTypeIcon('A', true, underline: true),
                            const SizedBox(width: 16),
                            _buildTypeIcon('A', true),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '划线颜色',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildColorCircle(const Color(0xFFFFB3B3)),
                            const SizedBox(width: 12),
                            _buildColorCircle(const Color(0xFFD4B8FF)),
                            const SizedBox(width: 12),
                            _buildColorCircle(const Color(0xFFA8D4FF)),
                            const SizedBox(width: 12),
                            _buildColorCircle(const Color(0xFFB3E6B3)),
                            const SizedBox(width: 12),
                            _buildColorCircle(const Color(0xFFFFE0A8)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: OutlinedButton(
                          onPressed: () {
                            tempSelectedTypes.clear();
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
                            _selectedTypes.clear();
                            _selectedTypes.addAll(tempSelectedTypes);

                            if (_selectedTypes.isEmpty) {
                              ref
                                  .read(
                                    bookNoteNotifierProvider(
                                      widget.book.bookId,
                                    ).notifier,
                                  )
                                  .resetFilter();
                            } else {
                              ref
                                  .read(
                                    bookNoteNotifierProvider(
                                      widget.book.bookId,
                                    ).notifier,
                                  )
                                  .filterByTypes(_selectedTypes.toList());
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                '查看',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '筛选到 ${tempSelectedTypes.isEmpty ? '0' : tempSelectedTypes.length} 个笔记',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
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

  Widget _buildTypeIcon(String text, bool isActive, {bool underline = false}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE8F2FF) : const Color(0xFFF0F0F0),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isActive ? const Color(0xFF4A90E2) : const Color(0xFF999999),
            decoration: underline ? TextDecoration.underline : null,
            decorationColor: isActive ? const Color(0xFF4A90E2) : null,
          ),
        ),
      ),
    );
  }

  Widget _buildTypeIconWithIcon(IconData icon, bool isActive) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE8F2FF) : const Color(0xFFF0F0F0),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: 22,
          color: isActive ? const Color(0xFF4A90E2) : const Color(0xFF999999),
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
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








