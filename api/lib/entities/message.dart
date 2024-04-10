import 'event.dart';

class Message {
  final Event event;
  final dynamic data;

  Message(this.event, this.data);

  factory Message.fromJson(Map<String, dynamic> json) {
    final event = EventExtension.fromJson(json['event']);

    return Message(event, json['data']);
  }
}
