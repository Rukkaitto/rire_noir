import 'package:api/entities/player.dart';
import 'package:api/entities/round.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/ui_components/dismissible_carousel/dismissible_carousel.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_cubit.dart';

import 'score_widget.dart';

class MasterReviewViewWidget extends StatelessWidget {
  final Player player;
  final Round round;

  const MasterReviewViewWidget({
    super.key,
    required this.player,
    required this.round,
  });

  void _onSwipe(
    BuildContext context, {
    required int index,
  }) {
    final card = round.whiteCards.values.elementAt(index).first;
    context.read<WebSocketCubit>().selectWinner(card.playerId!);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 35,
          ),
          child: ScoreWidget(
            score: player.score,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: DismissibleCarousel(
              alignment: Alignment.bottomCenter,
              onDismissed: (index) {
                _onSwipe(context, index: index);
              },
              children: round.whiteCards.values
                  .map(
                    (cards) => PlayingCardWidget(
                      key: ValueKey(cards.first.id),
                      text: round.blackCard.fillInBlanks(cards),
                      style: const PlayingCardStyleBlack(),
                    ),
                  )
                  .toList()),
        ),
      ],
    );
  }
}
