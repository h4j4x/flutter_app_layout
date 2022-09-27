import 'package:flutter_app_layout/flutter_app_layout.dart';

abstract class EventListener<T> {
  void onEvent(T event);
}

class EventPublisher<T> {
  final _listeners = <EventListener<T>>{};

  void addListener(EventListener<T> listener) {
    _listeners.add(listener);
  }

  void removeListener(EventListener<T> listener) {
    _listeners.remove(listener);
  }

  void add(T event) {
    for (var listener in _listeners) {
      listener.onEvent(event);
    }
  }
}

class NavigationEvent {
  final AppRoute route;
  final bool done;

  NavigationEvent.done(this.route) : done = true;

  NavigationEvent.pending(this.route) : done = false;
}

class NavigationEventPublisher extends EventPublisher<NavigationEvent> {
  static NavigationEventPublisher? _instance;

  NavigationEventPublisher._();

  factory NavigationEventPublisher() {
    _instance ??= NavigationEventPublisher._();
    return _instance!;
  }
}
