import 'package:flutter/material.dart';

import '../model/app_route.dart';
import 'app_menu.dart';
import 'app_navigator.dart';
import 'responsive.dart';

/// todo: docs
class AppLayout extends StatelessWidget {
  /// todo: docs
  final double sideMenuWidth;

  /// todo: docs
  final BoxDecoration? sideMenuDecoration;

  /// todo: docs
  final Widget? sideMenuTitle;

  /// todo: docs
  final List<AppRoute> routes;

  AppLayout({
    super.key,
    this.sideMenuWidth = 260.0,
    this.sideMenuDecoration,
    this.sideMenuTitle,
    required this.routes,
  }) : assert(routes.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    final routes = AppRoutes(this.routes);
    final navigator = AppNavigator(routes: routes);
    return ResponsiveWidget(
      mobile: mobile(routes, navigator),
      desktop: desktop(routes, navigator),
    );
  }

  Widget mobile(AppRoutes routes, AppNavigator navigator) {
    // todo: drawer with routes ????
    return navigator;
  }

  Widget desktop(AppRoutes routes, AppNavigator navigator) {
    return Row(
      children: [
        AppMenu(
          width: sideMenuWidth,
          decoration: sideMenuDecoration,
          title: sideMenuTitle,
          routes: routes,
        ),
        Expanded(
          child: navigator,
        ),
      ],
    );
  }
}
