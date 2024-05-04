import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:api/entities/server_message.dart';
import 'package:shelf_plus/shelf_plus.dart';

class WebSocketClient {
  WebSocketSession ws;

  final Duration delay;
  final StreamController<ServerMessage> _controller =
      StreamController<ServerMessage>();
  final Queue<ServerMessage> _queue = Queue<ServerMessage>();
  Timer? _timer;

  WebSocketClient({
    required this.ws,
    this.delay = const Duration(milliseconds: 20),
  }) {
    _controller.stream.listen((message) {
      _queue.add(message);
      if (_timer == null || !_timer!.isActive) {
        _timer = Timer.periodic(delay, (_) {
          if (_queue.isNotEmpty) {
            final nextMessage = _queue.removeFirst();
            _sendMessageToSocket(nextMessage);
          } else {
            _timer?.cancel();
          }
        });
      }
    });
  }

  void sendMessage(ServerMessage message) {
    _controller.add(message);
  }

  void _sendMessageToSocket(ServerMessage message) {
    final json = message.toJson();
    ws.send(jsonEncode(json));
  }

  void dispose() {
    _controller.close();
    _timer?.cancel();
  }
}
