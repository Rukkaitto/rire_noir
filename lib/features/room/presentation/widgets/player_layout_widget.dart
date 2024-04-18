import 'package:api/entities/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17),
            child: ScoreWidget(
              score: player.score,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
