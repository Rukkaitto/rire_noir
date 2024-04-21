import 'package:api/entities/server_event.dart';

abstract class ServerMessage {
  /// Used by the receiver to determine how to cast the message
  ServerEvent get event;
}
