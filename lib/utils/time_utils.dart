import 'package:flutter/material.dart';

abstract class TimeUtils {
  static String convertSeconds(BuildContext context, int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/ 60;
    final int second = seconds % 60;
    if (hours > 0) {
      return "$hours小时$minutes分";
    } else if (minutes > 0) {
      return "$minutes分钟";
    } else {
      return "$seconds秒";
    }
  }
}
