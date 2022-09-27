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
  final String path;
  final bool done;

  NavigationEvent.done(this.path) : done = true;

  NavigationEvent.pendent(this.path) : done = false;
}

class NavigationEventPublisher extends EventPublisher<NavigationEvent> {
  static NavigationEventPublisher? _instance;

  NavigationEventPublisher._();

  factory NavigationEventPublisher() {
    _instance ??= NavigationEventPublisher._();
    return _instance!;
  }
}
