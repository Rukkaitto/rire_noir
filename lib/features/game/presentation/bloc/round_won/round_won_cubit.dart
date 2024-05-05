import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'round_won_state.dart';

class RoundWonCubit extends Cubit<RoundWonState> {
  RoundWonCubit() : super(RoundWonInitial());

  void roundWon() {
    emit(const RoundWonReceived());
  }

  void reset() {
    emit(RoundWonInitial());
  }
}
