part of 'pause_cubit.dart';

class PauseState extends Equatable {
  const PauseState({this.paused = false});

  final bool paused;

  PauseState copyWith({bool? paused}) {
    return PauseState(paused: paused ?? this.paused);
  }

  @override
  List<Object> get props => [paused];
}
