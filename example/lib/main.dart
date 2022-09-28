import 'package:flutter/material.dart';
import 'package:flutter_app_layout/flutter_app_layout.dart';

import 'constants.dart';
import 'pages/home.dart';
import 'pages/profile.dart';
import 'transition_builder.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: textAppTitle,
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
      sideMenuTitle: const Text(textMenuTitle),
      routes: <AppRoute>[
        AppRoute(
          path: '/',
          isRoot: true,
          icon: const Icon(Icons.home),
          title: const Text(textHomeTitle),
          builder: (_) => const HomePage(),
        ),
        AppRoute(
          path: '/profile',
          icon: const Icon(Icons.person),
          title: const Text(textProfileTitle),
          builder: (_) => const ProfilePage(),
        ),
      ],
    );
  }
}
