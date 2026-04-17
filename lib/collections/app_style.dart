import 'dart:io';
import 'package:flutter/material.dart';

/// 02 色彩体系 - 封装品牌核心色彩
class AppColors {
  // 核心品牌色：绯红 (Crimson)
  static const Color crimson = Color(0xFFA62121);
  static const Color darkCrimson = Color(0xFFB22222);

  // 亮色模式：纸色 (Paper) 与 墨色 (Ink)
  static const Color paper = Color(0xFFFDFBF7);
  static const Color ink = Color(0xFF2D2D2D);

  // 暗色模式：曜石 (Obsidian) 与 银霜 (Silver)
  static const Color obsidian = Color(0xFF0A0A0A);
  static const Color silver = Color(0xFFE8E8E8);

  static const Color grey666 = Color(0xFF666666);
}

/// 自定义主题扩展 - 方便在代码中直接获取品牌色
class OneReadColors extends ThemeExtension<OneReadColors> {
  final Color? crimson;
  final Color? paper;
  final Color? ink;

  const OneReadColors({
    required this.crimson,
    required this.paper,
    required this.ink,
  });

  @override
  OneReadColors copyWith({Color? crimson, Color? paper, Color? ink}) {
    return OneReadColors(
      crimson: crimson ?? this.crimson,
      paper: paper ?? this.paper,
      ink: ink ?? this.ink,
    );
  }

  @override
  OneReadColors lerp(ThemeExtension<OneReadColors>? other, double t) {
    if (other is! OneReadColors) return this;
    return OneReadColors(
      crimson: Color.lerp(crimson, other.crimson, t),
      paper: Color.lerp(paper, other.paper, t),
      ink: Color.lerp(ink, other.ink, t),
    );
  }
}

class AppStyle {
  // 01 设计之魂 - 亮色主题 (纸色/墨色)
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.paper,
    colorScheme: ColorScheme.light(
      surface: AppColors.paper,
      onSurface: AppColors.ink,
      primary: AppColors.crimson,
    ),
    fontFamily: Platform.isWindows ? "Microsoft YaHei" : null,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: AppColors.ink,
        fontFamily: 'serif',
        fontWeight: FontWeight.bold,
      ),
    ),
    // 04 核心组件 - 输入框样式封装
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.ink.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.crimson, width: 1.0),
      ),
      hintStyle: TextStyle(color: AppColors.ink.withOpacity(0.3), fontSize: 14),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.paper,
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
    ),
    extensions: const [
      OneReadColors(
        crimson: AppColors.crimson,
        paper: AppColors.paper,
        ink: AppColors.ink,
      ),
    ],
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.obsidian,
      onSurface: AppColors.silver,
      primary: AppColors.darkCrimson,
    ),
    fontFamily: Platform.isWindows ? "Microsoft YaHei" : null,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: AppColors.silver,
        fontFamily: 'serif',
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.silver.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.darkCrimson, width: 1.0),
      ),
      hintStyle: TextStyle(
        color: AppColors.silver.withOpacity(0.3),
        fontSize: 14,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black,
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
    ),
    extensions: const [
      OneReadColors(
        crimson: AppColors.darkCrimson,
        paper: AppColors.obsidian,
        ink: AppColors.silver,
      ),
    ],
  );

  static const vGap4 = SizedBox(height: 4);
  static const vGap8 = SizedBox(height: 8);
  static const vGap12 = SizedBox(height: 12);
  static const vGap24 = SizedBox(height: 24);
  static const vGap48 = SizedBox(height: 48);

  static const hGap12 = SizedBox(width: 12);
  static const hGap16 = SizedBox(width: 16);
  static const hGap24 = SizedBox(width: 24);

  static const edgeInsetsA4 = EdgeInsets.all(4);
  static const edgeInsetsA12 = EdgeInsets.all(12);
  static const edgeInsetsA16 = EdgeInsets.all(16);
  static const edgeInsetsH16 = EdgeInsets.symmetric(horizontal: 16);
  static const edgeInsetsV12 = EdgeInsets.symmetric(vertical: 12);

  static BorderRadius radius8 = BorderRadius.circular(8);
  static BorderRadius radius12 = BorderRadius.circular(12);

  static Divider get divider => Divider(
    height: 1,
    thickness: 0.5,
    color: AppColors.grey666.withOpacity(0.1),
  );
}

extension ThemeContextExtension on BuildContext {
  OneReadColors get brandColors => Theme.of(this).extension<OneReadColors>()!;
}
