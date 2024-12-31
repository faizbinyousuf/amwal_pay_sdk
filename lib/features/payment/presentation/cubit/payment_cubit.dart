import 'dart:developer';

import 'package:amwal_pay_sdk/amwal_pay_sdk.dart';
import 'package:amwal_pay_sdk/amwal_sdk_settings/amwal_sdk_settings.dart';
import 'package:amwalpay/features/payment/domain/model/payment_request.dart';
import 'package:amwalpay/features/payment/domain/usecase/make_payment_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final GetSessionTokenUseCase getSessionTokenUseCase;

  PaymentCubit({required this.getSessionTokenUseCase})
      : super(PaymentState(
          status: ApiStatus.initial,
          sessionToken: null,
          errorMessage: null,
        ));

  Future<void> initPaymentSdk() async {
    await getSessionToken(
        merchantId: state.merchantId ?? "",
        secureHashValue: state.secureHashValue ?? "",
        customerId: null);

    if (state.sessionToken == null) return;

    await AmwalPaySdk.instance.initSdk(
      settings: AmwalSdkSettings(
        sessionToken: state.sessionToken ?? '',
        currency: 'OMR',
        amount: state.payingAmount ?? "",
        transactionId: const Uuid().v1(),
        merchantId: state.merchantId ?? "",
        secureHashValue:
            '2B03FCDC101D3F160744342BFBA0BEA0E835EE436B6A985BA30464418392C703',
        terminalId: state.terminalId ?? "",
        locale: const Locale('en'),
        isMocked: false,
        customerId: null,
      ),
    );
  }

  /// get sdk session token

  Future<void> getSessionToken({
    required String merchantId,
    required String secureHashValue,
    required String? customerId,
  }) async {
    emit(state.copyWith(status: ApiStatus.loading));
    TokenRequest request = TokenRequest(
        merchantId: merchantId,
        secureHashValue: secureHashValue,
        customerId: customerId);

    try {
      final response = await getSessionTokenUseCase(request);
      response.fold(
        (failure) {
          log('failure=====>$failure');
          emit(state.copyWith(
            status: ApiStatus.error,
            sessionToken: null,
            errorMessage: "Couldn't get session token",
          ));
        },
        (success) {
          log('success=====>$success');

          emit(
            state.copyWith(
              status: ApiStatus.success,
              sessionToken: success.sessionToken,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ApiStatus.error,
          sessionToken: null,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void updateMerchantId(String merchantId) {
    state.merchantId = merchantId;
  }

  void updateTerminalId(String terminalId) {
    state.terminalId = terminalId;
  }

  void updatePayingAmount(String payingAmount) {
    state.payingAmount = payingAmount;
  }

  void updateSecureHashValue(String secureHashValue) {
    state.secureHashValue = secureHashValue;
  }
}
