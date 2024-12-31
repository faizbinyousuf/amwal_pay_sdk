import 'package:flutter/material.dart';

class PaymentLoadingWidget extends StatelessWidget {
  const PaymentLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 100,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 8),
          Text("Please wait..."),
        ],
      ),
    );
  }
}
