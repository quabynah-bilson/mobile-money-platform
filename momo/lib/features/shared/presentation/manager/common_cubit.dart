import 'package:bloc/bloc.dart';
import 'package:momo/core/injector.dart';
import 'package:momo/features/shared/domain/repositories/common.dart';
import 'package:momo/features/shared/presentation/manager/bloc.state.dart';

class CommonCubit extends Cubit<BlocState> {
  final _repo = getIt.get<BaseCommonRepository>();

  CommonCubit() : super(BlocState.initialState());

  Future<void> banks() async {
    emit(BlocState.loadingState());
    var either = await _repo.banks();
    // todo => deserialize response
    either.fold(
      (l) => emit(BlocState<List>.successState(data: l)),
      (r) => emit(BlocState<String>.errorState(failure: r)),
    );
  }

  Future<void> offers() async {
    emit(BlocState.loadingState());
    var either = await _repo.offers();
    // todo => deserialize response
    either.fold(
      (l) => emit(BlocState<List>.successState(data: l)),
      (r) => emit(BlocState<String>.errorState(failure: r)),
    );
  }

  Future<void> getCustomerName(String phoneNumber) async {
    emit(BlocState.loadingState());
    var either = await _repo.getCustomerName(phoneNumber);
    either.fold(
      (l) => emit(BlocState<String>.successState(data: l)),
      (r) => emit(BlocState<String>.errorState(failure: r)),
    );
  }
}
