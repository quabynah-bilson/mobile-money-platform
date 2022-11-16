import 'package:dartz/dartz.dart';
import 'package:momo/features/shared/domain/entities/wallet/wallet.dart';

abstract class BaseWalletRepository {
  Future<Either<Wallet, String>> createWallet({
    required String phoneNumber,
    required String name,
  });

  Future<Either<List<Wallet>, String>> wallets();

  Future<Either<String, String>> deleteWallet(String id);
}
