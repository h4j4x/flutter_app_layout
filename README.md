A flutter package that provides widgets to encapsulate a responsive application layout.

## Features

- Encapsulates and handle navigation.
- Handle responsiveness according to width.
- Provides a menu (visible side menu for desktop side).

## Getting started

The package has no external dependencies or prerequisites to be used, just check out the **Usage** section to get
started.

## Usage

Import this package into your project:

```yaml
flutter_app_layout:
  git:
    url: git://github.com/h4j4x/flutter_app_layout
```

Use `AppLayout` widget:

```dart
import 'package:flutter_app_layout/flutter_app_layout.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      sideMenuTitle: const Text('MENU'), // optional
      routes: <AppRoute>[
        AppRoute( // root route
          path: '/',
          // isRoot is optional, defaults to first route
          isRoot: true,
          icon: const Icon(Icons.home),
          title: const Text(textHomeTitle),
          builder: (_) => const HomePage(),
        ),
        AppRoute( // another route
          path: '/profile',
          icon: const Icon(Icons.person),
          title: const Text(textProfileTitle),
          builder: (_) => const ProfilePage(),
        ),
      ],
    );
  }
}
```

That's it! Longer example can be found in `/example` folder.
