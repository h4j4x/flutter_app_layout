import 'package:flutter/material.dart';

/// todo: docs
class AppRoute {
  /// todo: docs
  final bool isRoot;

  /// todo: docs
  final String path;

  /// todo: docs
  final Widget? icon;

  /// todo: docs
  final Widget title;

  /// todo: docs
  final WidgetBuilder pageBuilder;

  AppRoute({
    this.isRoot = false,
    required this.path,
    this.icon,
    required this.title,
    required this.pageBuilder,
  });
}

class AppRoutes {
  final List<AppRoute> routes;

  AppRoutes(this.routes);

  get length => routes.length;

  AppRoute getRouteByPath(String path) {
    return routes.firstWhere(
      (route) => route.path == path,
      orElse: getRootRoute,
    );
  }

  AppRoute getRootRoute() {
    return routes.firstWhere(
      (route) => route.isRoot,
      orElse: () => routes.first,
    );
  }

  AppRoute? getAtIndex(int index) {
    if (index >= 0 && index < routes.length) {
      return routes[index];
    }
    return null;
  }
}
