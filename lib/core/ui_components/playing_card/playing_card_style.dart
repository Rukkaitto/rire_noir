import 'package:flutter/material.dart';

sealed class PlayingCardStyle {
  final Color backgroundColor;
  final Color foregroundColor;

  const PlayingCardStyle({
    required this.backgroundColor,
    required this.foregroundColor,
  });
}

class PlayingCardStyleWhite extends PlayingCardStyle {
  const PlayingCardStyleWhite()
      : super(
          backgroundColor: const Color(0xFFF5F2F0),
          foregroundColor: const Color(0xFF292D30),
        );
}

class PlayingCardStyleBlack extends PlayingCardStyle {
  const PlayingCardStyleBlack()
      : super(
          backgroundColor: const Color(0xFF292D30),
          foregroundColor: const Color(0xFFF5F2F0),
        );
}
