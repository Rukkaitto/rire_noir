import 'package:api/entities/mode.dart';
import 'package:api/entities/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_cubit.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_state.dart';
import 'package:rire_noir/features/room/presentation/widgets/master_review_view_widget.dart';

import 'master_view_widget.dart';
import 'player_view_widget.dart';

class GameWidget extends StatelessWidget {
  final Room room;

  const GameWidget({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebSocketCubit, WebSocketState>(
      builder: (context, state) {
        final me = room.players.firstWhere((player) => player.id == state.uuid);

        switch (room.mode) {
          case Mode.active:
            if (room.amITheMaster(state.uuid)) {
              return MasterViewWidget(room: room);
            } else {
              return PlayerViewWidget(player: me, canPlay: true);
            }
          case Mode.review:
            if (room.amITheMaster(state.uuid)) {
              return MasterReviewViewWidget(round: room.currentRound);
            } else {
              return PlayerViewWidget(player: me, canPlay: false);
            }
          case Mode.finished:
            return const Placeholder();
        }
      },
    );
  }
}
