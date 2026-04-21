import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:i_reader/data/models/book.dart';

class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.book,
    this.height,
    this.width,
    this.radius,
  });

  final Book book;
  final double? height;
  final double? width;
  final double? radius;

  // Calculate text color based on background brightness
  Color _getContrastColor(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final double effectiveRadius = radius ?? 8;
    final BorderRadius borderRadius = BorderRadius.only(
      topRight: Radius.circular(effectiveRadius),
      bottomRight: Radius.circular(effectiveRadius),
    );
    final File file = File(book.coverFullPath);
    final double spineWidth = 12; // 书脊宽度

    Widget child;

    if (file.existsSync()) {
      child = Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: FileImage(file), fit: BoxFit.fill),
        ),
      );
    } else {
      // Default cover with responsive text and icon
      child = LayoutBuilder(
        builder: (context, constraints) {
          final coverWidth = constraints.maxWidth;

          // Calculate responsive sizes based on width
          final titleFontSize = coverWidth * 0.12;
          final authorFontSize = coverWidth * 0.08;
          final iconSize = coverWidth * 0.8;
          final padding = coverWidth * 0.08;

          final backgroundColor = Colors
              .primaries[book.title.hashCode % Colors.primaries.length]
              .shade200;
          final textColor = _getContrastColor(backgroundColor);

          final showTitle = true;
          final showAuthor = true;

          return Container(
            color: backgroundColor,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title at top
                      if (showTitle)
                        Text(
                          book.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            height: 1.2,
                          ),
                        ),
                      const Spacer(),
                      // Author at bottom
                      if (showAuthor)
                        Text(
                          book.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: authorFontSize,
                            fontWeight: FontWeight.w300,
                            color: textColor,
                          ),
                        ),
                    ],
                  ),
                ),
                // Icon at bottom right corner with rotation
                Positioned(
                  right: -padding * 0.8,
                  bottom: -padding * 0.5,
                  child: Transform.rotate(
                    angle: 15 * math.pi / 180, // 15 degrees in radians
                    child: Icon(
                      Icons.book,
                      size: iconSize,
                      color: textColor.withValues(alpha: 0.1),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    final RoundedSuperellipseBorder borderShape = RoundedSuperellipseBorder(
      borderRadius: borderRadius,
      side: const BorderSide(width: 0.3, color: Colors.grey),
    );

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          // 外侧阴影（更强的层次感，放在最底层）
          Positioned(
            left: -spineWidth * 1.05,
            top: 0,
            bottom: 0,
            child: Container(
              width: spineWidth * 1.2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Colors.black.withOpacity(0.32), Colors.transparent],
                ),
              ),
            ),
          ),

          // 主书籍封面
          DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: ShapeDecoration(shape: borderShape),
            child: ClipRSuperellipse(borderRadius: borderRadius, child: child),
          ),

          // 书脊效果（左侧）
          Positioned(
            left: -spineWidth * 0.5,
            top: 0,
            bottom: 0,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(-0.25),
              alignment: Alignment.centerRight,
              child: Container(
                width: spineWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.black.withOpacity(0.22),
                      Colors.black.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(effectiveRadius),
                    bottomLeft: Radius.circular(effectiveRadius),
                  ),
                ),
              ),
            ),
          ),

          // 书脊内侧高光（窄带，增加真实感）
          Positioned(
            left: -spineWidth * 0.35,
            top: height != null ? (height! * 0.08) : 4,
            bottom: height != null ? (height! * 0.08) : 4,
            child: Container(
              width: spineWidth * 0.28,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.white.withOpacity(0.12), Colors.transparent],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(effectiveRadius * 0.6),
                  bottomLeft: Radius.circular(effectiveRadius * 0.6),
                ),
              ),
            ),
          ),

          // 近侧阴影（靠近封面边缘，增强层次）
          Positioned(
            left: -spineWidth * 0.02,
            top: 0,
            bottom: 0,
            child: Container(
              width: spineWidth * 0.9,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.black.withOpacity(0.18), Colors.transparent],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(effectiveRadius),
                  bottomLeft: Radius.circular(effectiveRadius),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
