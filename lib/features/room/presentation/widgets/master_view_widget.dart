import 'package:api/entities/player.dart';
import 'package:api/entities/room.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';
import 'package:rire_noir/features/room/presentation/widgets/player_layout_widget.dart';

class MasterViewWidget extends StatelessWidget {
  final Player player;
  final Room room;

  const MasterViewWidget({
    super.key,
    required this.player,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return PlayerLayoutWidget(
      player: player,
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
                  color: const Color(0xFFF5F2F0),
                ),
              ),
              Text(
                '(${room.currentRound.donePlayersCount}/${room.playerCount})',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFF5F2F0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          PlayingCardWidget(
            text: room.currentRound.blackCard.formattedText,
            style: const PlayingCardStyleBlack(),
          ),
        ],
      ),
    );
  }
}
