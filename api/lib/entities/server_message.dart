import 'package:api/entities/server_event.dart';

/// A message that is sent from the server to the client
class ServerMessage {
  final ServerEvent event;
  final dynamic data;

  ServerMessage(this.event, this.data);

  factory ServerMessage.fromJson(Map<String, dynamic> json) {
    return ServerMessage(
      ServerEventExtension.fromJson(json['event']),
      json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event.toJson(),
      'data': data,
    };
  }
}
