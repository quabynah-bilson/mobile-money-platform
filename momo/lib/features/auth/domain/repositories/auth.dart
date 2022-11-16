import 'package:dartz/dartz.dart';

abstract class BaseAuthRepository {
  Future<Either<String, String>> login({
    required String phoneNumber,
    required String pin,
  });

  Future<Either<String, String>> sendOtp({
    required String phoneNumber,
  });

  Future<Either<String, String>> verifyOtp({
    required String phoneNumber,
    required String code,
  });
}
