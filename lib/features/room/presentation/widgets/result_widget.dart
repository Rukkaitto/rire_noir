import 'package:api/entities/player.dart';
import 'package:api/entities/room.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultWidget extends StatelessWidget {
  final Player player;
  final Room room;

  const ResultWidget({
    super.key,
    required this.player,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Builder(
        builder: (context) {
          if (room.didIWin(player.id)) {
            return Text(
              'C\'est gagné !',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF5F2F0),
              ),
            );
          } else {
            return Text(
              'C\'est perdu !',
              style: GoogleFonts.inter(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFF5F2F0),
              ),
            );
          }
        },
      ),
    );
  }
}
