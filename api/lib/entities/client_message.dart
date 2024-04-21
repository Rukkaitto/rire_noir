import 'package:api/entities/client_event.dart';

/// A message that is sent from the client to the server
class ClientMessage {
  final ClientEvent event;
  final dynamic data;

  ClientMessage(this.event, this.data);

  factory ClientMessage.fromJson(Map<String, dynamic> json) {
    return ClientMessage(
      ClientEventExtension.fromJson(json['event']),
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
