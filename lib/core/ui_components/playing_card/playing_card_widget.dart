import 'package:flutter/cupertino.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_background.dart';
import 'playing_card_style.dart';
import 'playing_card_title_widget.dart';

class PlayingCardWidget extends StatelessWidget {
  final String text;
  final PlayingCardStyle style;

  const PlayingCardWidget({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return PlayingCardBackground(
      style: style,
      child: PlayingCardTitleWidget(text: text, style: style),
    );
  }
}
