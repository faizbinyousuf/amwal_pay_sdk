import 'package:amwalpay/core/network/dio/dio_factory.dart';
import 'package:amwalpay/features/payment/data/datasource/payment_data_source.dart';
import 'package:amwalpay/features/payment/data/repository/payment_repository_impl.dart';
import 'package:amwalpay/features/payment/domain/repository/payment_repository.dart';
import 'package:amwalpay/features/payment/domain/usecase/make_payment_use_case.dart';
import 'package:amwalpay/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:get_it/get_it.dart';

final appGetIt = GetIt.instance;

Future<void> appGetItInit() async {
  final dio = DioFactory.createDio();
  // bloc
  appGetIt.registerLazySingleton<PaymentCubit>(
      () => PaymentCubit(getSessionTokenUseCase: appGetIt()));

  // Datasource
  appGetIt.registerLazySingleton<PaymentDataSource>(
      () => PaymentDataSource(dio: dio));

  // Repository
  appGetIt.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(paymentDataSource: appGetIt()));

  //  Usecase
  appGetIt.registerLazySingleton<GetSessionTokenUseCase>(
      () => GetSessionTokenUseCase(appGetIt()));

  // Other
  appGetIt.registerFactory(() => dio);
}
