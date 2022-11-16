import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/extensions.dart';
import 'package:momo/core/injector.dart';
import 'package:momo/core/user.session.dart';
import 'package:momo/features/auth/domain/repositories/auth.dart';
import 'package:momo/features/shared/domain/entities/api.response/api.response.dart';
import 'package:momo/features/shared/domain/entities/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository implements BaseAuthRepository {
  final _server = getIt.get<Dio>();

  AuthRepository() {
    _getInitialData();
  }

  Future<void> _getInitialData() async {
    var preferences = await getIt.getAsync<SharedPreferences>();
    UserSessionHandler.kPhoneNumber = preferences.getString('user-phone-key');
  }

  @override
  Future<Either<MomoUser, String>> getUser() async {
    var preferences = await getIt.getAsync<SharedPreferences>();
    var userJson = preferences.getString('user-key');
    return userJson.isNullOrEmpty()
        ? const Right(kAuthErrorMessage)
        : Left(MomoUser.fromJson(jsonDecode(userJson!)));
  }

  @override
  Future<Either<String, String>> login(
      {required String phoneNumber, required String pin}) async {
    try {
      var response = await _server.post(FlutterConfig.get('LOGIN'), data: {
        'phone_number': formatPhoneNumber(phoneNumber),
        'pin': pin,
      });
      var apiResponse = ApiResponse.fromJson(response.data);
      if (apiResponse.success) {
        var preferences = await getIt.getAsync<SharedPreferences>();
        UserSessionHandler.kMomoUser =
            MomoUser.fromJson(apiResponse.payload as Map<String, dynamic>);
        await preferences.setString(
            'user-key', jsonEncode(UserSessionHandler.kMomoUser!.toJson()));
        await preferences.setString(
            'user-phone-key', UserSessionHandler.kMomoUser?.phoneNumber ?? '');
      }

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

  @override
  Future<void> logout() async {
    var preferences = await getIt.getAsync<SharedPreferences>();
    await preferences.clear();
  }

  @override
  Future<bool> getLoginStatus() async {
    var preferences = await getIt.getAsync<SharedPreferences>();
    return !preferences.getString('user-phone-key').isNullOrEmpty();
  }
}
