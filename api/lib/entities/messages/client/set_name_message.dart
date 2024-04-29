import 'package:api/entities/client_event.dart';
import 'client_message.dart';

class SetNameMessage extends ClientMessage {
  @override
  ClientEvent get event => ClientEvent.setName;

  final String name;

  SetNameMessage({
    required this.name,
  });

  factory SetNameMessage.fromJson(Map<String, dynamic> json) {
    return SetNameMessage(
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event.toJson(),
      'name': name,
    };
  }
}
