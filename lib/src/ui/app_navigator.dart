import 'package:flutter/material.dart';

import '../model/app_route.dart';
import '../model/event.dart';

class AppNavigator extends StatefulWidget {
  final AppRoutes routes;

  const AppNavigator({super.key, required this.routes});

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
      onGenerateRoute: (settings) {
        final route = settings.name != null
            ? widget.routes.getRouteByPath(settings.name!)
            : widget.routes.getRootRoute();
        final routeSettings = RouteSettings(
          name: route.path,
          arguments: settings.arguments,
        );
        return MaterialPageRoute(
          builder: route.pageBuilder,
          settings: routeSettings,
        );
      },
      observers: [this],
    );
  }

  @override
  void onEvent(NavigationEvent event) {
    if (mounted && !event.done) {
      final navigator = navKey.currentState ?? Navigator.of(context);
      if (event.route.isRoot) {
        navigator.pushNamedAndRemoveUntil(event.route.path, (_) => false);
      } else {
        navigator.pushNamed(event.route.path);
      }
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name != null) {
      final appRoute = widget.routes.getRouteByPath(route.settings.name!);
      NavigationEventPublisher().add(NavigationEvent.done(appRoute));
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute?.settings.name != null) {
      final appRoute =
          widget.routes.getRouteByPath(previousRoute!.settings.name!);
      NavigationEventPublisher().add(NavigationEvent.done(appRoute));
    }
  }

  @override
  void dispose() {
    NavigationEventPublisher().removeListener(this);
    super.dispose();
  }
}
