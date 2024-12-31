import 'dart:developer';

import 'package:amwalpay/core/error/exception.dart';
import 'package:amwalpay/core/error/failures.dart';
import 'package:amwalpay/features/payment/data/datasource/payment_data_source.dart';
import 'package:amwalpay/features/payment/domain/model/payment_request.dart';
import 'package:amwalpay/features/payment/domain/model/token_response.dart';
import 'package:amwalpay/features/payment/domain/repository/payment_repository.dart';
import 'package:dartz/dartz.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentDataSource paymentDataSource;

  PaymentRepositoryImpl({required this.paymentDataSource});

  @override
  Future<Either<Failure, TokenResponse>> getSessionToken(
      {required TokenRequest request}) async {
    try {
      return Right(await paymentDataSource.getSessionToken(request));
    } on NoInternetConnectionException {
      return Left(OfflineFailure());
    } on UnauthorizedException {
      return Left(UnauthorizedFailure());
    } on NotFoundException {
      return Left(NotFoundFailure());
    } catch (e) {
      log('erorr =====>$e');
      return Left(ServerFailure());
    }
  }
}
