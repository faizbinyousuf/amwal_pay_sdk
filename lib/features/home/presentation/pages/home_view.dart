import 'package:amwalpay/config/routes/route.dart';
import 'package:amwalpay/core/extension/extensions.dart';
import 'package:amwalpay/core/widgets/common_app_bar.dart';
import 'package:amwalpay/core/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(screenTitle: "Home"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CommonButton(
              width: 300.w,
              label: "Open Amwal Pay Demo Screen",
              onTap: () {
                context.pushNamed(Routes.payment);
              },
            ),
          ],
        ),
      ),
    );
  }
}
