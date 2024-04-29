import 'package:api/entities/player.dart';
import 'package:api/entities/game.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/core/ui_components/gyroscope_widget/gyroscope.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';
import 'package:rire_noir/features/game/presentation/widgets/player_layout_widget.dart';

class MasterViewWidget extends StatelessWidget {
  final Player player;
  final Game room;

  const MasterViewWidget({
    super.key,
    required this.player,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return PlayerLayoutWidget(
      player: player,
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Text(
                  'En attente des réponses...',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  '(${room.currentRound.donePlayersCount}/${room.playerCount})',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
            const SizedBox(height: 25),
            GyroscopeWidget(
              child: PlayingCardWidget(
                text: room.currentRound.blackCard.formattedText,
                style: PlayingCardStyleBlack(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
