import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i_reader/services/logger/logger.dart';

final logsProvider = StreamProvider.autoDispose((ref) async* {
  final file = await AppLogger.getLogsPath();
  if (await file.length() == 0) {
    throw StateError("Logs file is empty or non-existent");
  }
  final stream = file.openRead().transform(utf8.decoder);

  await for (final line in stream) {
    yield line;
  }
});
