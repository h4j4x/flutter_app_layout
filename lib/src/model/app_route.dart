import 'package:flutter/material.dart';

class AppRoute {
  final String route;
  final Widget? icon;
  final Widget title;

  AppRoute({
    required this.route,
    this.icon,
    required this.title,
  });
}
