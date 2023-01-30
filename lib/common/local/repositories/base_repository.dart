import 'package:flutter_base/common/entities/entities.dart';

abstract class BaseRepository<T extends AggregateRoot> {
  /// Gets the specified identifier.
  Future<T> get(id);

  @Deprecated("This operation is not supported for Isar web, use getAll instead")
  T getSync(id);

  /// Gets all specified entities.
  Future<Iterable<T>> getAll();

  @Deprecated("This operation is not supported for Isar web, use getAll instead")
  Iterable<T> getAllSync();

  /// Adds the specified entity.
  Future<int> add(T entity);

  void addSync(T entity);

  /// Adds a range of specified entities.
  Future<void> addRange(Iterable<T> entities);

  void addRangeSync(Iterable<T> entities);

  /// Removes the specified entity.
  Future<bool> remove(T entity);

  void removeSync(T entity);

  /// Removes a range of specified entities.
  Future<int> removeRange(Iterable<T> entities);

  void removeRangeSync(Iterable<T> entities);

  /// Update the specified entity.
  Future<int> update(T entity);

  void updateSync(T entity);

  // Listen to a changing entity identifier.
  Stream<T> watch(id);

  // listen for changes of all entities.
  Stream<void> watchLazy();
}
