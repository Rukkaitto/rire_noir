import 'package:api/entities/client_event.dart';

abstract class ClientMessage {
  /// Used by the receiver to determine how to cast the message
  ClientEvent get event;
}
