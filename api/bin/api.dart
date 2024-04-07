import 'package:api/entities/event.dart';
import 'package:api/entities/message.dart';
import 'package:api/entities/room.dart';
import 'package:api/utils/pin_code_generator.dart';
import 'package:shelf_plus/shelf_plus.dart';

void main() => shelfRun(init, defaultBindPort: 8081);

Handler init() {
  var app = Router().plus;

  var rooms = <Room>[];

  // Web socket route
  app.get(
    '/ws',
    () => WebSocketSession(
      onOpen: (ws) {},
      onClose: (ws) {},
      onMessage: (ws, dynamic data) {
        final message = Message.fromJson(data);

        switch (message.event) {
          case Event.joinRoom:
            final pinCode = message.data['pinCode'];

            final room = rooms.firstWhere(
              (room) => room.id == pinCode,
            );

            room.addSession(ws);

            room.broadcastChange();
          case Event.selectCard:
            break;
          case Event.selectWinner:
            break;
        }
      },
    ),
  );

  app.post('/room', (Request request) async {
    final body = await request.body.asJson;

    final capacity = body['capacity'];
    final winningScore = body['winningScore'];

    if (capacity == null || winningScore == null) {
      return Response.badRequest(
        body: 'Capacity and winning score are required',
      );
    }

    final randomPinCode = PinCodeGenerator.generateRandomPin();

    final room = Room(
      id: randomPinCode,
      capacity: capacity,
      winningScore: winningScore,
      players: [],
    );

    rooms.add(room);

    return Response.ok(room.id);
  });

  return app.call;
}
