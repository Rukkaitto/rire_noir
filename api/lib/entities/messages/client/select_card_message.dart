import 'package:api/entities/client_event.dart';

import 'client_message.dart';

class SelectCardMessage extends ClientMessage {
  @override
  ClientEvent get event => ClientEvent.selectCard;

  final int cardId;

  SelectCardMessage({
    required this.cardId,
  });

  factory SelectCardMessage.fromJson(Map<String, dynamic> json) {
    return SelectCardMessage(
      cardId: json['cardId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event.toJson(),
      'cardId': cardId,
    };
  }
}
