import 'package:flutter/material.dart';

class SettingTile {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;
  final String? route;
  final Widget? trailing;

  const SettingTile({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.iconColor,
    this.route,
    this.trailing,
  });
}
