import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_base/common/config/config.dart';
import 'package:flutter_base/common/generated/l10n.dart';
import 'package:flutter_base/common/router/router.dart';
import 'package:flutter_base/common/store/store.dart';
import 'package:flutter_base/common/styles/styles.dart';
import 'package:flutter_base/common/utils/utils.dart';
import 'package:flutter_base/global.dart';

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
            title: 'Flutter_base',
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
