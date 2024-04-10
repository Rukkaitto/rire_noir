import 'package:api/entities/round.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_cubit.dart';

class MasterReviewViewWidget extends StatelessWidget {
  final Round round;

  const MasterReviewViewWidget({
    super.key,
    required this.round,
  });

  void _onSwipe(
    BuildContext context, {
    required int index,
    required AxisDirection direction,
  }) {
    if (direction == AxisDirection.up) {
      final card = round.whiteCards.values.elementAt(index).first;
      context.read<WebSocketCubit>().selectWinner(card.playerId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        loop: true,
        cardCount: round.whiteCards.length,
        cardBuilder: (BuildContext context, int index) {
          final card = round.blackCard;
          final whiteCards = round.whiteCards.values.elementAt(index);

          return PlayingCardWidget(
            text: card.fillInBlanks(whiteCards),
            style: const PlayingCardStyleBlack(),
          );
        },
      ),
    );
  }
}
