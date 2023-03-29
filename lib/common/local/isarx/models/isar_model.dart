import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/utils/utils.dart';

import 'models.dart';

abstract class IsarXModel {
  AggregateRoot toEntity();

  static IsarXModel fromEntity(AggregateRoot entity) {
    try {
      return _mapper[entity.runtimeType]!(entity);
    } catch (e) {
      throw Exception("No mapper for type ${entity.runtimeType}");
    }
  }
}

final _mapper = <Type, ValueGetterWithInput<AggregateRoot, IsarXModel>>{
};
