import 'package:EMO/common/store/config_store.dart';

extension DoubleExtension on double {
  double get scaleSize => ConfigStore.to.scale * this;
}

extension ListDouble on Iterable<double> {
  double get sumDouble => isNotEmpty ? reduce((value, element) => value + element) : 0;
}
