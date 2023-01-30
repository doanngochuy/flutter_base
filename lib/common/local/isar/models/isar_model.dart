import 'package:flutter_base/common/entities/entities.dart';
import 'package:flutter_base/common/utils/utils.dart';

import 'models.dart';

abstract class IsarModel {
  AggregateRoot toEntity();

  static IsarModel fromEntity(AggregateRoot entity) {
    try {
      return _mapper[entity.runtimeType]!(entity);
    } catch (e) {
      throw Exception("No mapper for type ${entity.runtimeType}");
    }
  }
}

final _mapper = <Type, ValueGetterWithInput<AggregateRoot, IsarModel>>{
};
