import 'package:api/entities/player_with_score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rire_noir/core/ui_components/logout_button/logout_button.dart';
import 'package:rire_noir/features/game/presentation/bloc/game_ended/game_ended_cubit.dart';

class ResultWidget extends StatefulWidget {
  const ResultWidget({
    super.key,
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

    super.initState();
  }

  void startAnimation(List<PlayerWithScore> leaderboard) {
    _rowAnimations = List.generate(
      leaderboard.length,
      (index) => Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            (index / leaderboard.length),
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 17),
              child: LogoutButton(),
            ),
            BlocBuilder<GameEndedCubit, GameEndedState>(
              builder: (context, state) {
                if (state is GameEndedReceived) {
                  startAnimation(state.leaderboard);

                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buildTitle(context, winnerName: state.winnerName),
                          const SizedBox(height: 16),
                          buildLeaderboard(context,
                              leaderboard: state.leaderboard),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(BuildContext context, {required String winnerName}) {
    return Text(
      AppLocalizations.of(context)!.resultViewTitle(winnerName),
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }

  Widget buildLeaderboard(
    BuildContext context, {
    required List<PlayerWithScore> leaderboard,
  }) {
    return Column(
      children: List.generate(
        leaderboard.length,
        (index) {
          final playerWithScore = leaderboard[index];
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
