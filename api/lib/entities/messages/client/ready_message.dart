import 'package:api/entities/client_event.dart';

import 'client_message.dart';

class ReadyMessage extends ClientMessage {
  @override
  ClientEvent get event => ClientEvent.ready;

  final bool isReady;

  ReadyMessage({
    required this.isReady,
  });

  factory ReadyMessage.fromJson(Map<String, dynamic> json) {
    return ReadyMessage(
      isReady: json['isReady'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event.toJson(),
      'isReady': isReady,
    };
  }
}
