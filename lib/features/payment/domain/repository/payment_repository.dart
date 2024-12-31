import 'package:amwalpay/core/error/failures.dart';
import 'package:amwalpay/features/payment/domain/model/payment_request.dart';
import 'package:amwalpay/features/payment/domain/model/token_response.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepository {
  Future<Either<Failure, TokenResponse>> getSessionToken(
      {required TokenRequest request});
}
