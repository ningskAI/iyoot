import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract final class StyleString {
  static const double cardSpace = 8;
  static const double safeSpace = 12;
  static const BorderRadius mdRadius = BorderRadius.all(imgRadius);
  static const Radius imgRadius = Radius.circular(10);
  static const double aspectRatio = 16 / 10;
  static const double aspectRatio16x9 = 16 / 9;
  static const double imgMaxRatio = 3.0;
  static const bottomSheetRadius = BorderRadius.vertical(
    top: Radius.circular(18),
  );
  static const dialogFixedConstraints = BoxConstraints(
    minWidth: 420,
    maxWidth: 420,
  );
  static const topBarHeight = 52.0;
  static const buttonStyle = ButtonStyle(
    visualDensity: VisualDensity(
      horizontal: -2,
      vertical: -1.25,
    ),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}

abstract final class Constants {
  static const appName = 'iYooT';
}