import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'playing_card_style.dart';

class PlayingCardTitleWidget extends StatelessWidget {
  const PlayingCardTitleWidget({
    super.key,
    required this.text,
    required this.style,
  });

  final String text;
  final PlayingCardStyle style;

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case PlayingCardStyleWhite():
        return Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: style.foregroundColor,
          ),
        );
      case PlayingCardStyleBlack():
        return RichText(
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: style.foregroundColor,
            ),
            children: text.split('@').asMap().entries.map((entry) {
              final index = entry.key;
              final text = entry.value;

              if (index.isEven) {
                return TextSpan(text: text);
              } else {
                return TextSpan(
                  text: text,
                  style: const TextStyle(decoration: TextDecoration.underline),
                );
              }
            }).toList(),
          ),
        );
    }
  }
}
