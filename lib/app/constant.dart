import 'package:iyoot/models/home_page_item.dart';
import 'package:remixicon/remixicon.dart';

class Constant {
    static final Map<String, HomePageItem> allHomePages = {
      "recommend": HomePageItem(
        iconData: Remix.home_smile_line,
        title: "首页",
        index: 0
      ),
      "duanju": HomePageItem(
        iconData: Remix.play_line,
        title: "短剧",
        index: 1
      ),
      "live": HomePageItem(
        iconData: Remix.live_line,
        title: "直播",
        index: 2
      ),
      "mine": HomePageItem(
        iconData: Remix.user_smile_line,
        title: "我的",
        index: 3
      )
    };
}
