import 'package:api/entities/player.dart';
import 'package:api/entities/playing_card.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_cubit.dart';

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
  late PlayingCard _currentCard;

  void _onSwipe(AxisDirection direction) {
    if (direction == AxisDirection.up) {
      context.read<WebSocketCubit>().playCard(_currentCard);
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
            _onSwipe(activity.direction);
          },
          swipeOptions: SwipeOptions.only(
            up: widget.canPlay,
            left: true,
            right: true,
            down: true,
          ),
          loop: true,
          cardCount: widget.player.cards.length,
          cardBuilder: (BuildContext context, int index) {
            _currentCard = widget.player.cards[index];

            return PlayingCardWidget(
              title: _currentCard.text,
              style: const PlayingCardStyleWhite(),
            );
          },
        ),
      ),
    );
  }
}
