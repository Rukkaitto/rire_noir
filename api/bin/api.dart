import 'package:api/entities/event.dart';
import 'package:api/entities/message.dart';
import 'package:api/entities/room.dart';
import 'package:api/utils/pin_code_generator.dart';
import 'package:shelf_plus/shelf_plus.dart';

void main() => shelfRun(init);

Handler init() {
  var app = Router().plus;

  // Track connected clients
  var rooms = <Room>[];

  // Web socket route
  app.get(
    '/ws',
    () => WebSocketSession(
      onOpen: (ws) {
        print('Connected');
      },
      onClose: (ws) {
        try {
          final room = rooms.firstWhere(
            (room) => room.host == ws,
          );

          rooms.remove(room);
        } on StateError {
          print('Room not found');
        }
      },
      onMessage: (ws, dynamic data) {
        final message = Message.fromJson(data);

        switch (message.event) {
          case Event.createRoom:
            final capacity = message.data['capacity'];
            final winningScore = message.data['winningScore'];

            final randomPinCode = PinCodeGenerator.generateRandomPin();

            final room = Room(
              pinCode: randomPinCode,
              capacity: capacity,
              winningScore: winningScore,
              host: ws,
            );

            rooms.add(room);

            break;
          case Event.joinRoom:
            final pinCode = message.data['pinCode'];

            final room = rooms.firstWhere(
              (room) => room.pinCode == pinCode,
            );

            room.addUser(ws);

            break;
        }
      },
    ),
  );

  return app.call;
}
