import 'package:api/entities/game.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_background.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_title_widget.dart';
import 'package:rire_noir/core/ui_components/scrolling_background/scrolling_background.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WaitingRoomWidget extends StatefulWidget {
  final Game room;
  final void Function(bool) ready;

  const WaitingRoomWidget({
    super.key,
    required this.room,
    required this.ready,
  });

  @override
  State<WaitingRoomWidget> createState() => _WaitingRoomWidgetState();
}

class _WaitingRoomWidgetState extends State<WaitingRoomWidget> {
  bool _isReady = false;

  Stack buildCardStack() {
    return Stack(
      children: [
        PlayingCardBackground(
          style: PlayingCardStyleBlack(context),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: PlayingCardTitleWidget(
                text: AppLocalizations.of(context)!.waitingRoomDesc,
                style: PlayingCardStyleBlack(context),
              ),
            ),
            PlayingCardBackground(
              style: PlayingCardStyleWhite(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlayingCardTitleWidget(
                    text: AppLocalizations.of(context)!.waitingRoomReadyPlayers(
                        widget.room.readyPlayerCount, widget.room.playerCount),
                    style: PlayingCardStyleWhite(context),
                  ),
                  Expanded(
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
                                  "https://lucasgoudin.com/join-room/room?pinCode=${widget.room.id}",
                            ),
                          ),
                          const SizedBox(height: 20),
                          PlayingCardTitleWidget(
                            text: widget.room.id,
                            style: PlayingCardStyleWhite(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollingBackground(
      child: Container(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCardStack(),
            const SizedBox(height: 20),
            MyButton(
              text: AppLocalizations.of(context)!.waitingRoomButton,
              style: _isReady
                  ? MyButtonStyleSecondary(context)
                  : MyButtonStylePrimary(context),
              trailingIcon: _isReady ? Icons.check_rounded : null,
              onPressed: () {
                setState(() {
                  _isReady = !_isReady;
                });
                widget.ready(_isReady);
              },
            ),
          ],
        ),
      ),
    );
  }
}
