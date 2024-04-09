import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketState {
  final WebSocketChannel? channel;
  final String uuid;

  const WebSocketState({
    required this.uuid,
    this.channel,
  });

  WebSocketState copyWith({
    WebSocketChannel? channel,
    String? uuid,
  }) {
    return WebSocketState(
      channel: channel ?? this.channel,
      uuid: uuid ?? this.uuid,
    );
  }
}
