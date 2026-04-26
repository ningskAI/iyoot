import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/data/models/book_extra.dart';
import 'package:i_reader/data/models/book_note.dart';
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
  // Selection Mode State
  bool _isSelectionMode = false;
  final Set<int?> _selectedNoteIds = {};

  @override
  void dispose() {
    // Reset filter when leaving the page to avoid carrying over state
    // Use ref.read safely before super.dispose() is called
    try {
      ref
          .read(bookNoteNotifierProvider(widget.book.bookId).notifier)
          .resetFilter();
    } catch (e) {
      // Ignore errors during disposal
      print('Error resetting filter during disposal: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(bookNoteNotifierProvider(widget.book.bookId));

    final noteCountAsync = ref.watch(bookNoteCountProvider(widget.book.bookId));

    // Get total count for header, fallback to book extra if loading/error
    final int totalNoteCount = noteCountAsync.when(
      data: (count) => count,
      loading: () => widget.book.numberOfNotes,
      error: (_, __) => widget.book.numberOfNotes,
    );

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
                        totalNoteCount, // Use total count for header
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
    // Use Sets for multi-selection
    // Top Level Categories: 'underline_only' (no note), 'note' (has note), 'bookmark'
    final Set<String> selectedCategories = {};

    // Sub-filters for annotations (underline/highlight types and colors)
    final Set<String> selectedAnnotationTypes = {}; // 'underline', 'highlight'
    final Set<String> selectedColors = {};

    // Get current theme brightness to adjust UI elements if needed
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow sheet to take more space if needed
      backgroundColor:
          Colors.transparent, // Let inner widgets handle background
      builder: (ctx) {
        return Theme(
          data: theme, // Inherit current theme (Light/Dark)
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return HomePageBackground(
                glowColors: const [Color(0xFF4F7CFF), Color(0xFF7C5CFF)],
                // Remove fixed padding from container, apply to scrollable content
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(top: 10, bottom: 16),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[700] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Text(
                      '筛选你要的笔记',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color:
                            theme.textTheme.titleLarge?.color ??
                            (isDark ? Colors.white : Colors.black87),
                      ),
                    ),
                    // Wrap the rest of the content in SingleChildScrollView
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Unified CardView for Types and Colors
                            Text(
                              '类型',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    theme.textTheme.bodyMedium?.color ??
                                    (isDark ? Colors.white70 : Colors.black87),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: [
                                _buildFilterButton(
                                  '划线', // Represents annotations without notes
                                  selectedCategories.contains('underline_only'),
                                  () => setModalState(() {
                                    if (selectedCategories.contains(
                                      'underline_only',
                                    )) {
                                      selectedCategories.remove(
                                        'underline_only',
                                      );
                                    } else {
                                      selectedCategories.add('underline_only');
                                    }
                                  }),
                                ),
                                _buildFilterButton(
                                  '笔记', // Represents annotations with notes
                                  selectedCategories.contains('note'),
                                  () => setModalState(() {
                                    if (selectedCategories.contains('note')) {
                                      selectedCategories.remove('note');
                                    } else {
                                      selectedCategories.add('note');
                                    }
                                  }),
                                ),
                                _buildFilterButton(
                                  '书签',
                                  selectedCategories.contains('bookmark'),
                                  () => setModalState(() {
                                    if (selectedCategories.contains(
                                      'bookmark',
                                    )) {
                                      selectedCategories.remove('bookmark');
                                    } else {
                                      selectedCategories.add('bookmark');
                                    }
                                  }),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            CardView(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 2. Annotation Type Selection (Underline / Highlight style)
                                    // Only relevant if 'underline_only' or 'note' is selected
                                    Text(
                                      '划线样式',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            theme.textTheme.bodyMedium?.color ??
                                            (isDark
                                                ? Colors.white70
                                                : Colors.black87),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        _buildTypeIcon(
                                          icon: Icons.format_underline,
                                          label: '下划线',
                                          isSelected: selectedAnnotationTypes
                                              .contains('underline'),
                                          onTap: () {
                                            setModalState(() {
                                              if (selectedAnnotationTypes
                                                  .contains('underline')) {
                                                selectedAnnotationTypes.remove(
                                                  'underline',
                                                );
                                              } else {
                                                selectedAnnotationTypes.add(
                                                  'underline',
                                                );
                                              }
                                            });
                                          },
                                        ),
                                        const SizedBox(width: 16),
                                        _buildTypeIcon(
                                          icon: Icons.highlight,
                                          label: '高亮',
                                          isSelected: selectedAnnotationTypes
                                              .contains('highlight'),
                                          onTap: () {
                                            setModalState(() {
                                              if (selectedAnnotationTypes
                                                  .contains('highlight')) {
                                                selectedAnnotationTypes.remove(
                                                  'highlight',
                                                );
                                              } else {
                                                selectedAnnotationTypes.add(
                                                  'highlight',
                                                );
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 20),

                                    // 3. Color Selection
                                    Text(
                                      '高亮颜色',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            theme.textTheme.bodyMedium?.color ??
                                            (isDark
                                                ? Colors.white70
                                                : Colors.black87),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Wrap(
                                      spacing: 16,
                                      runSpacing: 16,
                                      alignment: WrapAlignment.start,
                                      children: [
                                        for (final colorHex in [
                                          'FF0000', // red
                                          '800080', // purple
                                          '0000FF', // blue
                                          '008000', // green
                                          'FFA500', // orange
                                        ])
                                          GestureDetector(
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              setModalState(
                                                () =>
                                                    selectedColors.contains(
                                                      colorHex,
                                                    )
                                                    ? selectedColors.remove(
                                                        colorHex,
                                                      )
                                                    : selectedColors.add(
                                                        colorHex,
                                                      ),
                                              );
                                            },
                                            child: Container(
                                              width: 32,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                color: Color(
                                                  int.parse('0xff$colorHex'),
                                                ),
                                                border: Border.all(
                                                  color:
                                                      selectedColors.contains(
                                                        colorHex,
                                                      )
                                                      ? const Color(0xFF4A90E2)
                                                      : (isDark
                                                            ? Colors.grey[600]
                                                            : Colors
                                                                  .grey[300])!,
                                                  width:
                                                      selectedColors.contains(
                                                        colorHex,
                                                      )
                                                      ? 2
                                                      : 1,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child:
                                                  selectedColors.contains(
                                                    colorHex,
                                                  )
                                                  ? const Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: 16,
                                                    )
                                                  : null,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

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
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      side: BorderSide.none,
                                      backgroundColor: isDark
                                          ? Colors.grey[800]
                                          : Colors.grey[100],
                                    ),
                                    child: Text(
                                      '重置',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            theme.textTheme.bodyMedium?.color ??
                                            (isDark
                                                ? Colors.white70
                                                : Colors.black87),
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

                                      // Logic to map UI selections to Provider parameters
                                      // Provider signature: loadNotes({List<String>? types, bool? hasNote, String? color})

                                      List<String>? types;
                                      bool? hasNote;
                                      String? color;

                                      final bool hasCategorySelection =
                                          selectedCategories.isNotEmpty;
                                      final bool onlyBookmark =
                                          hasCategorySelection &&
                                          selectedCategories.contains(
                                            'bookmark',
                                          ) &&
                                          !selectedCategories.contains(
                                            'underline_only',
                                          ) &&
                                          !selectedCategories.contains('note');

                                      final bool onlyUnderlineOnly =
                                          hasCategorySelection &&
                                          selectedCategories.contains(
                                            'underline_only',
                                          ) &&
                                          !selectedCategories.contains(
                                            'note',
                                          ) &&
                                          !selectedCategories.contains(
                                            'bookmark',
                                          );

                                      final bool onlyNote =
                                          hasCategorySelection &&
                                          selectedCategories.contains('note') &&
                                          !selectedCategories.contains(
                                            'underline_only',
                                          ) &&
                                          !selectedCategories.contains(
                                            'bookmark',
                                          );

                                      // If "Bookmark" is selected along with others, or alone, we need to handle type filtering.
                                      // Since provider 'types' filters by annotation type (underline/highlight/bookmark),
                                      // and 'hasNote' filters by content existence.

                                      // 1. Determine 'hasNote'
                                      // If 'note' is selected AND 'underline_only' is NOT selected -> hasNote = true
                                      // If 'underline_only' is selected AND 'note' is NOT selected -> hasNote = false
                                      // If both or neither are selected -> hasNote = null (don't filter by note existence)

                                      if (selectedCategories.contains('note') &&
                                          !selectedCategories.contains(
                                            'underline_only',
                                          )) {
                                        hasNote = true;
                                      } else if (selectedCategories.contains(
                                            'underline_only',
                                          ) &&
                                          !selectedCategories.contains(
                                            'note',
                                          )) {
                                        hasNote = false;
                                      } else {
                                        hasNote = null;
                                      }

                                      // 2. Determine 'types'
                                      // If 'bookmark' is selected, we must include 'bookmark' in types.
                                      // If 'underline_only' or 'note' is selected, we might also want to filter by specific annotation styles (underline/highlight) if selected.
                                      // However, 'bookmark' is a distinct type.

                                      final List<String> typeList = [];

                                      if (selectedCategories.contains(
                                        'bookmark',
                                      )) {
                                        typeList.add('bookmark');
                                      }

                                      // If we are filtering for non-bookmarks (underline_only or note), we can further filter by style
                                      if (selectedCategories.contains(
                                            'underline_only',
                                          ) ||
                                          selectedCategories.contains('note')) {
                                        if (selectedAnnotationTypes.contains(
                                          'underline',
                                        ))
                                          typeList.add('underline');
                                        if (selectedAnnotationTypes.contains(
                                          'highlight',
                                        ))
                                          typeList.add('highlight');
                                      }

                                      // If no specific types added from categories or sub-filters, keep null (all types)
                                      // Exception: If only bookmark was selected, typeList has 'bookmark'.
                                      // If only underline/note selected but no style selected, typeList is empty -> null (all annotation styles)

                                      types = typeList.isEmpty
                                          ? null
                                          : typeList;

                                      // 3. Determine 'color'
                                      // Color usually applies to highlights/underlines.
                                      if (selectedColors.length == 1) {
                                        color = selectedColors.first;
                                      } else {
                                        color = null;
                                      }

                                      // Edge case: If user selects ONLY 'bookmark', hasNote should probably be null (bookmarks might not have notes or might, but usually distinct)
                                      // Our logic above sets hasNote=null if both/neither note/underline_only selected.
                                      // If only bookmark selected, hasNote=null is correct.

                                      notifier.loadNotes(
                                        types: types,
                                        hasNote: hasNote,
                                        color: color,
                                      );

                                      Navigator.pop(ctx);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4A90E2),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      '查看',
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
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTypeIcon({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromARGB(255, 8, 117, 241).withOpacity(0.4)
                  : theme.brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF666666),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? const Color.fromARGB(255, 8, 117, 241)
                    : Colors.transparent,
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected
                  ? const Color.fromARGB(255, 7, 111, 230)
                  : theme.brightness == Brightness.light
                  ? const Color(0xFF666666)
                  : Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF4A90E2)
                  : theme.brightness == Brightness.light
                  ? const Color(0xFF666666)
                  : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, bool isSelected, VoidCallback onTap) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4A90E2).withOpacity(0.4)
              : theme.brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF666666),
          borderRadius: BorderRadius.circular(4),
          border: isSelected
              ? Border.all(color: const Color(0xFF4A90E2), width: 1)
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFF4A90E2)
                : theme.brightness == Brightness.light
                ? const Color(0xFF666666)
                : Colors.white,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _toggleSelection(int? noteId) {
    setState(() {
      if (_selectedNoteIds.contains(noteId)) {
        _selectedNoteIds.remove(noteId);
      } else {
        _selectedNoteIds.add(noteId);
      }
      // Exit selection mode if no items selected
      if (_selectedNoteIds.isEmpty) {
        _isSelectionMode = false;
      }
    });
  }

  void _selectAll(List<BookNote> notes) {
    setState(() {
      if (_selectedNoteIds.length == notes.length) {
        _selectedNoteIds.clear();
        _isSelectionMode = false;
      } else {
        _selectedNoteIds.addAll(notes.map((n) => n.id));
        _isSelectionMode = true;
      }
    });
  }

  void _exitSelectionMode() {
    setState(() {
      _isSelectionMode = false;
      _selectedNoteIds.clear();
    });
  }

  Future<void> _deleteSelectedNotes() async {
    if (_selectedNoteIds.isEmpty) return;

    final count = _selectedNoteIds.length;

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要删除选中的 $count 个笔记吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final notifier = ref.read(
        bookNoteNotifierProvider(widget.book.bookId).notifier,
      );

      // Delete each selected note
      for (final id in _selectedNoteIds) {
        if (id != null) {
          await notifier.removeNote(id: id);
        }
      }

      // Exit selection mode after deletion
      _exitSelectionMode();

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('已删除 $count 个笔记')));
      }
    }
  }

  Widget _buildBottomMenu(List<BookNote> notes) {
    final isSelectedAll =
        notes.isNotEmpty && _selectedNoteIds.length == notes.length;
    final selectedCount = _selectedNoteIds.length;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Select All
            Expanded(
              child: InkWell(
                onTap: () => _selectAll(notes),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelectedAll
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: isSelectedAll
                            ? const Color(0xFF4A90E2)
                            : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '全选',
                        style: TextStyle(
                          color: isSelectedAll
                              ? const Color(0xFF4A90E2)
                              : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Delete
            Expanded(
              child: InkWell(
                onTap: selectedCount > 0 ? _deleteSelectedNotes : null,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: selectedCount > 0 ? Colors.red : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '删除',
                        style: TextStyle(
                          color: selectedCount > 0 ? Colors.red : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Share Image (Disabled)
            Expanded(
              child: InkWell(
                onTap: null, // Disabled as per requirement
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.image_outlined, color: Colors.grey),
                      const SizedBox(height: 4),
                      const Text(
                        '图片分享',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Cancel
            Expanded(
              child: InkWell(
                onTap: _exitSelectionMode,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.close, color: Colors.grey),
                      const SizedBox(height: 4),
                      const Text(
                        '取消',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final bookmark = bookmarks[index];
                  final currentChapter = bookmark.chapter;
                  final isSelected = _selectedNoteIds.contains(bookmark.id);

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
                  children.add(
                    BookNoteTile(
                      note: bookmark,
                      // Enable selection mode on long press
                      onLongPress: () {
                        setState(() {
                          _isSelectionMode = true;
                          _toggleSelection(bookmark.id);
                        });
                      },
                      // Handle tap based on mode
                      onTap: _isSelectionMode
                          ? () => _toggleSelection(bookmark.id)
                          : null, // Default tap behavior can be added here if needed
                      // Show checkbox in trailing if in selection mode
                      trailing: _isSelectionMode
                          ? Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Icon(
                                isSelected
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                                color: isSelected
                                    ? const Color(0xFF4A90E2)
                                    : Colors.grey,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: const SizedBox(width: 24),
                            ), // Placeholder for alignment
                      // Highlight selected item background
                      backgroundColor: isSelected
                          ? const Color(0xFFE8F2FF).withOpacity(0.5)
                          : null,
                    ),
                  );

                  // Add separator if it's not the last item
                  if (index < bookmarks.length - 1) {
                    children.add(const SizedBox(height: 12));
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  );
                },
              ),
            ),
            // Show bottom menu only in selection mode
            if (_isSelectionMode) _buildBottomMenu(bookmarks),
          ],
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
          str: "$numberOfNotes条笔记",
          textStyle: textStyle,
          digitStyle: digitStyle,
        ),
        Text('读到${(bookExtra.readingPercentage * 100).toStringAsFixed(2)}%'),
      ],
    );
  }
}
