import 'package:api/entities/room.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';

class WaitingRoomWidget extends StatefulWidget {
  final Room room;
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.room.id),
          Text('${widget.room.playerCount} joueurs'),
          MyButton(
            onPressed: () {
              setState(() {
                _isReady = !_isReady;
              });

              widget.ready(_isReady);
            },
            trailingIcon: _isReady ? Icons.check : null,
            text:
                'Prêt (${widget.room.readyPlayerCount}/${widget.room.playerCount})',
          ),
        ],
      ),
    );
  }
}
