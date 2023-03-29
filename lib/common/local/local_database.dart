import 'dart:async';

import 'package:EMO/common/di/injector.dart';
import 'package:EMO/common/entities/entities.dart';

abstract class AppLocalDatabase {
  static AppLocalDatabase get to => AppInjector.injector<AppLocalDatabase>();

  Future<AppLocalDatabase> init();

  Future<void> clear();

  Future<List<T>> getList<T extends AggregateRoot>();

  Future<List<T>> insertList<T extends AggregateRoot>(List<T> list);

  Future<T> insert<T extends AggregateRoot>(T value);

  Stream<T> watch<T extends AggregateRoot>({dynamic key});
}
