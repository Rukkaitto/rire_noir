import 'dart:convert';

import 'package:api/entities/event.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/features/room/presentation/widgets/waiting_room_widget.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:api/entities/room.dart';

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

  void joinRoom() {
    channel.sink.add(
      jsonEncode(
        {
          'event': Event.joinRoom.toJson(),
          'data': {
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
      body: StreamBuilder<Room>(
        stream: channel.stream.map((data) => Room.fromJson(jsonDecode(data))),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final room = snapshot.data!;

            if (room.isEveryoneReady) {
              return const Center(
                child: Text('Tout le monde est prêt'),
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
