import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'playing_card_style.dart';

class PlayingCardTitleWidget extends StatelessWidget {
  const PlayingCardTitleWidget({
    super.key,
    required this.title,
    required this.style,
  });

  final String title;
  final PlayingCardStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: style.foregroundColor,
      ),
    );
  }
}
