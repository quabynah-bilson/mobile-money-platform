import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/injector.dart';
import 'package:momo/features/auth/domain/repositories/auth.dart';
import 'package:momo/features/shared/domain/entities/api.response/api.response.dart';

class AuthRepository implements BaseAuthRepository {
  final _server = getIt.get<Dio>();

  @override
  Future<Either<String, String>> login(
      {required String phoneNumber, required String pin}) async {
    try {
      var response = await _server.post(FlutterConfig.get('LOGIN'), data: {
        'phone_number': formatPhoneNumber(phoneNumber),
        'pin': pin,
      });
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
  Future<Either<String, String>> sendOtp({required String phoneNumber}) async {
    try {
      var response = await _server.post(FlutterConfig.get('SEND_OTP'),
          data: {'phone_number': formatPhoneNumber(phoneNumber)});
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
  Future<Either<String, String>> verifyOtp(
      {required String phoneNumber, required String code}) async {
    try {
      var response = await _server.post(FlutterConfig.get('VERIFY_OTP'), data: {
        'phone_number': formatPhoneNumber(phoneNumber),
        'pin': code,
      });
      var apiResponse = ApiResponse.fromJson(response.data);
      return apiResponse.success
          ? Left(apiResponse.message)
          : Right(apiResponse.message);
    } on DioError catch (err) {
      logger.e(err);
    }
    return const Right(kServerErrorMessage);
  }
}
