import 'dart:convert';

import 'package:flutter/material.dart';
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
          'event': 'joinRoom',
          'data': {
            'pinCode': widget.pinCode,
          },
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Room>(
        stream: channel.stream.map((event) => Room.fromJson(jsonDecode(event))),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final room = snapshot.data!;
            final playerCount = room.players.length;

            return Center(
              child: Column(
                children: [
                  Text(room.id),
                  Text('$playerCount / ${room.capacity} joueurs'),
                ],
              ),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
