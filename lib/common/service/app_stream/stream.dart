import 'dart:async';

import 'package:flutter_base/common/di/injector.dart';

import 'events/events.dart';
import 'states/states.dart';

abstract class AppStream {
  static AppStream get to => AppInjector.injector<AppStream>();

  Stream<AppEvent> get eventStream;

  Stream<AppState> get stateStream;

  void add(AppEvent event);

  void emit(AppState state);
}

class AppStreamImpl implements AppStream {
  final _eventStreamController = StreamController<AppEvent>.broadcast();
  final _stateStreamController = StreamController<AppState>.broadcast();

  @override
  void add(AppEvent event) => _eventStreamController.add(event);

  @override
  void emit(AppState state) => _stateStreamController.add(state);

  @override
  Stream<AppEvent> get eventStream => _eventStreamController.stream;

  @override
  Stream<AppState> get stateStream => _stateStreamController.stream;
}
