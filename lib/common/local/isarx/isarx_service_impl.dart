import 'package:isarx/isarx.dart';
import 'package:flutter_base/common/entities/entities.dart';
import 'package:flutter_base/common/local/local.dart';

import 'isarx_type_path.dart';
import 'models/models.dart';

class IsarXServiceImpl implements AppLocalDatabase {
  late final Isar _isar;
  late final Map<Type, IsarXTuple> _typeToEnum;

  @override
  Future<IsarXServiceImpl> init() async {
    _initConnection();

    final schemas = _typeToEnum.values.map((e) => e.schema).toList();

    _isar = await Isar.open(
      schemas: schemas,
      inspector: true,
    );

    return this;
  }

  @override
  Future<void> clear() => _isar.writeTxn((isar) => isar.clear());

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

    final data = list.map(IsarXModel.fromEntity);

    await _isar.writeTxn((isar) => Future.wait(data.map(tuple.collection.put)));

    return list;
  }

  @override
  Future<T> insert<T extends AggregateRoot>(T value) async {
    final tuple = _typeToEnum[T];
    if (tuple == null) throw Exception("No path for type $T");

    final data = IsarXModel.fromEntity(value);

    await _isar.writeTxn((isar) => tuple.collection.put(data));

    return value;
  }

  @override
  Stream<T> watch<T extends AggregateRoot>({dynamic key}) {
    final tuple = _typeToEnum[T];
    if (tuple == null) throw Exception("No path for type $T");

    if (key is int) {
      return tuple.collection.watchObject(key).map((e) => e?.toEntity()).cast<T>();
    }

    if (key is String) {
      return tuple.collection.watchObject(fastHash(key)).map((e) => e?.toEntity()).cast<T>();
    }
    return Stream<T>.empty();
  }

  void _initConnection() {
    _typeToEnum = <Type, IsarXTuple>{
    };
  }
}
