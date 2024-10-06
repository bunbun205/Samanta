import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pause_state.dart';

class PauseCubit extends Cubit<PauseState> {
  PauseCubit() : super(const PauseState());

  void togglePause() {
    emit(state.copyWith(paused: !state.paused));
  }
}
