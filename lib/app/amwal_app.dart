import 'package:amwal_pay_sdk/amwal_pay_sdk.dart';
import 'package:amwalpay/config/routes/app_route.dart';
import 'package:amwalpay/config/routes/route.dart';
import 'package:amwalpay/config/theme/app_theme.dart';
import 'package:amwalpay/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AmwalApp extends StatelessWidget {
  const AmwalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: MaterialApp(
        title: AppStrings.appName,
        navigatorObservers: [
          AmwalSdkNavigator.amwalNavigatorObserver,
        ],
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        locale: const Locale('en'),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: Routes.home,
      ),
    );
  }
}
