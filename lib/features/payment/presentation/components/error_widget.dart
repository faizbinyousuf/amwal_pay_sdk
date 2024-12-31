import 'package:amwalpay/core/widgets/common_button.dart';
import 'package:amwalpay/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentErrorWidget extends StatelessWidget {
  const PaymentErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.errorMessage ?? "An error occurred"),
              const SizedBox(height: 8),
              CommonButton(
                label: "Retry",
                onTap: () async {
                  await context.read<PaymentCubit>().initPaymentSdk();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
