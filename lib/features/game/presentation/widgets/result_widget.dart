import 'package:api/entities/game.dart';
import 'package:api/entities/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rire_noir/features/game/presentation/widgets/player_layout_widget.dart';

class ResultWidget extends StatefulWidget {
  final Player player;
  final Game game;

  const ResultWidget({
    super.key,
    required this.player,
    required this.game,
  });

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _rowAnimations;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _rowAnimations = List.generate(
      widget.game.leaderboard.length,
      (index) => Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (index / widget.game.leaderboard.length),
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _controller.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlayerLayoutWidget(
      player: widget.player,
      child: Center(
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
      AppLocalizations.of(context)!.resultViewTitle(widget.game.winnerName),
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Widget buildLeaderboard(BuildContext context) {
    return Column(
      children: List.generate(
        widget.game.leaderboard.length,
        (index) {
          final playerWithScore = widget.game.leaderboard[index];
          return AnimatedBuilder(
            animation: _rowAnimations[index],
            builder: (context, child) {
              return Opacity(
                opacity: _rowAnimations[index].value,
                child: Transform.translate(
                  offset: Offset(0.0, 50.0 * (1 - _rowAnimations[index].value)),
                  child: child,
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  playerWithScore.player.name ?? "",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                buildScore(context, score: playerWithScore.score),
              ],
            ),
          );
        },
      ),
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
