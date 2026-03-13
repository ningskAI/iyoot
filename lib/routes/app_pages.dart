import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:iyoot/pages/about/view.dart';
import 'package:iyoot/pages/indexed/indexed_controller.dart';
import 'package:iyoot/pages/indexed/indexed_page.dart';
import 'package:iyoot/pages/settings/extra_setting.dart';
import 'package:iyoot/pages/settings/play_setting.dart';
import 'package:iyoot/pages/settings/privacy_setting.dart';
import 'package:iyoot/pages/settings/style_setting.dart';
import 'package:iyoot/pages/settings/video_setting.dart';
import 'package:iyoot/pages/settings/view.dart';

class AppPages {
  AppPages._();

  static final routes = [
    // 首页
    GetPage(
      name: '/',
      page: () => const IndexedPage(),
      bindings: [
        BindingsBuilder.put(() => IndexedController()),
      ],
    ),
    // 设置
    GetPage(name: '/setting', page: () => const SettingPage()),
    // 关于
    GetPage(name: '/about', page: () => const AboutPage()),
    // 音视频设置
    GetPage(name: '/videoSetting', page: () => const VideoSetting()),
    // 播放器设置
    GetPage(name: '/playSetting', page: () => const PlaySetting()),
    // 外观设置
    GetPage(name: '/styleSetting', page: () => const StyleSetting()),
    // 隐私设置
    GetPage(name: '/privacySetting', page: () => const PrivacySetting()),
    // 其它设置
    GetPage(name: '/extraSetting', page: () => const ExtraSetting()),
  ];

}