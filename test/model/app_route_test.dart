import 'package:flutter/material.dart';
import 'package:flutter_app_layout/src/model/app_route.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppRoute rootRoute;
  late AppRoute otherRoute;
  late AppRoute lastRoute;
  late AppRoutes routes;

  setUp(() {
    rootRoute = AppRoute(
      isRoot: true,
      path: '/',
      title: const Text('home'),
      builder: (_) => Container(),
    );
    otherRoute = AppRoute(
      path: '/other',
      title: const Text('other'),
      builder: (_) => Container(),
    );
    lastRoute = AppRoute(
      path: '/last',
      title: const Text('last'),
      builder: (_) => Container(),
    );
    routes = AppRoutes([rootRoute, otherRoute, lastRoute]);
  });

  group('app routes find correct routes', () {
    test('find correct root route', () {
      // act
      final route = routes.getRootRoute();
      // assert
      expect(route, rootRoute);
    });

    test('find correct route by path', () {
      // act
      final route = routes.getRouteByPath(otherRoute.path);
      // assert
      expect(route, otherRoute);
    });

    test('return root route on invalid path', () {
      // act
      final route = routes.getRouteByPath('/invalid');
      // assert
      expect(route, rootRoute);
    });

    test('find correct route at index', () {
      // act
      final route = routes.getRouteAtIndex(routes.length - 1);
      // assert
      expect(route, lastRoute);
    });

    test('return null on invalid index', () {
      // act
      final route = routes.getRouteAtIndex(routes.length);
      // assert
      expect(route, isNull);
    });
  });
}
