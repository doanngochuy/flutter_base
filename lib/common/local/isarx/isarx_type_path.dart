import 'package:isarx/isarx.dart';

import 'models/models.dart';

class IsarXTuple<OBJ extends IsarXModel> {
  /// Create a new [IsarXTuple] with the given [collection] and [schema].
  ///
  /// The [collection] is a function that returns the collection of the given type.
  ///
  /// The [schema] is the schema of the collection.
  IsarXTuple({
    required this.schema,
  });

  /// A getter for the collection of the given type.
  IsarCollection<OBJ> get collection => Isar.getInstance()!.getCollection<OBJ>();

  /// Schema of the [IsarCollection].
  final CollectionSchema<OBJ> schema;
}

/// FNV-1a 32bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0x811c9dc5;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x01000193;
    hash ^= codeUnit & 0xFF;
    hash *= 0x01000193;
  }

  return hash;
}
