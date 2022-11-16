import 'package:equatable/equatable.dart';

enum _BlocState {
  InitialState,
  LoadingState,
  SuccessState,
  ErrorState,
}

/// base state for all blocs
abstract class BlocState<T> extends Equatable {
  const BlocState(this._type);

  factory BlocState.initialState() = InitialState<T>.create;

  factory BlocState.loadingState() = LoadingState<T>.create;

  factory BlocState.successState({required T data}) = SuccessState<T>.create;

  factory BlocState.errorState({required T failure}) = ErrorState<T>.create;

  final _BlocState _type;

  /// The [when] method is the equivalent to pattern matching.
  /// Its prototype depends on the _BlocState [_type]s defined.
  R? when<R extends Object>(
      {required R Function() initialState,
        required R Function() loadingState,
        required R Function(SuccessState<T>) successState,
        required R Function(ErrorState<T>) errorState}) {
    switch (_type) {
      case _BlocState.InitialState:
        return initialState();
      case _BlocState.LoadingState:
        return loadingState();
      case _BlocState.SuccessState:
        return successState(this as SuccessState<T>);
      case _BlocState.ErrorState:
        return errorState(this as ErrorState<T>);
    }
  }

  /// The [whenOrElse] method is equivalent to [when], but doesn't require
  /// all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra orElse required parameter,
  /// for fallback behavior.
  R whenOrElse<R extends Object>(
      {R Function()? initialState,
        R Function()? loadingState,
        R Function(SuccessState<T>)? successState,
        R Function(ErrorState<T>)? errorState,
        required R Function(BlocState<T>) orElse}) {
    switch (_type) {
      case _BlocState.InitialState:
        if (initialState == null) break;
        return initialState();
      case _BlocState.LoadingState:
        if (loadingState == null) break;
        return loadingState();
      case _BlocState.SuccessState:
        if (successState == null) break;
        return successState(this as SuccessState<T>);
      case _BlocState.ErrorState:
        if (errorState == null) break;
        return errorState(this as ErrorState<T>);
    }
    return orElse(this);
  }

  /// The [whenPartial] method is equivalent to [whenOrElse],
  /// but non-exhaustive.
  void whenPartial({
    void Function()? initialState,
    void Function()? loadingState,
    void Function(SuccessState<T>)? successState,
    void Function(ErrorState<T>)? errorState,
  }) {
    switch (_type) {
      case _BlocState.InitialState:
        if (initialState == null) break;
        return initialState();
      case _BlocState.LoadingState:
        if (loadingState == null) break;
        return loadingState();
      case _BlocState.SuccessState:
        if (successState == null) break;
        return successState(this as SuccessState<T>);
      case _BlocState.ErrorState:
        if (errorState == null) break;
        return errorState(this as ErrorState<T>);
    }
  }

  @override
  List<Object> get props => const [];
}

abstract class InitialState<T> extends BlocState<T> {
  const InitialState() : super(_BlocState.InitialState);

  factory InitialState.create() = _InitialStateImpl<T>;
}

class _InitialStateImpl<T> extends InitialState<T> {
  const _InitialStateImpl() : super();

  @override
  String toString() => 'InitialState()';
}

abstract class LoadingState<T> extends BlocState<T> {
  const LoadingState() : super(_BlocState.LoadingState);

  factory LoadingState.create() = _LoadingStateImpl<T>;
}

class _LoadingStateImpl<T> extends LoadingState<T> {
  const _LoadingStateImpl() : super();

  @override
  String toString() => 'LoadingState()';
}

abstract class SuccessState<T> extends BlocState<T> {
  const SuccessState({required this.data}) : super(_BlocState.SuccessState);

  factory SuccessState.create({required T data}) = _SuccessStateImpl<T>;

  final T data;

  /// Creates a copy of this SuccessState but with the given fields
  /// replaced with the new values.
  SuccessState<T> copyWith({T data});
}

class _SuccessStateImpl<T> extends SuccessState<T> {
  const _SuccessStateImpl({required this.data}) : super(data: data);

  @override
  final T data;

  @override
  _SuccessStateImpl<T> copyWith({T? data}) => _SuccessStateImpl(
    data: data ?? this.data,
  );
  @override
  String toString() => 'SuccessState(data: $data)';

  @override
  List<Object> get props => [data as Object];
}

abstract class ErrorState<T> extends BlocState<T> {
  const ErrorState({required this.failure}) : super(_BlocState.ErrorState);

  factory ErrorState.create({required T failure}) = _ErrorStateImpl<T>;

  final T failure;

  /// Creates a copy of this ErrorState but with the given fields
  /// replaced with the new values.
  ErrorState<T> copyWith({T failure});
}

class _ErrorStateImpl<T> extends ErrorState<T> {
  const _ErrorStateImpl({required this.failure}) : super(failure: failure);

  @override
  final T failure;

  @override
  ErrorState<T> copyWith({T? failure}) => _ErrorStateImpl(
    failure: failure ?? this.failure,
  );
  @override
  String toString() => 'ErrorState(failure: $failure)';

  @override
  List<Object> get props => [failure as Object];
}