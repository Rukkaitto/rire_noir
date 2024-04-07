import 'dart:convert';

import 'package:api/entities/card.dart';
import 'package:api/entities/event.dart';
import 'package:api/entities/message.dart';
import 'package:api/entities/player.dart';
import 'package:api/entities/room.dart';
import 'package:api/utils/pin_code_generator.dart';
import 'package:shelf_plus/shelf_plus.dart';

void main() => shelfRun(init, defaultBindPort: 8081);

Handler init() {
  var app = Router().plus;

  var rooms = <Room>[];
  var players = <Player>[];

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

            Room room = rooms.firstWhere((room) => room.id == pinCode);

            if (room.isGameStarted) {
              ws.send('Game already started');
              return;
            }

            final player = Player(
              score: 0,
              ws: ws,
              roomId: room.id,
            );

            room.addPlayer(player);
            players.add(player);

            room.broadcastChange();
          case Event.ready:
            final isReady = message.data['isReady'];

            final player = players.firstWhere((player) => player.ws == ws);
            final room = rooms.firstWhere((room) => room.id == player.roomId);

            player.isReady = isReady;

            room.startGame();
            break;
          case Event.selectCard:
            break;
          case Event.selectWinner:
            break;
        }
      },
    ),
  );

  app.get('/room/<id>', (Request request, String id) {
    final room = rooms
        .cast<Room?>()
        .firstWhere((room) => room!.id == id, orElse: () => null);

    if (room == null) {
      return Response.notFound('Room $id not found');
    }

    return Response.ok(jsonEncode(room.toJson()));
  });

  app.post('/room', (Request request) async {
    final body = await request.body.asJson;

    final winningScore = body['winningScore'];

    if (winningScore == null) {
      return Response.badRequest(
        body: 'Winning score is required',
      );
    }

    final randomPinCode = PinCodeGenerator.generateRandomPin();

    final room = Room(
      id: randomPinCode,
      winningScore: winningScore,
      players: [],
      blackCards: [
        Card(
          id: 1,
          text: "%@, c'est tout le bonheur que je te souhaite, ma fille.",
        ),
        Card(
          id: 2,
          text:
              "Quand %@ a vu %@, il a dit : \"C'est la plus belle chose que j'ai jamais vue.\"",
        ),
        Card(
          id: 3,
          text:
              "Je suis désolé, monsieur, mais je ne peux pas prendre %@ au sérieux.",
        ),
      ],
    );

    rooms.add(room);

    return Response.ok(room.id);
  });

  return app.call;
}
