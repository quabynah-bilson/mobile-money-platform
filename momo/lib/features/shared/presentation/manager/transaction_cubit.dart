import 'package:bloc/bloc.dart';
import 'package:momo/features/shared/presentation/manager/bloc.state.dart';

class TransactionCubit extends Cubit<BlocState> {
  TransactionCubit() : super(BlocState.initialState());
}
