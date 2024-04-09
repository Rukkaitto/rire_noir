import 'dart:convert';

import 'package:api/entities/event.dart';
import 'package:api/entities/playing_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/services/environment_service/environment_service.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'web_socket_state.dart';

class WebSocketCubit extends Cubit<WebSocketState> {
  final String pinCode;

  WebSocketCubit({required this.pinCode})
      : super(const WebSocketState(uuid: ''));

  void connect() async {
    final uri =
        EnvironmentService().uri.replace(scheme: 'ws').resolve('/api/ws');
    final channel = WebSocketChannel.connect(uri);
    final uuid = const Uuid().v4();

    emit(WebSocketState(uuid: uuid, channel: channel));

    await state.channel?.ready;

    joinRoom();
  }

  void joinRoom() async {
    state.channel?.sink.add(
      jsonEncode(
        {
          'event': Event.joinRoom.toJson(),
          'data': {
            'id': state.uuid,
            'pinCode': pinCode,
          },
        },
      ),
    );
  }

  void ready(bool isReady) {
    state.channel?.sink.add(
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

  void playCard(PlayingCard card) {
    state.channel?.sink.add(
      jsonEncode(
        {
          'event': Event.selectCard.toJson(),
          'data': {
            'cardId': card.id,
          },
        },
      ),
    );
  }
}
