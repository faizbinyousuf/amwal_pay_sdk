part of 'payment_cubit.dart';

class PaymentState {
  ApiStatus status;
  String? sessionToken;
  String? errorMessage;
  String? payingAmount;
  String? merchantId;
  String? terminalId;
  String? secureHashValue;

  PaymentState({
    required this.status,
    this.sessionToken,
    this.errorMessage,
    this.payingAmount,
    this.merchantId,
    this.terminalId,
    this.secureHashValue =
        '2B03FCDC101D3F160744342BFBA0BEA0E835EE436B6A985BA30464418392C703',
  });

  PaymentState copyWith(
      {ApiStatus? status,
      String? sessionToken,
      String? errorMessage,
      String? payingAmount,
      String? merchantId,
      String? terminalId,
      String? secureHashValue}) {
    return PaymentState(
      status: status ?? this.status,
      sessionToken: sessionToken ?? this.sessionToken,
      errorMessage: errorMessage ?? this.errorMessage,
      payingAmount: payingAmount ?? this.payingAmount,
      merchantId: merchantId ?? this.merchantId,
      terminalId: terminalId ?? this.terminalId,
      secureHashValue: secureHashValue ?? this.secureHashValue,
    );
  }
}

enum ApiStatus {
  initial,
  loading,
  success,
  error,
}
