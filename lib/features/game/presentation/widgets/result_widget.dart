import 'package:api/entities/player.dart';
import 'package:api/entities/game.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final Player player;
  final Game game;

  const ResultWidget({
    super.key,
    required this.player,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${game.winnerName} a gagné !',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
