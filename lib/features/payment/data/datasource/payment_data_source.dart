import 'dart:convert';
import 'dart:developer';

import 'package:amwal_pay_sdk/core/networking/constants.dart';
import 'package:amwal_pay_sdk/core/networking/secure_hash_interceptor.dart';
import 'package:amwalpay/core/network/urls.dart';
import 'package:amwalpay/features/payment/domain/model/payment_request.dart';
import 'package:amwalpay/features/payment/domain/model/token_response.dart';
import 'package:dio/dio.dart';

class PaymentDataSource {
  final Dio dio;
  const PaymentDataSource({required this.dio});

  Future<TokenResponse> getSessionToken(TokenRequest request) async {
    var sec = SecureHashInterceptor.clearSecureHash(request.secureHashValue, {
      'merchantId': request.merchantId,
      'customerId': request.customerId ?? "",
    });

    var uatBaseurl = NetworkConstants.UATUrlSdk;
    NetworkConstants.baseUrlSdk = uatBaseurl;

    final response = await dio.post(
      AppUrls.getSdkSessionToken,
      data: {
        'merchantId': request.merchantId,
        'secureHashValue': sec,
        'customerId': request.customerId,
      },
    );

    log(' statusCode:==============>${response.statusCode}');

    return TokenResponse.fromJson(response.data['data']);
  }
}
