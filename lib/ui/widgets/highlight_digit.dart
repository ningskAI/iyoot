import 'package:flutter/material.dart';

class HighlightDigit extends StatelessWidget {
  final String str;
  final TextStyle textStyle;
  final TextStyle digitStyle;

  const HighlightDigit({
    super.key,
    required this.str,
    required this.textStyle,
    required this.digitStyle,
  });

  @override
  Widget build(BuildContext context) {
    final String beforeDigit = str.split(RegExp(r'\d')).first;
    final String digit = str.replaceAll(RegExp(r'[^0-9]'), '');
    if (digit.isEmpty) return Text(str, style: textStyle);
    final String afterDigit = str.split(RegExp(r'\d')).last;

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: beforeDigit, style: textStyle),
          TextSpan(text: digit, style: digitStyle),
          TextSpan(text: afterDigit, style: textStyle),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
