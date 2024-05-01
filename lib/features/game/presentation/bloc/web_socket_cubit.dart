import 'dart:convert';

import 'package:api/entities/messages/client/join_room_message.dart';
import 'package:api/entities/messages/client/ready_message.dart';
import 'package:api/entities/messages/client/select_card_message.dart';
import 'package:api/entities/messages/client/set_name_message.dart';
import 'package:api/entities/messages/client/winner_card_message.dart';
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

  @override
  Future<void> close() {
    disconnect();
    return super.close();
  }

  Future<void> disconnect() async {
    await state.channel?.sink.close();
  }

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
    final joinRoomMessage = JoinRoomMessage(
      pinCode: pinCode,
      playerId: state.uuid,
    );

    state.channel?.sink.add(
      jsonEncode(joinRoomMessage.toJson()),
    );
  }

  void setName(String name) {
    final setNameMessage = SetNameMessage(
      name: name,
    );

    state.channel?.sink.add(
      jsonEncode(setNameMessage.toJson()),
    );
  }

  void ready(bool isReady) {
    final readyMessage = ReadyMessage(
      isReady: isReady,
    );
    state.channel?.sink.add(
      jsonEncode(readyMessage.toJson()),
    );
  }

  void playCard(PlayingCard card) {
    final selectCardMessage = SelectCardMessage(
      cardId: card.id,
    );
    state.channel?.sink.add(
      jsonEncode(selectCardMessage.toJson()),
    );
  }

  void selectWinner(String winnerId) {
    final selectWinnerMessage = SelectWinnerMessage(
      winnerId: winnerId,
    );
    state.channel?.sink.add(
      jsonEncode(selectWinnerMessage.toJson()),
    );
  }
}
