import 'package:flutter/material.dart';
import 'package:flutter_base/common/config/build_mode.dart';
import 'package:flutter_base/global.dart';
import 'package:flutter_base/my_app.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  await Global.init(buildMode: BuildMode.dev);
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const MyApp());
}
