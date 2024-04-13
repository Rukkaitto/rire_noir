import 'package:api/entities/player.dart';
import 'package:api/entities/playing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/ui_components/dismissible_carousel/dismissible_carousel.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_cubit.dart';

import 'score_widget.dart';

class PlayerViewWidget extends StatefulWidget {
  final Player player;
  final bool canPlay;

  const PlayerViewWidget({
    super.key,
    required this.player,
    required this.canPlay,
  });

  @override
  State<PlayerViewWidget> createState() => _PlayerViewWidgetState();
}

class _PlayerViewWidgetState extends State<PlayerViewWidget> {
  List<PlayingCard> cards = [];

  @override
  void initState() {
    cards = widget.player.cards;
    super.initState();
  }

  void _onSwipe(
    BuildContext context, {
    required int index,
  }) {
    setState(() {
      final card = cards.removeAt(index);
      context.read<WebSocketCubit>().playCard(card);
    });
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
            score: widget.player.score,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: DismissibleCarousel(
            alignment: Alignment.bottomCenter,
            canDismiss: widget.canPlay,
            onDismissed: (index) {
              _onSwipe(context, index: index);
            },
            children: cards
                .map(
                  (card) => PlayingCardWidget(
                    key: ValueKey(card.id),
                    text: card.text,
                    style: const PlayingCardStyleWhite(),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
