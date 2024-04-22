import 'package:api/entities/player.dart';
import 'package:api/entities/round.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/ui_components/dismissible_carousel/dismissible_carousel.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket_cubit.dart';
import 'package:rire_noir/features/game/presentation/widgets/player_layout_widget.dart';

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
    return PlayerLayoutWidget(
      player: player,
      child: DismissibleCarousel(
        alignment: Alignment.bottomCenter,
        onDismissed: (index) {
          _onSwipe(context, index: index);
        },
        children: round.whiteCards.values
            .map(
              (cards) => Padding(
                key: ValueKey(cards.first.id),
                padding: const EdgeInsets.all(35),
                child: PlayingCardWidget(
                  text: round.blackCard.fillInBlanks(cards),
                  style: PlayingCardStyleBlack(context),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
