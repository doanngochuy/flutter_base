import 'package:EMO/common/entities/entities.dart';
import 'package:EMO/common/utils/utils.dart';

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

final _mapper = <Type, ValueGetterWithInput<AggregateRoot, IsarModel>>{};
