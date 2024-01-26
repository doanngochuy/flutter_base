import 'dart:async';

import 'package:flutter/foundation.dart' hide Category;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/local/local.dart';

import 'hive_type_path.dart';
import 'models/models.dart';

class HiveServiceImpl implements AppLocalDatabase {
  @override
  Future<HiveServiceImpl> init() async {
    if (!kIsWeb) {
      final dir = await getApplicationSupportDirectory();
      await Hive.initFlutter(dir.path);
    } else {
      await Hive.initFlutter();
    }

    _registerAdapter();

    await _openAllBoxes();

    return this;
  }

  // ignore: avoid_function_literals_in_foreach_calls
  void _registerAdapter() => _typeToEnum.values.forEach((element) => element.register());

  Future<List<Box>> _openAllBoxes() => Future.wait(_typeToEnum.values.map((e) => e.openBox));

  @override
  Future<void> clear() => Future.wait(_typeToEnum.values.map((e) => e.box.clear()));

  @override
  Future<List<T>> getList<T extends AggregateRoot>() {
    final tuple = _typeToEnum[T];
    if (tuple == null) throw Exception("No path for type $T");

    return Future.value(tuple.box.values.map((e) => e.toEntity()).cast<T>().toList());
  }

  @override
  Future<T> insert<T extends AggregateRoot>(T value) async {
    final tuple = _typeToEnum[T];
    if (tuple == null) throw Exception("No path for type $T");

    final element = HiveModel.fromEntity(value);

    await tuple.box.put(element.hiveKey, element);
    return value;
  }

  @override
  Future<List<T>> insertList<T extends AggregateRoot>(List<T> list) async {
    final tuple = _typeToEnum[T];
    if (tuple == null) throw Exception("No path for type $T");

    final mapEntries = list.map(HiveModel.fromEntity);

    await Future.wait(mapEntries.map((e) => tuple.box.put(e.hiveKey, e)));

    return list;
  }

  @override
  Stream<T> watch<T extends AggregateRoot>({dynamic key}) {
    final tuple = _typeToEnum[T];
    if (tuple == null) throw Exception("No path for type $T");

    return tuple.box
        .watch(key: key)
        .map((event) => (event.value as HiveModel).toEntity())
        .cast<T>();
  }
}

final _typeToEnum = <Type, HiveTuple>{
  // Product: HiveTuple<ProductHiveModel>(
  //   boxName: HiveBoxName.product,
  //   adapter: ProductHiveModelAdapter(),
  // ),
};

Box<TD> getBox<T extends AggregateRoot, TD extends HiveModel>() {
  final tuple = _typeToEnum[T] as HiveTuple<TD>?;
  if (tuple == null) throw Exception("No path for type $TD");

  return tuple.box;
}
