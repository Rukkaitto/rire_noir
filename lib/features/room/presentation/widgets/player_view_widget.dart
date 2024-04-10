import 'package:api/entities/player.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_cubit.dart';

class PlayerViewWidget extends StatelessWidget {
  final Player player;
  final bool canPlay;

  const PlayerViewWidget({
    super.key,
    required this.player,
    required this.canPlay,
  });

  void _onSwipe(
    BuildContext context, {
    required int index,
    required AxisDirection direction,
  }) {
    if (direction == AxisDirection.up) {
      final card = player.cards[index];
      context.read<WebSocketCubit>().playCard(card);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 310,
        height: 480,
        child: AppinioSwiper(
          onSwipeEnd: (previousIndex, currentIndex, activity) {
            _onSwipe(
              context,
              index: currentIndex,
              direction: activity.direction,
            );
          },
          swipeOptions: SwipeOptions.only(
            up: canPlay,
            left: true,
            right: true,
            down: true,
          ),
          loop: true,
          cardCount: player.cards.length,
          cardBuilder: (BuildContext context, int index) {
            final card = player.cards[index];

            return PlayingCardWidget(
              title: card.text,
              style: const PlayingCardStyleWhite(),
            );
          },
        ),
      ),
    );
  }
}
