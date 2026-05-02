import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/ui/widgets/book_cover.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';

class BookFullscreenCard extends StatelessWidget {
  final Book book;

  const BookFullscreenCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed("reading", extra: {"book": book, "initialCfi": book.lastReadPosition});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 封面
            Flexible(
              flex: 3,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Hero(
                    tag: book.coverFullPath,
                    child: BookCover(book: book, radius: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // 信息区
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    book.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: HomePalette.primaryText(context)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.author,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: HomePalette.secondaryText(context)),
                  ),
                  if (book.readingPercentage > 0) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          child: LinearProgressIndicator(
                            value: book.readingPercentage.clamp(0.0, 1.0),
                            backgroundColor: HomePalette.lineColor(context),
                            valueColor: AlwaysStoppedAnimation<Color>(HomePalette.accent),
                            minHeight: 4,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${(book.readingPercentage * 100).toStringAsFixed(0)}%',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: HomePalette.accent),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}