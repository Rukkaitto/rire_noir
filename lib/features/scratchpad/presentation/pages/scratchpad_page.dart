import 'package:api/entities/mode.dart';
import 'package:api/entities/player.dart';
import 'package:api/entities/playing_card.dart';
import 'package:api/entities/room.dart';
import 'package:api/entities/round.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_cubit.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_state.dart';
import 'package:rire_noir/features/room/presentation/widgets/game_widget.dart';

class ScratchpadPage extends StatelessWidget {
  final room = Room(
    id: 'A8BE92',
    winningScore: 10,
    master: Player(id: 'abcd', score: 2, roomId: 'A8BE92'),
    players: [
      Player(
        id: 'abcd',
        score: 2,
        roomId: 'A8BE92',
        isReady: true,
        cards: [
          PlayingCard(id: 1, text: 'one', playerId: 'abcd'),
          PlayingCard(id: 2, text: 'two', playerId: 'abcd'),
        ],
      ),
      Player(
        id: 'efgh',
        score: 0,
        roomId: 'A8BE92',
        isReady: true,
        cards: [
          PlayingCard(id: 3, text: 'three', playerId: 'efgh'),
          PlayingCard(id: 4, text: 'four', playerId: 'efgh'),
        ],
      ),
      Player(
        id: 'ijkl',
        score: 5,
        roomId: 'A8BE92',
        isReady: true,
        cards: [
          PlayingCard(id: 5, text: 'five', playerId: 'ijkl'),
          PlayingCard(id: 6, text: 'six', playerId: 'ijkl'),
        ],
      ),
    ],
    rounds: [
      Round(
        blackCard: PlayingCard(id: 1, text: 'Hello, %@, %@!'),
        whiteCards: {
          'abcd': [
            PlayingCard(id: 7, text: 'seven', playerId: 'abcd'),
            PlayingCard(id: 8, text: 'eight', playerId: 'abcd'),
          ],
          'efgh': [
            PlayingCard(id: 9, text: 'nine', playerId: 'efgh'),
            PlayingCard(id: 10, text: 'ten', playerId: 'efgh'),
          ],
        },
      ),
    ],
    mode: Mode.review,
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
            const WebSocketState(uuid: "abcd"),
          ),
        child: GameWidget(room: room),
      ),
    );
  }
}
