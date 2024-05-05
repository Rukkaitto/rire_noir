part of 'round_won_cubit.dart';

sealed class RoundWonState extends Equatable {
  const RoundWonState();

  @override
  List<Object> get props => [];
}

class RoundWonInitial extends RoundWonState {}

class RoundWonReceived extends RoundWonState {
  const RoundWonReceived();

  @override
  List<Object> get props => [];
}
