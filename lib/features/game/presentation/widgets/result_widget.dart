import 'package:api/entities/player.dart';
import 'package:api/entities/game.dart';
import 'package:flutter/material.dart';

class ResultWidget extends StatefulWidget {
  final Player player;
  final Game room;

  const ResultWidget({
    super.key,
    required this.player,
    required this.room,
  });

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
    _controller.reset();
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: _animation.value,
        child: Text(
          '${widget.room.winnerName} a gagné !',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
