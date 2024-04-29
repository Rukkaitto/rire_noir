import 'package:api/entities/player.dart';
import 'package:api/entities/playing_card.dart';
import 'package:api/entities/round.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/ui_components/dismissible_carousel/dismissible_carousel.dart';
import 'package:rire_noir/core/ui_components/gyroscope_widget/gyroscope.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket_cubit.dart';
import 'package:rire_noir/features/game/presentation/widgets/player_layout_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PlayerViewWidget extends StatefulWidget {
  final Player player;
  final Round round;
  final bool canPlay;

  const PlayerViewWidget({
    super.key,
    required this.player,
    required this.round,
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

  @override
  void didUpdateWidget(covariant PlayerViewWidget oldWidget) {
    setState(() {
      cards = widget.player.cards;
    });
    super.didUpdateWidget(oldWidget);
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

  int get remainingCardsToPlay {
    final playedCardsCount =
        widget.round.getPlayedWhiteCardCount(widget.player.id);
    final totalCardsCount = widget.round.blackCard.requiredWhiteCardCount;

    return totalCardsCount - playedCardsCount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PlayerLayoutWidget(
            player: widget.player,
            child: DismissibleCarousel(
              alignment: Alignment.bottomCenter,
              canDismiss: widget.canPlay,
              onDismissed: (index) {
                _onSwipe(context, index: index);
              },
              children: cards
                  .map(
                    (card) => Padding(
                      key: ValueKey(card.id),
                      padding: const EdgeInsets.all(35),
                      child: GyroscopeWidget(
                        child: PlayingCardWidget(
                          text: card.text,
                          style: PlayingCardStyleWhite(context),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        if (remainingCardsToPlay > 0)
          SafeArea(
            child: Text(
              AppLocalizations.of(context)!
                  .playerViewRemainingCardsToPlay(remainingCardsToPlay),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
      ],
    );
  }
}
