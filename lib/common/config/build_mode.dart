import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_base/common/values/values.dart';

const String _current = "current";

enum BuildMode {
  prod(
    baseUrl: BuildValues.$prodApiUrl,
  ),
  dev(
    baseUrl: BuildValues.$devApiUrl,
  );

  final String baseUrl;

  const BuildMode({required this.baseUrl});

  void init() async {
    FlavorConfig(
      name: name,
      variables: {_current: this},
    );
  }

  static BuildMode get current => FlavorConfig.instance.variables[_current];
}