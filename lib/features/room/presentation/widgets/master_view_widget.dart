import 'package:api/entities/room.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';

class MasterViewWidget extends StatelessWidget {
  final Room room;

  const MasterViewWidget({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
              '(${room.currentRound.playedCardCount}/${room.currentRoundPlayerCount})',
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
          title: room.currentRound.blackCard.formattedText,
          style: const PlayingCardStyleBlack(),
        ),
      ],
    );
  }
}
