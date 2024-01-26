import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'common/config/config.dart';
import 'common/di/injector.dart';
import 'common/theme/theme.dart';
import 'firebase_options.dart';

class Global {
  static final GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();
  static FirebaseApp? firebaseApp;

  static Future init({BuildMode buildMode = BuildMode.prod}) async {
    WidgetsFlutterBinding.ensureInitialized();

    setSystemUi();
    Loading();
    buildMode.init();

    await _initFirebase();
    await AppInjector.initializeDependencies();
  }

  static void setSystemUi() {
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.black12,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.black12,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  static Future _initFirebase() async {
    firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    // }
    // else {

    const fatalError = true;
    FlutterError.onError = (errorDetails) {
      fatalError
          ? FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails)
          : FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };
    // Async exceptions
    PlatformDispatcher.instance.onError = (error, stack) {
      fatalError
          ? FirebaseCrashlytics.instance.recordError(error, stack, fatal: true)
          : FirebaseCrashlytics.instance.recordError(error, stack);
      return true;
    };
  }
}
