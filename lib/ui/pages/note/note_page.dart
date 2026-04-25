import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:i_reader/data/models/book.dart';
import 'package:i_reader/data/models/book_extra.dart';
import 'package:i_reader/providers/book_statistics_provider.dart';
import 'package:i_reader/providers/repository_providers.dart';
import 'package:i_reader/ui/widgets/book_cover.dart';
import 'package:i_reader/ui/widgets/card.dart';
import 'package:i_reader/ui/widgets/highlight_digit.dart';
import 'package:i_reader/ui/widgets/home_shell.dart';
import 'package:i_reader/utils/time_utils.dart';

class NotePage extends ConsumerStatefulWidget {
  const NotePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotePageState();
}

class _NotePageState extends ConsumerState<NotePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: HomePageBackground(
        glowColors: const [Color(0xFF4F7CFF), Color(0xFF7C5CFF)],
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              children: [
                _noteHeader(),
                const SizedBox(height: 20),
                Expanded(child: _noteBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _noteHeader() {
    final bookCount = ref.watch(bookNoteCountProvider);
    return Row(
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '笔记',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: HomePalette.primaryText(context),
                ),
              ),
              const SizedBox(height: 5),
              bookCount.when(
                data: (data) {
                  return Text(
                    "${data['numberOfNotes']}个笔记·落在了${data['numberOfBooks']}本书上",
                    style: TextStyle(fontSize: 12),
                  );
                },
                loading: () {
                  return Text("");
                },
                error: (error, stack) => Text(''),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _noteBody() {
    final noteList = ref.watch(bookExtralListProvider);
    return noteList.when(
      data: (data) {
        if (data.isEmpty) {
          return const Center(child: Text('暂无笔记'));
        } else {
          return ListView.builder(
            padding: EdgeInsets.only(bottom: 80),
            controller: _scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                child: bookNotesItem(data[index]),
              );
            },
          );
        }
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => ErrorWidget(
        error: error,
        onRetry: () => {ref.refresh(bookExtralListProvider)},
      ),
    );
  }

  Widget bookNotesItem(BookExtra bookExtra) {
    TextStyle digitStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    TextStyle textStyle = const TextStyle(fontSize: 20);
    TextStyle titleStyle = const TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 14,
      fontFamily: 'SourceHanSerif',
      fontWeight: FontWeight.w400,
    );
    TextStyle readingTimeStyle = const TextStyle(
      fontSize: 12,
      color: Colors.grey,
    );
    return InkWell(
      onTap: () {
        // 跳转到书籍笔记详情页
        context.pushNamed("book_notes", extra: {"bookExtra": bookExtra});
      },
      child: CardView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HighlightDigit(
                      str: "${bookExtra.numberOfNotes}条笔记",
                      textStyle: textStyle,
                      digitStyle: digitStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(bookExtra.title, style: titleStyle),
                    const SizedBox(height: 18),
                    // Reading time
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            TimeUtils.convertSeconds(
                              context,
                              bookExtra.readingTime,
                            ),
                            style: readingTimeStyle,
                          ),
                          Text(" | ", style: readingTimeStyle),
                          Icon(Icons.bar_chart, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            '${(bookExtra.readingPercentage * 100).toStringAsFixed(1)}%',
                            style: readingTimeStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded(child: SizedBox()),
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
        ),
      ),
    );
  }
}

/// 错误显示Widget
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('加载失败: $error'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('重试')),
          ],
        ),
      ),
    );
  }
}
