import 'package:api/entities/client_event.dart';
import 'client_message.dart';

class JoinRoomMessage extends ClientMessage {
  @override
  ClientEvent get event => ClientEvent.joinRoom;

  final String pinCode;
  final String playerId;

  JoinRoomMessage({
    required this.pinCode,
    required this.playerId,
  });

  factory JoinRoomMessage.fromJson(Map<String, dynamic> json) {
    return JoinRoomMessage(
      pinCode: json['pinCode'],
      playerId: json['playerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event.toJson(),
      'pinCode': pinCode,
      'playerId': playerId,
    };
  }
}
