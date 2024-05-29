// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:api/entities/mode.dart';
import 'package:api/entities/player.dart';
import 'package:api/entities/player_with_score.dart';
import 'package:api/entities/playing_card.dart';
import 'package:api/entities/game.dart';
import 'package:api/entities/round.dart';
import 'package:api/entities/server_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/features/game/presentation/bloc/cards_received/cards_received_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/game/game_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/game_ended/game_ended_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/round_won/round_won_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket/web_socket_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket/web_socket_state.dart';
import 'package:rire_noir/features/game/presentation/widgets/game_widget.dart';

class ScratchpadPage extends StatelessWidget {
  final room = Game(
    id: 'A8BE92',
    winningScore: 10,
    master: Player(
      id: 'master',
      name: 'Tom',
      score: 2,
      gameId: 'A8BE92',
    ),
    players: [
      Player(
        id: 'player1',
        name: 'Marion',
        score: 10,
        gameId: 'A8BE92',
        isReady: true,
        cards: [
          PlayingCard(id: 3, text: 'Une étagère IKEA', playerId: 'player1'),
          PlayingCard(id: 4, text: 'four', playerId: 'player1'),
        ],
      ),
      Player(
        id: 'player2',
        name: 'Adrien',
        score: 5,
        gameId: 'A8BE92',
        isReady: true,
        cards: [
          PlayingCard(id: 5, text: 'five', playerId: 'player2'),
          PlayingCard(id: 6, text: 'six', playerId: 'player2'),
        ],
      ),
    ],
    rounds: [
      Round(
        blackCard: PlayingCard(
          id: 1,
          text: '%@, c\'est tout le bonheur que je te souhaite, ma fille.',
        ),
        whiteCards: {
          'player1': [
            // PlayingCard(id: 9, text: 'nine', playerId: 'player1'),
          ],
          'player2': [
            // PlayingCard(id: 10, text: 'ten', playerId: 'player2'),
          ],
        },
      ),
    ],
    mode: Mode.active,
  );

  ScratchpadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WebSocketCubit>(
          create: (context) => WebSocketCubit(pinCode: room.id)
            ..emit(
              const WebSocketState(uuid: "player1"),
            ),
        ),
        BlocProvider<GameCubit>(
          create: (context) => GameCubit()..setGame(room),
        ),
        BlocProvider<RoundWonCubit>(
          create: (context) => RoundWonCubit(),
        ),
        BlocProvider<CardsReceivedCubit>(
            create: (context) => CardsReceivedCubit()
            // ..update([
            //   PlayingCard(id: 11, text: 'eleven', playerId: 'player1'),
            // ]),
            ),
        BlocProvider<GameEndedCubit>(
          create: (context) => GameEndedCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        //Wait 2 seconds before showing leaderboard
        Future.delayed(const Duration(seconds: 2), () {
          context.read<GameEndedCubit>().update(
                GameEndedMessage(
                  winnerName: 'Marion',
                  leaderboard: [
                    PlayerWithScore(
                      Player(
                        id: 'player1',
                        name: 'Marion',
                        score: 10,
                        gameId: 'A8BE92',
                      ),
                      10,
                    ),
                    PlayerWithScore(
                      Player(
                        id: 'player1',
                        name: 'Adrien',
                        score: 5,
                        gameId: 'A8BE92',
                      ),
                      5,
                    ),
                    PlayerWithScore(
                      Player(
                        id: 'player2',
                        name: 'Tom',
                        score: 2,
                        gameId: 'A8BE92',
                      ),
                      2,
                    ),
                  ],
                ),
              );
        });
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: GameWidget(room: room),
          ),
        );
      }),
    );
  }
}
