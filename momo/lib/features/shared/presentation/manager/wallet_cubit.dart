import 'package:bloc/bloc.dart';
import 'package:momo/core/injector.dart';
import 'package:momo/features/shared/domain/entities/wallet/wallet.dart';
import 'package:momo/features/shared/domain/repositories/wallet.dart';
import 'package:momo/features/shared/presentation/manager/bloc.state.dart';

class WalletCubit extends Cubit<BlocState> {
  final _repo = getIt.get<BaseWalletRepository>();

  WalletCubit() : super(BlocState.initialState());

  Future<void> createWallet({
    required String phoneNumber,
    required String name,
  }) async {
    emit(BlocState.loadingState());
    var either = await _repo.createWallet(phoneNumber: phoneNumber, name: name);
    either.fold(
      (l) => emit(BlocState<Wallet>.successState(data: l)),
      (r) => emit(BlocState<String>.errorState(failure: r)),
    );
  }

  Future<void> wallets() async {
    emit(BlocState.loadingState());
    var either = await _repo.wallets();
    either.fold(
      (l) => emit(BlocState<List<Wallet>>.successState(data: l)),
      (r) => emit(BlocState<String>.errorState(failure: r)),
    );
  }

  Future<void> deleteWallet(String id) async {
    emit(BlocState.loadingState());
    var either = await _repo.deleteWallet(id);
    either.fold(
      (l) => emit(BlocState<String>.successState(data: l)),
      (r) => emit(BlocState<String>.errorState(failure: r)),
    );
  }
}
