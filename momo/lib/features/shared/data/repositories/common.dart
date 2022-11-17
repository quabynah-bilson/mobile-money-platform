import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:momo/core/constants.dart';
import 'package:momo/core/injector.dart';
import 'package:momo/features/shared/domain/entities/api.response/api.response.dart';
import 'package:momo/features/shared/domain/repositories/common.dart';

class CommonRepository implements BaseCommonRepository {
  final _server = getIt.get<Dio>();

  @override
  Future<Either<List, String>> banks() async {
    try {
      var response = await _server.get(FlutterConfig.get('GET_BANKS'));
      var apiResponse = ApiResponse.fromJson(response.data);
      return apiResponse.success
          // todo => deserialize response
          ? Left((apiResponse.payload as List).map((e) => e).toList())
          : Right(apiResponse.message);
    } on DioError catch (err) {
      logger.e(err);
    }
    return const Right(kServerErrorMessage);
  }

  @override
  Future<Either<String, String>> getCustomerName(String phoneNumber) async {
    try {
      var response = await _server.get(
          FlutterConfig.get('GET_CUSTOMER_NAME_BY_PHONE_NUMBER')
              .toString()
              .replaceAll('{phone_number}', formatPhoneNumber(phoneNumber)));
      var apiResponse = ApiResponse.fromJson(response.data);
      return apiResponse.success
          ? Left(apiResponse.payload)
          : Right(apiResponse.message);
    } on DioError catch (err) {
      logger.e(err);
    }
    return const Right(kServerErrorMessage);
  }

  @override
  Future<Either<List, String>> offers() async {
    try {
      var response = await _server.get(FlutterConfig.get('GET_OFFERS'));
      var apiResponse = ApiResponse.fromJson(response.data);
      return apiResponse.success
          // todo => deserialize response
          ? Left((apiResponse.payload as List).map((e) => e).toList())
          : Right(apiResponse.message);
    } on DioError catch (err) {
      logger.e(err);
    }
    return const Right(kServerErrorMessage);
  }
}
