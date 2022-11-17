import 'package:dartz/dartz.dart';

// todo => get models for banks and offers
abstract class BaseCommonRepository {
  Future<Either<List, String>> banks();

  Future<Either<List, String>> offers();

  Future<Either<String, String>> getCustomerName(String phoneNumber);
}
