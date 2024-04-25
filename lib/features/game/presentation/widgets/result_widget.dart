import 'package:api/entities/player.dart';
import 'package:api/entities/game.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatelessWidget {
  final Player player;
  final Game room;

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
              style: Theme.of(context).textTheme.labelLarge,
            );
          } else {
            return Text(
              'C\'est perdu !',
              style: Theme.of(context).textTheme.labelLarge,
            );
          }
        },
      ),
    );
  }
}
