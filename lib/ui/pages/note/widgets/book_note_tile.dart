import 'package:flutter/material.dart';
import 'package:i_reader/data/models/book_annotation.dart';
import 'package:i_reader/data/models/book_note.dart';
import 'package:i_reader/ui/widgets/card.dart';

class BookNoteTile extends StatelessWidget {
  const BookNoteTile({
    super.key,
    required this.note,
    this.onTap,
    this.onLongPress,
    this.trailing,
    this.backgroundColor,
    this.margin = const EdgeInsets.only(bottom: 8),
  });

  final BookNote note;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? trailing;
  final Color? backgroundColor;
  final EdgeInsetsGeometry margin;

  Widget _buildIcon(Color color) {
    final match = notesType.where((option) => option.type == note.type);
    if (match.isNotEmpty) {
      return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(match.first.icon, size: 15, color: color),
      );
    }
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.bookmark_outline, size: 15, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Color(int.tryParse('0xaa${note.color}') ?? 0xaa555555);
    final infoStyle = const TextStyle(fontSize: 14, color: Colors.grey);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      onSecondaryTap: onLongPress,
      behavior: HitTestBehavior.opaque,
      child: CardView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 20, 20, 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
                child: _buildIcon(iconColor),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(note.content, style: const TextStyle(fontSize: 16)),
                    if (note.readerNote != null && note.readerNote!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                const VerticalDivider(thickness: 3),
                                Expanded(
                                  child: Text(
                                    note.readerNote!,
                                    style: infoStyle.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
