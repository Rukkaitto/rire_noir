import 'dart:convert';

import 'package:api/entities/server_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/features/game/presentation/bloc/cards_received/cards_received_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/game_ended/game_ended_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/round_won/round_won_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/game/game_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket/web_socket_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket/web_socket_state.dart';
import 'package:rire_noir/features/game/presentation/widgets/choose_name_widget.dart';
import 'package:rire_noir/features/game/presentation/widgets/game_widget.dart';
import 'package:rire_noir/features/game/presentation/widgets/waiting_room_widget.dart';
import 'package:api/entities/game.dart';

class GamePage extends StatelessWidget {
  final String pinCode;

  const GamePage({
    super.key,
    required this.pinCode,
  });

  Widget buildGame(
    BuildContext context, {
    required Game game,
    required String uuid,
  }) {
    if (game.isEveryoneReady) {
      return GameWidget(room: game);
    } else {
      if (!game.isNameDefined(uuid)) {
        return const ChooseNameWidget();
      } else {
        return WaitingRoomWidget(
          room: game,
          ready: (isReady) {
            context.read<WebSocketCubit>().ready(isReady);
          },
        );
      }
    }
  }

  void handleSocketMessage(
    BuildContext context, {
    required ServerMessage message,
  }) {
    switch (message) {
      case GameChangedMessage(game: var game):
        context.read<GameCubit>().setGame(game);
        break;
      case RoundWonMessage():
        context.read<RoundWonCubit>().roundWon();
        break;
      case CardsReceivedMessage(cards: var cards):
        context.read<CardsReceivedCubit>().update(cards);
        break;
      case GameEndedMessage _:
        context.read<GameEndedCubit>().update(message);
        break;
    }
  }

  ServerMessage getServerMessageFromStreamData(dynamic data) {
    return ServerMessage.fromJson(jsonDecode(data));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WebSocketCubit>(
          create: (context) => WebSocketCubit(pinCode: pinCode)..connect(),
        ),
        BlocProvider<GameCubit>(
          create: (context) => GameCubit(),
        ),
        BlocProvider<RoundWonCubit>(
          create: (context) => RoundWonCubit(),
        ),
        BlocProvider<CardsReceivedCubit>(
          create: (context) => CardsReceivedCubit(),
        ),
        BlocProvider<GameEndedCubit>(
          create: (context) => GameEndedCubit(),
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: BlocBuilder<WebSocketCubit, WebSocketState>(
            builder: (context, state) {
              return StreamBuilder(
                stream: state.channel?.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final message =
                        getServerMessageFromStreamData(snapshot.data);

                    handleSocketMessage(context, message: message);
                  }

                  return BlocBuilder<GameCubit, Game?>(
                    builder: (context, game) {
                      if (game == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return buildGame(
                        context,
                        game: game,
                        uuid: state.uuid,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
