import 'package:flutter/material.dart';
import 'package:i_reader/data/models/book_note.dart';
import 'package:i_reader/l10n/generated/L10n.dart';
import 'package:i_reader/providers/booknote_provider.dart';
import 'package:i_reader/ui/pages/reading/reading_page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReaderNoteMenu extends ConsumerStatefulWidget {
  const ReaderNoteMenu({
    super.key,
    this.noteId,
    required this.decoration,
    required this.axis,
    required this.onVisibilityChange,
    required this.onSizeChanged,
  });

  final int? noteId;
  final BoxDecoration decoration;
  final Axis axis;
  final ValueChanged<bool> onVisibilityChange;
  final VoidCallback onSizeChanged;

  @override
  ConsumerState<ReaderNoteMenu> createState() => ReaderNoteMenuState();
}

class ReaderNoteMenuState extends ConsumerState<ReaderNoteMenu> {
  BookNote? note;
  bool _showNoteDialog = false;
  final textFieldController = TextEditingController();
  bool showSaveButton = false;

  @override
  void initState() {
    super.initState();
    getNoteDetail(widget.noteId);
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  void _notifyVisibility(bool visible) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onVisibilityChange(visible);
      }
    });
  }

  void _notifySizeChange() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onSizeChanged();
      }
    });
  }

  void _setShowNoteDialog(bool value) {
    if (!mounted) {
      _showNoteDialog = value;
      return;
    }
    if (_showNoteDialog == value) {
      setState(() {});
      _notifySizeChange();
      _notifyVisibility(value);
      return;
    }
    setState(() {
      _showNoteDialog = value;
    });
    _notifyVisibility(value);
    _notifySizeChange();
  }

  Future<void> getNoteDetail(int? id) async {
    if (id == null) return;
    try {
      final notes = await ref.read(bookNoteNotifierProvider(epubPlayerKey.currentState!.widget.book.id).future);
      final fetchedNote = notes.firstWhere((n) => n.id == id, orElse: () => throw Exception('Not found'));
      note = fetchedNote;

      if (note != null && note!.readerNote != null && note!.readerNote!.isNotEmpty) {
        textFieldController.text = note!.readerNote!;
        _setShowNoteDialog(true);
      }
    } finally {
      if (mounted) {
        setState(() {});
        _notifySizeChange();
      }
    }
  }

  Future<void> showNoteDialog(int noteId) async {
    await getNoteDetail(noteId);
    _setShowNoteDialog(true);
  }

  void saveNote() {
    textFieldController.text = textFieldController.text.trim();
    if (note != null) {
      note!.readerNote = textFieldController.text;
      
      // Update the note in database
      final notifier = ref.read(bookNoteNotifierProvider(note!.bookId).notifier);
      // We need to re-add the note with updated readerNote
      final updatedNote = BookNote(
        id: note!.id,
        bookId: note!.bookId,
        content: note!.content,
        cfi: note!.cfi,
        chapter: note!.chapter,
        type: note!.type,
        color: note!.color,
        readerNote: note!.readerNote,
        createTime: note!.createTime,
        updateTime: DateTime.now(),
      );
      
      // Delete old and add new (or implement update in provider)
      notifier.removeNote(id: note!.id);
      notifier.addNote(updatedNote);
    }
    _notifySizeChange();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: widget.axis == Axis.vertical ? double.infinity : 200,
            maxWidth: widget.axis == Axis.vertical ? 100 : double.infinity,
          ),
          child: !_showNoteDialog
              ? null
              : Container(
                  decoration: widget.decoration,
                  padding: const EdgeInsets.all(8),
                  child: Flex(
                    direction: widget.axis,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: TextField(
                            controller: textFieldController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add your thoughts...', // TODO: Add to L10n - L10n.of(context).contextMenuAddNoteTips ?? 'Add your thoughts...',
                            ),
                            maxLines: widget.axis == Axis.vertical ? 10 : 5,
                            minLines: 1,
                            onSubmitted: (String value) {
                              saveNote();
                            },
                            onChanged: (String value) {
                              setState(() {
                                showSaveButton = true;
                              });
                              _notifySizeChange();
                            },
                          ),
                        ),
                      ),
                      if (showSaveButton)
                        IconButton(
                          icon: const Icon(EvaIcons.checkmark_circle_2_outline),
                          onPressed: () {
                            saveNote();
                            FocusScope.of(context).unfocus();
                            setState(() {
                              showSaveButton = false;
                            });
                            _notifySizeChange();
                          },
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
