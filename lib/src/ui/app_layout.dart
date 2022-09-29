import 'package:flutter/material.dart';

import '../model/app_route.dart';
import 'app_menu.dart';
import 'app_navigator.dart';
import 'responsive.dart';

/// A widget that encapsulates a responsive application layout.
///
/// [AppLayout] is a widget that contains and handle navigation, provides a menu
/// and handle responsiveness according to width. Does not contains any
/// [Scaffold] widget inside.
///
/// See also:
///
///  * [AppRoute], the required children that are the content of the
///  encapsulated application.
class AppLayout extends StatelessWidget {
  /// Width size for the side menu on desktop size.
  ///
  /// Defaults to 260.
  final double sideMenuWidth;

  /// Optional [BoxDecoration] for the side menu on desktop size.
  final BoxDecoration? sideMenuDecoration;

  /// Optional [Widget] for title of the side menu on desktop size.
  final Widget? sideMenuTitle;

  /// List of [AppRoute] that are the content of the encapsulated application.
  ///
  /// If not route with [AppRoute.isRoot] is defined, the first route is assumed
  /// as the root. If multiple root routes are defined, first in list will be
  /// the actual root.
  ///
  /// Navigation to the root route handled by the side menu will
  /// automatically clean the navigation history.
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
