import 'package:api/entities/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_background.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_title_widget.dart';
import 'package:rire_noir/features/game/presentation/bloc/game/game_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key});

  Widget buildSheetContent(BuildContext context) {
    return BlocBuilder<GameCubit, Game?>(
      builder: (context, game) {
        return PlayingCardBackground(
          style: PlayingCardStyleWhite(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: PrettyQrView.data(
                    data:
                        AppLocalizations.of(context)!.joinDeeplinkUrl(game!.id),
                  ),
                ),
                const SizedBox(height: 20),
                PlayingCardTitleWidget(
                  text: game.id,
                  style: PlayingCardStyleWhite(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleShare(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BlocProvider.value(
        value: BlocProvider.of<GameCubit>(context),
        child: buildSheetContent(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share_rounded),
      iconSize: 30,
      color: Theme.of(context).colorScheme.primary,
      onPressed: () {
        _handleShare(context);
      },
    );
  }
}
