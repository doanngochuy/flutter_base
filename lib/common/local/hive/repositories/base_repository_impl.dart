import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:EMO/common/entities/aggregate_root.dart';
import 'package:EMO/common/local/repositories/base_repository.dart';

import '../hive_service_impl.dart' as hive_service;
import '../models/models.dart';

class HiveBaseRepositoryImpl<T extends AggregateRoot, TD extends HiveModel>
    implements BaseRepository<T> {
  @protected
  late final Box<TD> box;

  HiveBaseRepositoryImpl() : box = hive_service.getBox<T, TD>();

  @override
  Future<int> add(T entity) async {
    final data = HiveModel.fromEntity(entity) as TD;

    await box.put(data.hiveKey, data);

    return data.hiveKey;
  }

  @override
  Future<void> addRange(Iterable<T> entities) async {
    final models = Map.fromEntries(
      entities.map(HiveModel.fromEntity).map((e) => MapEntry(e.hiveKey, e as TD)),
    );

    return box.putAll(models);
  }

  @override
  void addRangeSync(Iterable<T> entities) {
    final models = Map.fromEntries(
      entities.map(HiveModel.fromEntity).map((e) => MapEntry(e.hiveKey, e as TD)),
    );

    box.putAll(models);
  }

  @override
  void addSync(T entity) {
    final data = HiveModel.fromEntity(entity) as TD;

    box.put(data.hiveKey, data);
  }

  @override
  Future<T> get(id) {
    final dataModel = box.get(id);

    if (dataModel == null) throw Exception("No data for id $id");

    return Future.value(dataModel.toEntity() as T);
  }

  @override
  T getSync(id) {
    final dataModel = box.get(id);

    if (dataModel == null) throw Exception("No data for id $id");

    return dataModel.toEntity() as T;
  }

  @override
  Future<Iterable<T>> getAll() {
    final dataModels = box.values;

    return Future.value(dataModels.map((e) => e.toEntity()).cast<T>());
  }

  @override
  Iterable<T> getAllSync() {
    final dataModels = box.values;

    return dataModels.map((e) => e.toEntity()).cast<T>();
  }

  @override
  Future<bool> remove(T entity) async {
    final data = HiveModel.fromEntity(entity) as TD;

    try {
      await box.delete(data.hiveKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void removeSync(T entity) {
    final data = HiveModel.fromEntity(entity) as TD;

    try {
      box.delete(data.hiveKey);
    } catch (e) {
      return;
    }
  }

  @override
  Future<int> removeRange(Iterable<T> entities) async {
    final keys = entities.map(HiveModel.fromEntity).map((e) => e.hiveKey);

    try {
      await box.deleteAll(keys);
      return keys.length;
    } catch (e) {
      return Future.value(0);
    }
  }

  @override
  void removeRangeSync(Iterable<T> entities) {
    final keys = entities.map(HiveModel.fromEntity).map((e) => e.hiveKey);

    try {
      box.deleteAll(keys);
    } catch (e) {
      return;
    }
  }

  @override
  Future<int> update(T entity) {
    final data = HiveModel.fromEntity(entity) as TD;

    try {
      box.put(data.hiveKey, data);
      return Future.value(data.hiveKey);
    } catch (e) {
      return Future.value(0);
    }
  }

  @override
  void updateSync(T entity) {
    final data = HiveModel.fromEntity(entity) as TD;

    try {
      box.put(data.hiveKey, data);
    } catch (e) {
      return;
    }
  }

  @override
  Stream<T> watch(id) => box.watch(key: id).map((event) => event.value.toEntity() as T);

  @override
  Stream<void> watchLazy() => box.watch().map((_) {});
}
