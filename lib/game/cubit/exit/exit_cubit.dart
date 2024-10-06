import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exit_state.dart';

class ExitCubit extends Cubit<ExitState> {
  ExitCubit() : super(const ExitState());

  void exitGame() {
    emit(state.copyWith(shouldExit: true));
  }
}
