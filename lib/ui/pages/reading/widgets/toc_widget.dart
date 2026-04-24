import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/config/app_config.dart';
import 'package:i_reader/data/models/toc.dart';
import 'package:i_reader/providers/book_toc.dart';

class TocWidget extends ConsumerStatefulWidget {
  final Function(Toc) onTocTap;
  final String currentHref;

  const TocWidget({super.key, required this.onTocTap, this.currentHref = ''});

  @override
  ConsumerState<TocWidget> createState() => _TocWidgetState();
}

class _TocWidgetState extends ConsumerState<TocWidget> {
  int _selectedIndex = 1; // 0: 书签, 1: 目录
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tocList = ref.watch(bookTocProvider);
    String bgImg =
        "http://127.0.0.1:${AppConfig.getLastServerPort()}/bgimg/assets/assets/images/bgimg/bg1.jpg";
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(bgImg), fit: BoxFit.fill),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // 顶部指示条
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          // 顶部搜索和切换
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: '版本书',
                          prefixIcon: Icon(Icons.search, size: 20),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _buildSegmentedControl(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 目录列表
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: tocList.length,
              itemBuilder: (context, index) {
                return _buildTocItem(tocList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Container(
      height: 40,
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [_buildSegmentItem(0, "书签"), _buildSegmentItem(1, "目录")],
      ),
    );
  }

  Widget _buildSegmentItem(int index, String title) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withOpacity(0.5)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTocItem(Toc toc, {int depth = 0}) {
    bool isCurrent = toc.href == widget.currentHref;
    bool hasSubitems = toc.subitems.isNotEmpty;

    return Column(
      children: [
        InkWell(
          onTap: () => widget.onTocTap(toc),
          child: Padding(
            padding: EdgeInsets.only(left: depth * 16.0, top: 12, bottom: 12),
            child: Row(
              children: [
                if (hasSubitems)
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Colors.black54,
                  )
                else
                  const SizedBox(width: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    toc.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isCurrent
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: isCurrent ? Colors.green[800] : Colors.black87,
                    ),
                  ),
                ),
                Text(
                  '${toc.percentage}',
                  style: const TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ],
            ),
          ),
        ),
        if (hasSubitems)
          ...toc.subitems.map((sub) => _buildTocItem(sub, depth: depth + 1)),
      ],
    );
  }
}
