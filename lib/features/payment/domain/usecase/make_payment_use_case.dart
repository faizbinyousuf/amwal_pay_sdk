import 'package:amwalpay/core/error/failures.dart';
import 'package:amwalpay/core/usecase/usecases.dart';
import 'package:amwalpay/features/payment/domain/model/payment_request.dart';
import 'package:amwalpay/features/payment/domain/model/token_response.dart';
import 'package:amwalpay/features/payment/domain/repository/payment_repository.dart';
import 'package:dartz/dartz.dart';

class GetSessionTokenUseCase implements UseCase<TokenResponse, TokenRequest> {
  final PaymentRepository _paymentRepository;
  const GetSessionTokenUseCase(this._paymentRepository);

  @override
  Future<Either<Failure, TokenResponse>> call(TokenRequest request) async {
    return await _paymentRepository.getSessionToken(request: request);
  }
}
