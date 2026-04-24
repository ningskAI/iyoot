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
  bookStyle ??= AppConfig.getBookStyle();
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
  String bgimgUrl =
      "http://127.0.0.1:${AppConfig.getLastServerPort()}/bgimg/assets/assets/images/bgimg/bg1.jpg";
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
    'codeHighlightTheme': "material-dark",
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
