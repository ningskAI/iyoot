import 'dart:convert';

import 'package:i_reader/data/models/book_style.dart';
import 'package:i_reader/providers/service_registry.dart';

String generateUrl(
  String url,
  String cfi, {
  BookStyle? bookStyle,
  int? textIndent,
  String? textColor,
  String? fontName,
  String? fontPath,
  String? backgroundColor,
  bool? importing,
  bool isDarkMode = false,
}) {
  final server = readService(AppServices.webserviceManager);
  String indexHtmlPath =
      "http://127.0.0.1:${server.port}/foliate-js/index.html";

  importing ??= false;
  Map<String, dynamic> params = {
    'importing': importing,
    'url': url,
    'initialCfi': cfi,
  };

  String query = '';

  for (var key in params.keys) {
    query += '$key=${Uri.encodeComponent(jsonEncode(params[key]))}&';
  }
  //remove last &
  query = query.substring(0, query.length - 1);

  // query += 'importing=$importing';
  // query += '&url=$url';
  // query += '&initialCfi=$cfi';
  // query += '&style=$style';
  // query += '&readingRules=$readingRules';
  // query += '&style=$style';
  // query += '&readingRules=$readingRules';

  final uri = '$indexHtmlPath?$query';

  return uri;
}
