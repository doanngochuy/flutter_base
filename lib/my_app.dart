import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:EMO/common/config/config.dart';
import 'package:EMO/common/generated/l10n.dart';
import 'package:EMO/common/router/router.dart';
import 'package:EMO/common/store/store.dart';
import 'package:EMO/common/styles/styles.dart';
import 'package:EMO/common/utils/utils.dart';
import 'package:EMO/global.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: context.hideKeyboard,
      child: LayoutBuilder(
        builder: (_, constrains) {
          ConfigStore.to.onChangeScreen(constrains.maxWidth);
          return MaterialApp.router(
            title: 'EMO',
            theme: AppTheme.light,
            scaffoldMessengerKey: Global.snackBarKey,
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            routerConfig: AppRouter.to.router,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: ConfigStore.to.locale,
            scrollBehavior: MyCustomScrollBehavior(),
          );
        },
      ),
    );
  }
}
