import 'package:amwalpay/core/widgets/common_button.dart';
import 'package:amwalpay/features/payment/presentation/components/text_form.dart';
import 'package:amwalpay/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputFormWidget extends StatefulWidget {
  const InputFormWidget({super.key});

  @override
  State<InputFormWidget> createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  late TextEditingController _amountController;
  late TextEditingController _merchantIdController;
  late TextEditingController _terminalController;
  late TextEditingController _secureHashController;

  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    final cubit = context.read<PaymentCubit>();
    super.initState();
    _formKey = GlobalKey<FormState>();

    _amountController = TextEditingController(text: '50');
    _terminalController = TextEditingController(text: '708393');
    _merchantIdController = TextEditingController(text: '116194');
    _secureHashController = TextEditingController(
      text: '2B03FCDC101D3F160744342BFBA0BEA0E835EE436B6A985BA30464418392C703',
    );

    cubit.updateMerchantId(_merchantIdController.text);
    cubit.updateTerminalId(_terminalController.text);
    cubit.updatePayingAmount(_amountController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _terminalController.dispose();
    _merchantIdController.dispose();
    _secureHashController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 8),
        Expanded(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextForm(
                    title: "Merchant Id",
                    controller: _merchantIdController,
                    isNumeric: true,
                    onChanged: (value) {
                      context.read<PaymentCubit>().updateMerchantId(value!);
                    },
                    maxLength: 10,
                  ),
                  TextForm(
                    title: "Terminal Id",
                    onChanged: (value) {
                      context.read<PaymentCubit>().updateTerminalId(value!);
                    },
                    controller: _terminalController,
                    isNumeric: true,
                    maxLength: 10,
                  ),
                  TextForm(
                    title: "Amount",
                    controller: _amountController,
                    isNumeric: true,
                    onChanged: (value) {
                      context.read<PaymentCubit>().updatePayingAmount(value!);
                    },
                    maxLength: 6,
                    validator: (value) {
                      if (double.parse(value!) < 1.0) {
                        return 'Invalid Amount';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextForm(
                    title: "Secret Key",
                    controller: _secureHashController,
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 8),
                  Center(
                    child: BlocBuilder<PaymentCubit, PaymentState>(
                      builder: (context, state) {
                        return CommonButton(
                          label: "Initiate Payment",
                          onTap: () async {
                            if (state.status == ApiStatus.loading) return;
                            final valid = _formKey.currentState!.validate();
                            if (!valid) return;
                            await context.read<PaymentCubit>().initPaymentSdk();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
