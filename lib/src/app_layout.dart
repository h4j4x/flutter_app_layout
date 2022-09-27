import 'package:flutter/material.dart';

import 'app_navigator.dart';

/// todo: docs
class AppLayout extends StatelessWidget {
  /// todo: docs
  final double sideMenuWidth;

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
    return Row(
      children: [
        SideMenu(
          width: sideMenuWidth,
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
