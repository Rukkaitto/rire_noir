import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'package:rire_noir/core/services/router_service/app_routes.dart';
import 'package:rire_noir/core/services/router_service/router_service.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket_cubit.dart';

class ScoreWidget extends StatelessWidget {
  final int score;

  const ScoreWidget({
    super.key,
    required this.score,
  });

  void _handleDisconnect(BuildContext context) {
    context.read<WebSocketCubit>().disconnect();
    RouterService.of(context).go(AppRoutes.home);
  }

  void _handleClose(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: const Text('Quitter la partie'),
            content: const Text('Êtes-vous sûr de vouloir quitter la partie ?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Annuler'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  _handleDisconnect(context);
                  Navigator.of(context).pop();
                },
                child: const Text('Quitter'),
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: const Text('Quitter la partie'),
            content: const Text('Êtes-vous sûr de vouloir quitter la partie ?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  _handleDisconnect(context);
                  Navigator.of(context).pop();
                },
                child: const Text('Quitter'),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.close),
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
          style: GoogleFonts.inter(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
