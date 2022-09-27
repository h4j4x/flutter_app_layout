import 'package:flutter/material.dart';
import 'package:flutter_app_layout/flutter_app_layout.dart';

void main() {
  runApp(const ExampleApp());
}

class AppTransitionBuilder extends PageTransitionsBuilder {
  const AppTransitionBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    final tween =
        Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.ease));
    return ScaleTransition(
      scale: animation.drive(tween),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App Layout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.macOS: AppTransitionBuilder(),
        }),
      ),
      home: const LayoutPage(),
    );
  }
}

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sideMenuDecoration: const BoxDecoration(
        color: Colors.blueGrey,
      ),
      sideMenuTitle: const Text('Menu'),
      sideMenuRoutes: <AppRoute>[
        AppRoute(
          route: '/',
          icon: const Icon(Icons.home),
          title: const Text('Home'),
        ),
        AppRoute(
          route: '/profile',
          icon: const Icon(Icons.person),
          title: const Text('Profile'),
        ),
      ],
      cleanPathOnNavigation: (path) => path == '/',
      onGenerateRoute: (settings) {
        Widget? page;
        var routeName = settings.name;
        if (settings.name == '/profile') {
          page = const ProfilePage();
        }
        if (page == null) {
          routeName = '/';
          page = const HomePage();
        }
        final routeSettings = RouteSettings(
          name: routeName,
          arguments: settings.arguments,
        );
        return MaterialPageRoute(
          builder: (_) => page!,
          settings: routeSettings,
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: const Center(
          child: Text('Home'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next_sharp),
        onPressed: () {
          Navigator.of(context).pushNamed('/profile');
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: const Center(
          child: Text('Profile'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_before_sharp),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
