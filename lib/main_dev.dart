import 'package:flutter/material.dart';
import 'package:EMO/common/config/build_mode.dart';
import 'package:EMO/global.dart';
import 'package:EMO/my_app.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  await Global.init(buildMode: BuildMode.dev);
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const MyApp());
}
