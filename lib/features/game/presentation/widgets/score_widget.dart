import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'package:rire_noir/core/ui_components/logout_button/logout_button.dart';
import 'package:rire_noir/core/ui_components/share_button/share_button.dart';

class ScoreWidget extends StatelessWidget {
  final int score;

  const ScoreWidget({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const LogoutButton(),
        const ShareButton(),
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
