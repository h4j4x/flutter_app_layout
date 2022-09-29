import 'package:flutter/material.dart';

/// Class containing information about routes on the application.
///
/// On desktop size the built [Widget] will render on the right side of the menu.
///
/// See also:
///
///  * [WidgetBuilder]
class AppRoute {
  /// If this route is the root of the application.
  ///
  /// Also known as the initial route.
  /// In case of duplication, first defined will be used.
  final bool isRoot;

  /// Named path for the route.
  ///
  /// In case of duplication, first defined will be used.
  final String path;

  /// Optional [Widget] to use as icon for the side menu.
  final Widget? icon;

  /// [Widget] to use as title for the side menu.
  final Widget title;

  /// The builder to render the route content.
  final WidgetBuilder builder;

  AppRoute({
    this.isRoot = false,
    required this.path,
    this.icon,
    required this.title,
    required this.builder,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppRoute &&
          runtimeType == other.runtimeType &&
          path == other.path;

  @override
  int get hashCode => path.hashCode;
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

  AppRoute? getRouteAtIndex(int index) {
    if (index >= 0 && index < routes.length) {
      return routes[index];
    }
    return null;
  }
}
