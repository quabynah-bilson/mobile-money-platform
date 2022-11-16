import 'package:dartz/dartz.dart';
import 'package:momo/features/shared/domain/entities/user/user.dart';

abstract class BaseAuthRepository {
  Future<Either<MomoUser, String>> getUser();

  Future<bool> getLoginStatus();

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

  Future<void> logout();
}
