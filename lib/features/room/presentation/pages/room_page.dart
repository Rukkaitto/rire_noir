import 'dart:convert';

import 'package:api/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/features/room/presentation/widgets/waiting_room_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:api/entities/room.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class RoomPage extends StatefulWidget {
  final String pinCode;

  const RoomPage({
    super.key,
    required this.pinCode,
  });

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late WebSocketChannel channel;
  late String uuid;

  @override
  void initState() {
    connectToWS();
    super.initState();
  }

  void connectToWS() {
    channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8081/ws'));
    channel.ready.then((_) {
      joinRoom();
    });
  }

  void joinRoom() async {
    uuid = const Uuid().v4();

    channel.sink.add(
      jsonEncode(
        {
          'event': Event.joinRoom.toJson(),
          'data': {
            'id': uuid,
            'pinCode': widget.pinCode,
          },
        },
      ),
    );
  }

  void ready(bool isReady) {
    channel.sink.add(
      jsonEncode(
        {
          'event': Event.ready.toJson(),
          'data': {
            'isReady': isReady,
          },
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF292D30),
      body: StreamBuilder<Room>(
        stream: channel.stream.map((data) => Room.fromJson(jsonDecode(data))),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final room = snapshot.data!;
            final me = room.players.firstWhere((player) => player.id == uuid);

            if (room.isEveryoneReady) {
              return Center(
                child: SizedBox(
                  width: 310,
                  height: 480,
                  child: AppinioSwiper(
                    swipeOptions: const SwipeOptions.only(
                      left: true,
                      up: true,
                      right: true,
                    ),
                    loop: true,
                    cardCount: me.cards.length,
                    cardBuilder: (BuildContext context, int index) {
                      final card = me.cards[index];

                      return PlayingCard(
                        title: card.text,
                        style: const PlayingCardStyleWhite(),
                      );
                    },
                  ),
                ),
              );
            } else {
              return WaitingRoomWidget(room: room, ready: ready);
            }
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
