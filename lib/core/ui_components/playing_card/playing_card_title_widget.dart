import 'package:flutter/material.dart';

import 'playing_card_style.dart';

class PlayingCardTitleWidget extends StatelessWidget {
  const PlayingCardTitleWidget({
    super.key,
    required this.text,
    required this.style,
  });

  final String text;
  final PlayingCardStyle style;
  static final regex = RegExp("(?={)|(?<=})");

  @override
  Widget build(BuildContext context) {
    final split = text.split(regex);
    return RichText(
      text: TextSpan(
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: style.foregroundColor),
        children: <InlineSpan>[
          for (String text in split)
            text.startsWith('{')
                ? TextSpan(
                    text: text.substring(1, text.length - 1),
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  )
                : TextSpan(text: text),
        ],
      ),
    );
  }
}
