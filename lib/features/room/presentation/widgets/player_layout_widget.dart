import 'package:api/entities/player.dart';
import 'package:flutter/material.dart';

import 'score_widget.dart';

class PlayerLayoutWidget extends StatelessWidget {
  final Player player;
  final Widget child;

  const PlayerLayoutWidget({
    super.key,
    required this.player,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 35,
          ),
          child: ScoreWidget(
            score: player.score,
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: child,
          ),
        ),
      ],
    );
  }
}
