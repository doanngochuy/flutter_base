import 'package:isar/isar.dart';

import 'models/models.dart';

class IsarTuple<OBJ extends IsarModel> {
  /// Create a new [IsarTuple] with the given [collection] and [schema].
  ///
  /// The [collection] is a function that returns the collection of the given type.
  ///
  /// The [schema] is the schema of the collection.
  IsarTuple({
    required this.schema,
  });

  /// A getter for the collection of the given type.
  IsarCollection<OBJ> get collection => Isar.getInstance()!.collection<OBJ>();

  /// Schema of the [IsarCollection].
  final CollectionSchema<OBJ> schema;
}

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
