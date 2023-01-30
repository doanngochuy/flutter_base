# AppStream Service

The AppStream Service is used to receive events and emit states from method to all listener in the application.

## Usage
Init the AppStream Service in your application with the following code:

```dart
import 'package:flutter_base/common/service/app_stream/app_stream.dart';

void main() {
  injector.registerSingleton<AppStream>(AppStreamImpl());
}
```

### EventStream
In any place in your application:
- You can `add(AppEvent event)` to send an event to all listener. The `add(AppEvent event)` method accepts a `AppEvent` object as the parameter.

```dart
void main() {
  final event = TriggerScanEvent(); // extends AppEvent

  AppStream.to.add(event);
}
```
- You can use `AppStream.to.eventStream.listen((event) { ... })` to listen to the event. The `eventStream` is a `Stream<AppEvent>` object.

```dart
void main() {
  AppStream.to.eventStream.whereType<TriggerScanEvent>().listen((event) {
    // do something
  });
}
```

### StateStream
In any place in your application
- You can `emit(AppState state)` to send a state to all listener. The `add(AppState state)` method accepts a `AppState` object as the parameter.

```dart
void main() {
  final state = CodeScanned(capture); // extends AppState

  AppStream.to.emit(state);
}
```

- You can use `AppStream.to.stateStream.listen((state) { ... })` to listen to the state. The `stateStream` is a `Stream<AppState>` object.

```dart
void main() {
  AppStream.to.stateStream.whereType<CodeScanned>().listen((state) {
    // do something
  });
}
```
