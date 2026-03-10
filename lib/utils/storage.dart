import 'dart:convert';
import 'dart:typed_data';

import 'package:hive_flutter/adapters.dart';
import 'package:iyoot/app/utils.dart';
import 'package:iyoot/utils/path_utils.dart';
import 'package:iyoot/utils/storage_pref.dart';
import 'package:path/path.dart' as path;

abstract final class GSStorage {
  static late final Box<dynamic> localCache;
  static late final Box<dynamic> setting;
  static late final Box<dynamic> video;
  static late final Box<Uint8List>? reply;

  static Future<void> init() async {
    await Hive.initFlutter(path.join(appSupportDirPath, 'hive'));
    regAdapter();
    // 本地缓存
    Hive.openBox(
      'localCache',
      compactionStrategy: (int entries, int deletedEntries) {
        return deletedEntries > 4;
      }
    ).then((res) => localCache = res);
    // 设置
    Hive.openBox('setting').then((res) => setting = res);
    // 视频设置
    Hive.openBox('video').then((res) => video = res);
    if (Pref.saveReply) {
      reply = await Hive.openBox<Uint8List>(
        'reply',
        keyComparator: _intStrKeyComparator,
        compactionStrategy: (entries, deletedEntries) {
          return deletedEntries > 10;
        },
      );
    } else {
      reply = null;
    }

  }

  static String exportAllSettings() {
    return Utils.jsonEncoder.convert({
      setting.name: setting.toMap(),
      video.name: video.toMap(),
    });
  }

  static Future<void> importAllSettings(String data) =>
      importAllJsonSettings(jsonDecode(data));

  static Future<bool> importAllJsonSettings(Map<String, dynamic> map) async {
    await Future.wait([
      setting.clear().then((_) => setting.putAll(map[setting.name])),
      video.clear().then((_) => video.putAll(map[video.name])),
    ]);
    return true;
  }

  static void regAdapter() {

  }

  static Future<void> compact() async {
    await Future.wait([
      localCache.compact(),
      setting.compact(),
      video.compact(),
      ?reply?.compact()
    ]);
  }

  static Future<void> close() async {
    await Future.wait([
      localCache.clear(),
      setting.clear(),
      video.clear(),
      ?reply?.clear()
    ]);
  }

  static int _intStrKeyComparator(dynamic k1, dynamic k2) {
    if (k1 is int) {
      if (k2 is int) {
        return k2.compareTo(k1);
      } else {
        return -1;
      }
    } else if (k2 is String) {
      final lenCompare = k2.length.compareTo((k1 as String).length);
      if (lenCompare == 0) {
        return k2.compareTo(k1);
      } else {
        return lenCompare;
      }
    } else {
      return 1;
    }
  }



}