import 'package:api/entities/mode.dart';
import 'package:api/entities/player.dart';
import 'package:api/entities/playing_card.dart';
import 'package:api/entities/game.dart';
import 'package:api/entities/round.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket_state.dart';
import 'package:rire_noir/features/game/presentation/widgets/game_widget.dart';
import 'package:rire_noir/features/game/presentation/widgets/waiting_room_widget.dart';

class ScratchpadPage extends StatelessWidget {
  final room = Game(
    id: 'A8BE92',
    winningScore: 10,
    master: Player(id: 'master', score: 2, gameId: 'A8BE92'),
    players: [
      Player(
        id: 'player1',
        score: 0,
        gameId: 'A8BE92',
        isReady: true,
        cards: [
          PlayingCard(id: 3, text: 'three', playerId: 'player1'),
          PlayingCard(id: 4, text: 'four', playerId: 'player1'),
        ],
      ),
      Player(
        id: 'player2',
        score: 5,
        gameId: 'A8BE92',
        isReady: false,
        cards: [
          PlayingCard(id: 5, text: 'five', playerId: 'player2'),
          PlayingCard(id: 6, text: 'six', playerId: 'player2'),
        ],
      ),
    ],
    rounds: [
      Round(
        blackCard: PlayingCard(id: 1, text: 'Hello, %@, %@!'),
        whiteCards: {
          'player1': [
            PlayingCard(id: 9, text: 'nine', playerId: 'player1'),
            PlayingCard(id: 10, text: 'ten', playerId: 'player1'),
          ],
          'player2': [
            PlayingCard(id: 7, text: 'seven', playerId: 'player2'),
            PlayingCard(id: 8, text: 'eight', playerId: 'player2'),
          ],
        },
      ),
    ],
    mode: Mode.active,
  );

  ScratchpadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292D30),
      body: BlocProvider<WebSocketCubit>(
        create: (context) => WebSocketCubit(pinCode: room.id)
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          ..emit(
            const WebSocketState(uuid: "master"),
          ),
        child: WaitingRoomWidget(room: room, ready: (_) {}),
      ),
    );
  }
}
