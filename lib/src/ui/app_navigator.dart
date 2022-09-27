import 'package:flutter/material.dart';

import '../model/event.dart';

class AppNavigator extends StatefulWidget {
  final bool Function(String) cleanPathOnNavigation;
  final List<Page<dynamic>> pages;
  final PopPageCallback? onPopPage;
  final String? initialRoute;
  final RouteListFactory onGenerateInitialRoutes;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;

  const AppNavigator({
    super.key,
    required this.cleanPathOnNavigation,
    required this.pages,
    this.onPopPage,
    this.initialRoute,
    required this.onGenerateInitialRoutes,
    this.onGenerateRoute,
    this.onUnknownRoute,
  });

  @override
  State<StatefulWidget> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator>
    with NavigatorObserver
    implements EventListener<NavigationEvent> {
  final navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      NavigationEventPublisher().addListener(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navKey,
      pages: widget.pages,
      onPopPage: widget.onPopPage,
      initialRoute: widget.initialRoute,
      onGenerateInitialRoutes: widget.onGenerateInitialRoutes,
      onGenerateRoute: widget.onGenerateRoute,
      onUnknownRoute: widget.onUnknownRoute,
      observers: [this],
    );
  }

  @override
  void onEvent(NavigationEvent event) {
    if (mounted && !event.done) {
      final navigator = navKey.currentState ?? Navigator.of(context);
      if (widget.cleanPathOnNavigation(event.path)) {
        navigator.pushNamedAndRemoveUntil(event.path, (_) => false);
      } else {
        navigator.pushNamed(event.path);
      }
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      NavigationEventPublisher()
          .add(NavigationEvent.done(route.settings.name!));
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute?.settings.name != null) {
      NavigationEventPublisher()
          .add(NavigationEvent.done(previousRoute!.settings.name!));
    }
  }

  @override
  void dispose() {
    NavigationEventPublisher().removeListener(this);
    super.dispose();
  }
}
