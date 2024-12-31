import 'dart:async';

import 'package:amwal_pay_sdk/core/resources/color/colors.dart';
import 'package:amwal_pay_sdk/localization/locale_utils.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class CountDownDialog extends StatefulWidget {
  final void Function() getTransaction;
  final void Function() onComplete;
  final String Function(String)? globalTranslator;
  final int countDownInSeconds;
  const CountDownDialog({
    Key? key,
    required this.getTransaction,
    this.globalTranslator,
    required this.onComplete,
    required this.countDownInSeconds,
  }) : super(key: key);

  @override
  State<CountDownDialog> createState() => _CountDownDialogState();
}

class _CountDownDialogState extends State<CountDownDialog> {
  late CountDownController _countDownController;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _countDownController = CountDownController();
    Future.delayed(const Duration(seconds: 2), () {
      widget.getTransaction();
    });
  }

  void _onStart() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      widget.getTransaction();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 28),
          Text(
            'count_down'.translate(
              context,
              globalTranslator: widget.globalTranslator,
            ),
            style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: darkGeryColor,
            ),
            child: Center(
              child: CircularCountDownTimer(
                controller: _countDownController,
                width: 110,
                height: 110,
                duration: widget.countDownInSeconds,
                fillColor: whiteColor,
                ringColor: whiteColor,
                textFormat: CountdownTextFormat.S,
                isReverse: true,
                textStyle: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
                onStart: _onStart,
                onComplete: widget.onComplete,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'successful_transaction'.translate(
                context,
                globalTranslator: widget.globalTranslator,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 28),
        ],
      ),
    );
  }
}
