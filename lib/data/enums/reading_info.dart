enum ReadingInfoEnum {
  none,
  chapterTitle,
  chapterProgress,
  bookProgress,
  battery,
  time,
  batteryAndTime,
}

extension ReadingInfoL10n on ReadingInfoEnum {
  String getL10n() {
    switch (this) {
      case ReadingInfoEnum.none:
        return "无";
      case ReadingInfoEnum.chapterTitle:
        return "章节标题";
      case ReadingInfoEnum.battery:
        return "电量";
      case ReadingInfoEnum.time:
        return "时间";
      case ReadingInfoEnum.batteryAndTime:
        return "电量和时间";
      case ReadingInfoEnum.chapterProgress:
        return "本章进度";
      case ReadingInfoEnum.bookProgress:
        return "全书进度";
    }
  }
}

extension ReadingInfoEnumJson on ReadingInfoEnum {
  String toJson() {
    return name;
  }

  static ReadingInfoEnum fromJson(String json) {
    return ReadingInfoEnum.values.firstWhere((e) => e.name == json);
  }
}
