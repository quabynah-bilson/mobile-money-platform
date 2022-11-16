import 'package:bloc/bloc.dart';
import 'package:momo/features/shared/presentation/manager/bloc.state.dart';

class CommonCubit extends Cubit<BlocState> {
  CommonCubit() : super(BlocState.initialState());
}
