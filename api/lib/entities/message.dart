import 'dart:convert';
import 'event.dart';

class Message {
  final Event event;
  final dynamic data;

  Message(this.event, this.data);

  factory Message.fromJson(String message) {
    final messageJson = jsonDecode(message);
    final event = EventExtension.fromJson(messageJson['event']);

    return Message(event, messageJson['data']);
  }
}
