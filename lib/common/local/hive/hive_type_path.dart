import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:EMO/common/entities/entities.dart';

import 'models/models.dart';

class HiveTypeId {
  static const $roomGroup = 1;
  static const $room = 2;
  static const $product = 3;
  static const $serverEvent = 4;
  static const $category = 5;
  static const $partner = 6;
}

enum HiveBoxName {
  roomGroup("room_group"),
  room("room"),
  product("product"),
  serverEvent("serverEvent"),
  category("category"),
  partner("partner");

  final String path;

  const HiveBoxName(this.path);
}

extension HiveListEntities<T extends AggregateRoot> on List<T> {
  T? get(dynamic key) => firstWhereOrNull((e) => e.entityId == key);
}

class HiveTuple<OBJ extends HiveModel> {
  /// Creates a new [HiveTuple] with the given [boxName], [adapter] and function [box], [openBox].
  ///
  /// The [boxName] is the name of the box in the hive.
  ///
  /// The [box] function is used to pass a [Function] that return a [Box] with generic type [OBJ].
  ///
  /// The [openBox] function is used to pass a [Function] that return a [Future] of a [Box]
  /// with generic type [OBJ].
  ///
  /// The [adapter]  is the adapter used to convert the [OBJ] to and from the [HiveBox].
  ///
  HiveTuple({
    required this.boxName,
    required this.adapter,
  });

  /// The name of the box.
  final HiveBoxName boxName;

  /// An Adapter used to convert the [OBJ] to and from the [HiveBox].
  final TypeAdapter<OBJ> adapter;

  /// A void function to register the [adapter] to the [Hive].
  void register() => Hive.registerAdapter<OBJ>(adapter);

  /// A getter for the box of the given type.
  Box<OBJ> get box => Hive.box<OBJ>(boxName.path);

  /// A getter for the box of the given type.
  Future<Box<OBJ>> get openBox => Hive.openBox<OBJ>(boxName.path);
}
