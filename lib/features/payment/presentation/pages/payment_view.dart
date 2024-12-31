import 'dart:async';

import 'package:amwalpay/core/widgets/common_app_bar.dart';
import 'package:amwalpay/core/widgets/common_button.dart';
import 'package:amwalpay/features/payment/presentation/components/error_widget.dart';
import 'package:amwalpay/features/payment/presentation/components/input_form.dart';
import 'package:amwalpay/features/payment/presentation/components/payment_loading_widget.dart';
import 'package:amwalpay/features/payment/presentation/cubit/payment_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CommonAppBar(screenTitle: "Payment Demo"),
      body: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) {
              if (state.status == ApiStatus.error) {
                return const PaymentErrorWidget();
              }
              return Stack(
                children: [
                  const InputFormWidget(
                    key: Key('input_form'),
                  ),
                  if (state.status == ApiStatus.loading)
                    const PaymentLoadingWidget()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
