import 'package:api/entities/player.dart';
import 'package:api/entities/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  '(${room.currentRound.donePlayersCount}/${room.playerCount})',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            PlayingCardWidget(
              text: room.currentRound.blackCard.formattedText,
              style: PlayingCardStyleBlack(context),
            ),
          ],
        ),
      ),
    );
  }
}