import 'package:bloc/bloc.dart';
import 'package:momo/core/injector.dart';
import 'package:momo/features/auth/domain/repositories/auth.dart';
import 'package:momo/features/shared/presentation/manager/bloc.state.dart';

class AuthCubit extends Cubit<BlocState> {
  final _repo = getIt.get<BaseAuthRepository>();

  AuthCubit() : super(BlocState.initialState());

  Future<void> login({
    required String phoneNumber,
    required String pin,
  }) async {
    emit(BlocState.loadingState());
    var either = await _repo.login(phoneNumber: phoneNumber, pin: pin);
    either.fold(
      (l) => emit(BlocState<String>.successState(data: l)),
      (r) => emit(BlocState<String>.errorState(failure: r)),
    );
  }

  Future<void> sendOtp({
    required String phoneNumber,
  }) async {
    emit(BlocState.loadingState());
    var either = await _repo.sendOtp(phoneNumber: phoneNumber);
    either.fold(
      (l) => emit(BlocState<String>.successState(data: l)),
      (r) => emit(BlocState<String>.errorState(failure: r)),
    );
  }

  Future<void> verifyOtp({
    required String phoneNumber,
    required String code,
  }) async {
    emit(BlocState.loadingState());
    var either = await _repo.verifyOtp(phoneNumber: phoneNumber, code: code);
    either.fold(
      (l) => emit(BlocState<String>.successState(data: l)),
      (r) => emit(BlocState<String>.errorState(failure: r)),
    );
  }

  Future<void> logout() => _repo.logout();

  Future<bool> getLoginStatus() => _repo.getLoginStatus();
}
