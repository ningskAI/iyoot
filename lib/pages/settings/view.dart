import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iyoot/common/widgets/view_safe_area.dart';
import 'package:iyoot/models/common/setting_type.dart';
import 'package:iyoot/pages/about/view.dart';
import 'package:iyoot/pages/settings/privacy_setting.dart';
import 'package:iyoot/pages/settings/style_setting.dart';
import 'package:iyoot/pages/settings/video_setting.dart';
import 'package:iyoot/pages/settings/extra_setting.dart';
import 'package:iyoot/pages/settings/play_setting.dart';
import 'package:remixicon/remixicon.dart';

class _SettingsModel {
  final SettingType type;
  final String? subtitle;
  final Icon icon;

  const _SettingsModel({
    required this.type,
    this.subtitle,
    required this.icon
  });
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<StatefulWidget> createState() => _SettingPageState();
}


class _SettingPageState extends State<SettingPage> {
  late SettingType _type = SettingType.privacySetting;
  
  static const List<_SettingsModel> _items = [
    _SettingsModel(
      type: SettingType.privacySetting,
      subtitle: '黑名单、无痕模式',
      icon: Icon(Icons.explore_outlined)
    ),
    _SettingsModel(
      type: SettingType.videoSetting,
      subtitle: '画质、音质、解码、缓冲、音频输出等',
      icon: Icon(Icons.video_settings_outlined),
    ),
    _SettingsModel(
      type: SettingType.playSetting,
      subtitle: '双击/长按、全屏、后台播放、弹幕、字幕、底部进度条等',
      icon: Icon(Icons.touch_app_outlined),
    ),
    _SettingsModel(
      type: SettingType.styleSetting,
      subtitle: '横屏适配（平板）、侧栏、列宽、首页、动态红点、主题、字号、图片、帧率等',
      icon: Icon(Icons.style_outlined),
    ),
    _SettingsModel(
        type: SettingType.interfaceSetting,
        subtitle: '首页、直播接口配置',
        icon: Icon(Remix.link)
    ),
    _SettingsModel(
        type: SettingType.webdavSetting,
        icon: Icon(Icons.live_tv)
    ),
    _SettingsModel(
      type: SettingType.extraSetting,
      subtitle: '震动、搜索、动态代理、更新检查等',
      icon: Icon(Icons.extension_outlined),
    ),
    _SettingsModel(
      type: SettingType.about,
      icon: Icon(Icons.info_outline),
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OrientationBuilder(
        builder: (context, orientation) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: orientation == Orientation.portrait ? const Text("设置") : Text(_type.title),
            ),
            body: ViewSafeArea(
              child: orientation == Orientation.portrait
                ? _buildList(orientation, theme)
                : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: _buildList(orientation, theme),
                    ),
                    VerticalDivider(
                      width: 1,
                      color: theme.colorScheme.outline.withValues(alpha: 0.1),
                    ),
                    Expanded(
                      flex: 6,
                      child: switch (_type) {
                        SettingType.privacySetting => const PrivacySetting(
                          showAppBar: false,
                        ),
                        SettingType.videoSetting => const VideoSetting(
                          showAppBar: false,
                        ),
                        SettingType.playSetting => const PlaySetting(
                          showAppBar: false,
                        ),
                        SettingType.styleSetting => const StyleSetting(
                          showAppBar: false,
                        ),
                        SettingType.extraSetting => const ExtraSetting(
                          showAppBar: false,
                        ),
                        SettingType.interfaceSetting => const ExtraSetting(
                          showAppBar: false,
                        ),
                        SettingType.webdavSetting => const AboutPage(showAppBar: false,),
                        SettingType.about => const AboutPage(showAppBar: false),
                      },
                    )
                  ],
                )
            ),
          );
        }
    );
  }

  Widget _buildSearchItem(ThemeData theme) => Padding(
    padding: const EdgeInsets.only(
      left: 16,
      right: 16,
      bottom: 8,
    ),
    child: Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => Get.toNamed('/settingsSearch'),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color: theme.colorScheme.onInverseSurface,
          ),
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  size: 18,
                  applyTextScaling: true,
                  Icons.search,
                ),
                Text(
                  ' 搜索',
                  style: TextStyle(height: 1),
                  strutStyle: StrutStyle(height: 1, leading: 0),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildList(Orientation orientation,ThemeData theme) {
    final padding = MediaQuery.viewPaddingOf(context);
    TextStyle titleStyle = theme.textTheme.titleMedium!;
    TextStyle subTitleStyle = theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.outline,
    );
    return ListView(
      padding: EdgeInsets.only(bottom: padding.bottom + 100),
      children: [
        _buildSearchItem(theme),
        ..._items
            .take(_items.length - 1)
            .map(
              (item) => ListTile(
            tileColor: _getTileColor(orientation,theme, item.type),
            onTap: () => _toPage(orientation,item.type),
            leading: item.icon,
            title: Text(item.type.title, style: titleStyle),
            subtitle: item.subtitle == null
                ? null
                : Text(item.subtitle!, style: subTitleStyle),
          ),
        ),
      ],
    );
  }

  void _toPage(Orientation orientation, SettingType type) {
    if (orientation == Orientation.portrait) {
      Get.toNamed('/${type.name}');
    } else {
      _type = type;
      setState(() {});
    }
  }

  Color? _getTileColor(Orientation orientation,ThemeData theme, SettingType type) {
    if (orientation == Orientation.portrait) {
      return null;
    } else {
      return type == _type ? theme.colorScheme.onInverseSurface : null;
    }
  }
  
}
