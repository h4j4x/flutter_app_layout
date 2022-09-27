import 'package:flutter_app_layout/src/model/event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EventPublisher<int> publisher;
  late List<IntListener> listeners;

  setUp(() {
    publisher = EventPublisher<int>();
    listeners = <IntListener>[
      IntListener(publisher),
      IntListener(publisher),
      IntListener(publisher),
    ];
  });

  test('subscribed listeners receive events', () {
    // act
    publisher.add(42);
    // assert
    for (IntListener listener in listeners) {
      expect(listener.value, 42);
    }
  });
}

class IntListener implements EventListener<int> {
  var value = 0;

  IntListener(EventPublisher<int> publisher) {
    publisher.addListener(this);
  }

  @override
  void onEvent(int event) {
    value = event;
  }
}
