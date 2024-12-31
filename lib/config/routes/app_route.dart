import 'package:amwalpay/config/routes/route.dart';
import 'package:amwalpay/core/di/di.dart';
import 'package:amwalpay/core/utils/app_strings.dart';
import 'package:amwalpay/features/home/presentation/pages/home_view.dart';
import 'package:amwalpay/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:amwalpay/features/payment/presentation/pages/payment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments as Map<dynamic, dynamic>?;
    switch (routeSettings.name) {
      case Routes.home:
        return _buildPageRoute(
          const HomeView(),
        );

      case Routes.payment:
        return _buildPageRoute(
          BlocProvider(
            create: (context) =>
                PaymentCubit(getSessionTokenUseCase: appGetIt()),
            child: const PaymentView(),
          ),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: ((context) => const Scaffold(
            body: Center(
              child: Text(AppStrings.noRouteFound),
            ),
          )),
    );
  }

  static Route _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
