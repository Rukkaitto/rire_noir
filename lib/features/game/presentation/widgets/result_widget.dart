import 'package:api/entities/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResultWidget extends StatefulWidget {
  final Game room;

  const ResultWidget({
    super.key,
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(context),
              const SizedBox(height: 16),
              buildLeaderboard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.resultViewTitle(widget.room.winnerName),
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Widget buildLeaderboard(BuildContext context) {
    return Column(
      children: widget.room.leaderboard
          .map(
            (playerWithScore) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  playerWithScore.player.name ?? "",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                buildScore(context, score: playerWithScore.score),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget buildScore(
    BuildContext context, {
    required int score,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          SvgPicture.asset(AssetService().svgs.scoreIcon, height: 20),
          const SizedBox(width: 5),
          Text(
            score.toString(),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
