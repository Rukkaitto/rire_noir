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
  PlayingCardStyleWhite(BuildContext context)
      : super(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
        );
}

class PlayingCardStyleBlack extends PlayingCardStyle {
  PlayingCardStyleBlack(BuildContext context)
      : super(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.primary,
        );
}
