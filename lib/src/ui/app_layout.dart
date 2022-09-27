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
  final List<AppRoute> sideMenuRoutes;

  /// todo: docs
  final bool Function(String)? cleanPathOnNavigation;

  /// todo: redirect to Navigator pages docs
  final List<Page<dynamic>> pages;

  /// todo: redirect to Navigator onPopPage docs
  final PopPageCallback? onPopPage;

  /// todo: redirect to Navigator initialRoute docs
  final String? initialRoute;

  /// todo: redirect to Navigator onGenerateInitialRoutes docs
  final RouteListFactory onGenerateInitialRoutes;

  /// todo: redirect to Navigator onGenerateRoute docs
  final RouteFactory? onGenerateRoute;

  /// todo: redirect to Navigator onUnknownRoute docs
  final RouteFactory? onUnknownRoute;

  const AppLayout({
    super.key,
    this.sideMenuWidth = 260.0,
    this.sideMenuDecoration,
    this.sideMenuTitle,
    required this.sideMenuRoutes,
    this.cleanPathOnNavigation,
    this.pages = const <Page<dynamic>>[],
    this.onPopPage,
    this.initialRoute,
    this.onGenerateInitialRoutes = Navigator.defaultGenerateInitialRoutes,
    this.onGenerateRoute,
    this.onUnknownRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: mobile(),
      desktop: desktop(),
    );
  }

  // todo: fixme
  Widget mobile() {
    return AppNavigator(
      cleanPathOnNavigation: cleanPathOnNavigation ?? (_) => false,
      pages: pages,
      onPopPage: onPopPage,
      initialRoute: initialRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onGenerateRoute: onGenerateRoute,
      onUnknownRoute: onUnknownRoute,
    );
  }

  Widget desktop() {
    return Row(
      children: [
        AppMenu(
          width: sideMenuWidth,
          initialRoute: initialRoute,
          decoration: sideMenuDecoration,
          title: sideMenuTitle,
          routes: sideMenuRoutes,
        ),
        Expanded(
          child: AppNavigator(
            cleanPathOnNavigation: cleanPathOnNavigation ?? (_) => false,
            pages: pages,
            onPopPage: onPopPage,
            initialRoute: initialRoute,
            onGenerateInitialRoutes: onGenerateInitialRoutes,
            onGenerateRoute: onGenerateRoute,
            onUnknownRoute: onUnknownRoute,
          ),
        ),
      ],
    );
  }
}
