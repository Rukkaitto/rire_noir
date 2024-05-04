import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'package:rire_noir/core/services/router_service/router_service.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket/web_socket_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScoreWidget extends StatelessWidget {
  final int score;

  const ScoreWidget({
    super.key,
    required this.score,
  });

  void _handleDisconnect(BuildContext context) async {
    await context.read<WebSocketCubit>().disconnect();

    if (!context.mounted) return;

    RouterService.of(context).pop();
  }

  void _handleClose(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<WebSocketCubit>(context),
          child: Builder(
            builder: (context) {
              if (Platform.isIOS) {
                return CupertinoAlertDialog(
                  title: Text(AppLocalizations.of(context)!.quitDialogTitle),
                  content:
                      Text(AppLocalizations.of(context)!.quitDialogContent),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:
                          Text(AppLocalizations.of(context)!.quitDialogCancel),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _handleDisconnect(context);
                      },
                      child:
                          Text(AppLocalizations.of(context)!.quitDialogConfirm),
                    ),
                  ],
                );
              } else {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.quitDialogTitle),
                  content:
                      Text(AppLocalizations.of(context)!.quitDialogContent),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:
                          Text(AppLocalizations.of(context)!.quitDialogCancel),
                    ),
                    TextButton(
                      onPressed: () {
                        _handleDisconnect(context);
                      },
                      child:
                          Text(AppLocalizations.of(context)!.quitDialogConfirm),
                    ),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.exit_to_app_rounded),
          iconSize: 30,
          color: Theme.of(context).colorScheme.primary,
          onPressed: () {
            _handleClose(context);
          },
        ),
        const Spacer(),
        SvgPicture.asset(AssetService().svgs.scoreIcon),
        const SizedBox(width: 10),
        Text(
          score.toString(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ],
    );
  }
}
