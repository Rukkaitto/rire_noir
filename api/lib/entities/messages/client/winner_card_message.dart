import 'package:api/entities/client_event.dart';

import 'client_message.dart';

class SelectWinnerMessage extends ClientMessage {
  @override
  ClientEvent get event => ClientEvent.selectWinner;

  final String winnerId;

  SelectWinnerMessage({
    required this.winnerId,
  });

  factory SelectWinnerMessage.fromJson(Map<String, dynamic> json) {
    return SelectWinnerMessage(
      winnerId: json['winnerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event.toJson(),
      'winnerId': winnerId,
    };
  }
}
