import 'dart:convert';

import 'package:i_reader/config/app_config.dart';
import 'package:i_reader/data/models/book_style.dart';
import 'package:i_reader/data/models/font_model.dart';
import 'package:i_reader/data/models/reading_theme.dart';
import 'package:i_reader/utils/color_utils.dart';

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
  String indexHtmlPath =
      "http://127.0.0.1:${AppConfig.getLastServerPort()}/foliate-js/index.html";

  ReadingTheme readTheme = ReadingTheme(
    backgroundColor: "FFFBFBF3",
    textColor: "FF343434",
    backgroundImagePath: "",
  );
  bookStyle ??= BookStyle(
    fontSize: 1.4,
    fontFamily: 'Arial',
    fontWeight: 400,
    lineHeight: 1.8,
    letterSpacing: 0.0,
    wordSpacing: 0.0,
    paragraphSpacing: 1.0,
    sideMargin: 6.0,
    topMargin: 90.0,
    bottomMargin: 50.0,
    indent: 0,
    maxColumnCount: 0,
    headingFontSize: 1.0,
    columnThreshold: 720.0,
  );
  textColor ??= readTheme.textColor;
  final font = FontModel(
    label: "测试",
    name: 'customFont0',
    path: 'SourceHanSerifSC-Regular.otf',
  );

  fontName = font.name;
  fontPath = font.path;
  backgroundColor ??= readTheme.backgroundColor;
  importing ??= false;

  textColor = ColorUtils.convertDartColorToJs(textColor);
  backgroundColor = ColorUtils.convertDartColorToJs(backgroundColor);

  // Get effective background image URL using the new method
  String bgimgUrl = "";
  // const importing = $importing
  // const url = '${replaceSingleQuote(url)}'
  // let initialCfi = '${replaceSingleQuote(cfi)}'
  // let style = {
  //     fontSize: ${bookStyle.fontSize},
  //     fontName: '${replaceSingleQuote(fontName)}',
  //     fontPath: '${replaceSingleQuote(fontPath)}',
  //     fontWeight: ${bookStyle.fontWeight},
  //     letterSpacing: ${bookStyle.letterSpacing},
  //     spacing: ${bookStyle.lineHeight},
  //     paragraphSpacing: ${bookStyle.paragraphSpacing},
  //     textIndent: ${bookStyle.indent},
  //     fontColor: '#$textColor',
  //     backgroundColor: '#$backgroundColor',
  //     topMargin: ${bookStyle.topMargin},
  //     bottomMargin: ${bookStyle.bottomMargin},
  //     sideMargin: ${bookStyle.sideMargin},
  //     justify: true,
  //     hyphenate: true,
  //     pageTurnStyle: '${Prefs().pageTurnStyle.name}',
  //     maxColumnCount: ${bookStyle.maxColumnCount},
  // }

  // let readingRules = {
  //   convertChineseMode: '${Prefs().readingRules.convertChineseMode.name}',
  //   bionicReadingMode: ${Prefs().readingRules.bionicReading},
  // }

  Map<String, dynamic> style = {
    'fontSize': bookStyle.fontSize,
    'fontName': fontName,
    'fontPath': fontPath,
    'fontWeight': bookStyle.fontWeight,
    'letterSpacing': bookStyle.letterSpacing,
    'spacing': bookStyle.lineHeight,
    'paragraphSpacing': bookStyle.paragraphSpacing,
    'textIndent': bookStyle.indent,
    'fontColor': '#$textColor',
    'backgroundColor': '#$backgroundColor',
    'topMargin': bookStyle.topMargin,
    'bottomMargin': bookStyle.bottomMargin,
    'sideMargin': bookStyle.sideMargin,
    'justify': true,
    'hyphenate': false,
    'pageTurnStyle': "slide",
    'maxColumnCount': bookStyle.maxColumnCount,
    'columnThreshold': bookStyle.columnThreshold,
    'textAlign': "auto",
    'backgroundImage': bgimgUrl,
    'allowScript': true,
    'customCSS': "",
    'customCSSEnabled': true,
    'useBookStyles': true,
    'headingFontSize': bookStyle.headingFontSize,
    'codeHighlightTheme': "default",
  };

  Map<String, dynamic> readingRules = {};

  Map<String, dynamic> params = {
    'importing': importing,
    'url': url,
    'initialCfi': cfi,
    'style': style,
    'readingRules': readingRules,
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
