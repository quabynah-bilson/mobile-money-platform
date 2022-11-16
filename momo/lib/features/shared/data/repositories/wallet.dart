import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/injector.dart';
import 'package:momo/features/shared/domain/entities/api.response/api.response.dart';
import 'package:momo/features/shared/domain/entities/wallet/wallet.dart';
import 'package:momo/features/shared/domain/repositories/wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletRepository implements BaseWalletRepository {
  final _server = getIt.get<Dio>();

  @override
  Future<Either<Wallet, String>> createWallet(
      {required String phoneNumber, required String name}) async {
    try {
      var response =
          await _server.post(FlutterConfig.get('CREATE_WALLET'), data: {
        'account_holder': name,
        'account_number': formatPhoneNumber(phoneNumber),
      });
      var apiResponse = ApiResponse.fromJson(response.data);

      return apiResponse.success
          ? Left(Wallet.fromJson(apiResponse.payload))
          : Right(apiResponse.message);
    } on DioError catch (err) {
      logger.e(err);
    }

    return const Right(kServerErrorMessage);
  }

  @override
  Future<Either<String, String>> deleteWallet(String id) async {
    try {
      var response = await _server.delete(
          FlutterConfig.get('DELETE_WALLET').toString().replaceAll('{id}', id));
      var apiResponse = ApiResponse.fromJson(response.data);
      return apiResponse.success
          ? Left(apiResponse.message)
          : Right(apiResponse.message);
    } on DioError catch (err) {
      logger.e(err);
    }

    return const Right(kServerErrorMessage);
  }

  @override
  Future<Either<List<Wallet>, String>> wallets() async {
    try {
      var preferences = await getIt.getAsync<SharedPreferences>();
      var response = await _server.get(FlutterConfig.get('GET_WALLETS')
          .toString()
          .replaceAll(
              '{user_id}', preferences.getString('user-phone-key') ?? ''));
      var apiResponse = ApiResponse.fromJson(response.data);
      var wallets = <Wallet>[];
      if (apiResponse.success) {
        var payload = apiResponse.payload as List;
        wallets = payload.map((e) => Wallet.fromJson(e)).toList();
      }

      return apiResponse.success ? Left(wallets) : Right(apiResponse.message);
    } on DioError catch (err) {
      logger.e(err);
    }

    return const Right(kServerErrorMessage);
  }
}
