import 'package:flutter/foundation.dart';
import 'package:isarx/isarx.dart';
import 'package:flutter_base/common/entities/aggregate_root.dart';
import 'package:flutter_base/common/local/repositories/base_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../isarx_type_path.dart';
import '../models/models.dart';

class IsarXBaseRepositoryImpl<T extends AggregateRoot, TD extends IsarXModel>
    implements BaseRepository<T> {
  @protected
  late final Isar isar;
  @protected
  late final IsarCollection<TD> isarCollection;

  IsarXBaseRepositoryImpl()
      : isar = Isar.getInstance()!,
        isarCollection = Isar.getInstance()!.getCollection<TD>();

  @override
  Future<int> add(T entity) {
    final data = IsarXModel.fromEntity(entity) as TD;

    return isar.writeTxn((isar) => isarCollection.put(data));
  }

  @override
  void addSync(T entity) {
    final data = IsarXModel.fromEntity(entity) as TD;

    isar.writeTxnSync((isar) => isarCollection.putSync(data));
  }

  @override
  Future<Iterable<int>> addRange(Iterable<T> entities) {
    final models = entities.map(IsarXModel.fromEntity).cast<TD>().toList();

    return isar.writeTxn((isar) => isarCollection.putAll(models));
  }

  @override
  void addRangeSync(Iterable<T> entities) {
    final models = entities.map(IsarXModel.fromEntity).cast<TD>().toList();

    isar.writeTxnSync((isar) => isarCollection.putAllSync(models));
  }

  @override
  Future<T> get(dynamic id) async {
    final hashedId = id is int ? id : fastHash(id);

    final dataModel = await isarCollection.get(hashedId);

    if (dataModel == null) throw Exception("No data for id $id");

    return dataModel.toEntity() as T;
  }

  @override
  T getSync(id) {
    print("getSync: ${isarCollection.runtimeType}");

    final hashedId = id is int ? id : fastHash(id);

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
    print("getAllSync: ${isarCollection.runtimeType}");
    final data = isarCollection.where().findAllSync();

    return data.map((e) => e.toEntity()).cast<T>();
  }

  @override
  Future<bool> remove(T entity) {
    final hashedId = entity.entityId is int ? entity.entityId as int : fastHash(entity.entityId);

    return isar.writeTxn((isar) => isarCollection.delete(hashedId));
  }

  @override
  void removeSync(T entity) {
    final hashedId = entity.entityId is int ? entity.entityId as int : fastHash(entity.entityId);

    isar.writeTxnSync((isar) => isarCollection.deleteSync(hashedId));
  }

  @override
  Future<int> removeRange(Iterable<T> entities) {
    final hashedIds =
        entities.map((e) => e.entityId is int ? e.entityId as int : fastHash(e.entityId)).toList();

    return isar.writeTxn((isar) => isarCollection.deleteAll(hashedIds));
  }

  @override
  void removeRangeSync(Iterable<T> entities) {
    final hashedIds =
        entities.map((e) => e.entityId is int ? e.entityId as int : fastHash(e.entityId)).toList();

    isar.writeTxnSync((isar) => isarCollection.deleteAllSync(hashedIds));
  }

  @override
  Future<int> update(T entity) => add(entity);

  @override
  void updateSync(T entity) => addSync(entity);

  @override
  Stream<T> watch(id) {
    final hashedId = id is int ? id : fastHash(id);

    return isarCollection
        .watchObject(hashedId)
        .whereNotNull()
        .map((e) => e.toEntity())
        .cast<T>();
  }

  @override
  Stream<void> watchLazy() => isarCollection.watchLazy();
}
