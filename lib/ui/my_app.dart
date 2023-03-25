import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:grouu/constants/app_theme.dart';
import 'package:grouu/constants/strings.dart';
import 'package:grouu/data/repository/repository.dart';
import 'package:grouu/di/components/service_locator.dart';
import 'package:grouu/stores/theme/theme_store.dart';
import 'package:grouu/ui/splash/splash.dart';
import 'package:grouu/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());

  @override
  Widget build(BuildContext context) {
    return Observer(
      name: 'global-observer',
      builder: (context) {
        return Portal(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: _themeStore.darkMode
                ? AppThemeData.darkThemeData
                : AppThemeData.lightThemeData,
            routes: Routes.routes,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
