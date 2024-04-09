import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_cubit.dart';
import 'package:rire_noir/features/room/presentation/bloc/web_socket_state.dart';
import 'package:rire_noir/features/room/presentation/widgets/game_widget.dart';
import 'package:rire_noir/features/room/presentation/widgets/waiting_room_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WebSocketCubit>(
      create: (context) => WebSocketCubit(pinCode: widget.pinCode)..connect(),
      child: Scaffold(
        backgroundColor: const Color(0xFF292D30),
        body: BlocBuilder<WebSocketCubit, WebSocketState>(
          builder: (context, state) {
            return StreamBuilder<Room>(
              stream: state.channel?.stream
                  .map((data) => Room.fromJson(jsonDecode(data))),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final room = snapshot.data!;

                  if (room.isEveryoneReady) {
                    return GameWidget(room: room);
                  } else {
                    return WaitingRoomWidget(
                      room: room,
                      ready: (isReady) {
                        context.read<WebSocketCubit>().ready(isReady);
                      },
                    );
                  }
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
