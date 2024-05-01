import 'package:api/entities/player.dart';
import 'package:api/entities/game.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/core/ui_components/gyroscope_widget/gyroscope.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';
import 'package:rire_noir/features/game/presentation/widgets/player_layout_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        padding: const EdgeInsets.only(
          left: 35,
          bottom: 35,
          right: 35,
          top: 100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildPlayerList(context),
                  buildDonePlayersCount(context),
                ],
              ),
            ),
            const SizedBox(height: 25),
            GyroscopeWidget(
              child: PlayingCardWidget(
                text: room.currentBlackCard.formattedText,
                style: PlayingCardStyleBlack(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDonePlayersCount(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.masterViewDonePlayersCount(
          room.currentRound.donePlayersCount, room.playerCount),
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Widget buildPlayerList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: room.donePlayerNames.map((name) {
        return Text(
          name,
          style: Theme.of(context).textTheme.labelLarge,
        );
      }).toList(),
    );
  }
}
