import 'package:isar/isar.dart';
import 'package:flutter_base/common/entities/entities.dart';

import '../local_database.dart';
import 'isar_type_path.dart';
import 'models/models.dart';

class IsarServiceImpl implements AppLocalDatabase {
  late final Isar _isar;
  late final Map<Type, IsarTuple> _typeToEnum;

  @override
  Future<IsarServiceImpl> init() async {
    _initConnection();

    final schemas = _typeToEnum.values.map((e) => e.schema).toList();

    _isar = await Isar.open(schemas);

    return this;
  }

  @override
  Future<void> clear() => _isar.writeTxn(_isar.clear);

  @override
  Future<List<T>> getList<T extends AggregateRoot>() async {
    final tuple = _typeToEnum[T];
    if (tuple == null) throw Exception("No path for type $T");
    final data = await tuple.collection.where().findAll();

    return data.map((e) => e.toEntity()).cast<T>().toList();
  }

  @override
  Future<List<T>> insertList<T extends AggregateRoot>(List<T> list) async {
    final tuple = _typeToEnum[T];
    if (tuple == null) throw Exception("No path for type $T");

    final data = list.map(IsarModel.fromEntity);

    await _isar.writeTxn(() => Future.wait(data.map(tuple.collection.put)));

    return list;
  }

  @override
  Future<T> insert<T extends AggregateRoot>(T value) async {
    final tuple = _typeToEnum[T];
    if (tuple == null) throw Exception("No path for type $T");

    final data = IsarModel.fromEntity(value);

    await _isar.writeTxn(() => tuple.collection.put(data));

    return value;
  }

  @override
  Stream<T> watch<T extends AggregateRoot>({dynamic key}) {
    final tuple = _typeToEnum[T];
    if (tuple == null) throw Exception("No path for type $T");

    if (key is Id) {
      return tuple.collection.watchObject(key).map((e) => e?.toEntity()).cast<T>();
    }

    if (key is String) {
      return tuple.collection.watchObject(fastHash(key)).map((e) => e?.toEntity()).cast<T>();
    }
    return Stream<T>.empty();
  }

  void _initConnection() {
    _typeToEnum = <Type, IsarTuple>{
    };
  }
}
