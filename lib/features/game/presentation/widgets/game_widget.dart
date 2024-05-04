import 'package:api/entities/mode.dart';
import 'package:api/entities/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/ui_components/scrolling_background/scrolling_background.dart';
import 'package:rire_noir/features/game/presentation/bloc/cards_dealt/cards_dealt_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket/web_socket_cubit.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket/web_socket_state.dart';
import 'package:rire_noir/features/game/presentation/widgets/master_review_view_widget.dart';
import 'package:rire_noir/features/game/presentation/widgets/result_widget.dart';

import 'master_view_widget.dart';
import 'player_view_widget.dart';

class GameWidget extends StatelessWidget {
  final Game room;

  const GameWidget({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardsDealtCubit, CardsDealtState>(
      listener: (context, state) {
        if (state is CardsDealt) {
          // TODO: show +N cards
        }
      },
      child: BlocBuilder<WebSocketCubit, WebSocketState>(
        builder: (context, state) {
          final me =
              room.allPlayers.firstWhere((player) => player.id == state.uuid);

          return ScrollingBackground(
            child: Builder(
              builder: (context) {
                switch (room.mode) {
                  case Mode.active:
                    if (room.amITheMaster(state.uuid)) {
                      return MasterViewWidget(
                        player: me,
                        room: room,
                      );
                    } else {
                      return PlayerViewWidget(
                        player: me,
                        round: room.currentRound,
                        canPlay: room.canIPlay(state.uuid),
                      );
                    }
                  case Mode.review:
                    if (room.amITheMaster(state.uuid)) {
                      return MasterReviewViewWidget(
                        player: me,
                        round: room.currentRound,
                      );
                    } else {
                      return PlayerViewWidget(
                        player: me,
                        round: room.currentRound,
                        canPlay: false,
                      );
                    }
                  case Mode.finished:
                    return ResultWidget(
                      player: me,
                      game: room,
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
