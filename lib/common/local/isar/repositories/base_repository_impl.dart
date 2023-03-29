import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:EMO/common/entities/aggregate_root.dart';
import 'package:EMO/common/local/repositories/base_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../isar_type_path.dart';
import '../models/models.dart';

class IsarBaseRepositoryImpl<T extends AggregateRoot, TD extends IsarModel>
    implements BaseRepository<T> {
  @protected
  late final Isar isar;
  @protected
  late final IsarCollection<TD> isarCollection;

  IsarBaseRepositoryImpl()
      : isar = Isar.getInstance()!,
        isarCollection = Isar.getInstance()!.collection<TD>();

  @override
  Future<int> add(T entity) {
    final data = IsarModel.fromEntity(entity) as TD;

    return isar.writeTxn(() => isarCollection.put(data));
  }

  @override
  void addSync(T entity) {
    final data = IsarModel.fromEntity(entity) as TD;

    isar.writeTxnSync(() => isarCollection.putSync(data));
  }

  @override
  Future<Iterable<int>> addRange(Iterable<T> entities) {
    final models = entities.map(IsarModel.fromEntity).cast<TD>().toList();

    return isar.writeTxn(() => isarCollection.putAll(models));
  }

  @override
  void addRangeSync(Iterable<T> entities) {
    final models = entities.map(IsarModel.fromEntity).cast<TD>().toList();

    isar.writeTxnSync(() => isarCollection.putAllSync(models));
  }

  @override
  Future<T> get(dynamic id) async {
    final hashedId = id is Id ? id : fastHash(id);

    final dataModel = await isarCollection.get(hashedId);

    if (dataModel == null) throw Exception("No data for id $id");

    return dataModel.toEntity() as T;
  }

  @override
  T getSync(id) {
    final hashedId = id is Id ? id : fastHash(id);

    final dataModel = isarCollection.getSync(hashedId);

    if (dataModel == null) throw Exception("No data for id $id");

    return dataModel.toEntity() as T;
  }

  @override
  Future<Iterable<T>> getAll() async {
    final data = await isarCollection.where().findAll();

    return data.map((e) => e.toEntity()).cast<T>();
  }

  @override
  Iterable<T> getAllSync() {
    final data = isarCollection.where().findAllSync();

    return data.map((e) => e.toEntity()).cast<T>();
  }

  @override
  Future<bool> remove(T entity) {
    final hashedId = entity.entityId is Id ? entity.entityId as Id : fastHash(entity.entityId);

    return isar.writeTxn(() => isarCollection.delete(hashedId));
  }

  @override
  void removeSync(T entity) {
    final hashedId = entity.entityId is Id ? entity.entityId as Id : fastHash(entity.entityId);

    isar.writeTxnSync(() => isarCollection.deleteSync(hashedId));
  }

  @override
  Future<int> removeRange(Iterable<T> entities) {
    final hashedIds =
        entities.map((e) => e.entityId is Id ? e.entityId as Id : fastHash(e.entityId)).toList();

    return isar.writeTxn(() => isarCollection.deleteAll(hashedIds));
  }

  @override
  void removeRangeSync(Iterable<T> entities) {
    final hashedIds =
        entities.map((e) => e.entityId is Id ? e.entityId as Id : fastHash(e.entityId)).toList();

    isar.writeTxnSync(() => isarCollection.deleteAllSync(hashedIds));
  }

  @override
  Future<int> update(T entity) => add(entity);

  @override
  void updateSync(T entity) => addSync(entity);

  @override
  Stream<T> watch(dynamic id) {
    final hashedId = id is Id ? id : fastHash(id);

    return isarCollection
        .watchObject(hashedId)
        .whereNotNull()
        .map((e) => e.toEntity())
        .cast<T>();
  }

  @override
  Stream<void> watchLazy() => isarCollection.watchLazy();
}
