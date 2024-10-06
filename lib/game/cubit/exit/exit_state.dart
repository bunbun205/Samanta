part of 'exit_cubit.dart';

class ExitState extends Equatable {
  const ExitState({this.shouldExit = false});

  final bool shouldExit;

  ExitState copyWith({bool? shouldExit}) {
    return ExitState(shouldExit: shouldExit ?? this.shouldExit);
  }

  @override
  List<Object> get props => [shouldExit];
}
