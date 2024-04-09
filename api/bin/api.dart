import 'dart:convert';

import 'package:api/entities/event.dart';
import 'package:api/entities/message.dart';
import 'package:api/entities/player.dart';
import 'package:api/entities/room.dart';
import 'package:api/utils/pin_code_generator.dart';
import 'package:shelf_plus/shelf_plus.dart';

void main() => shelfRun(
      init,
      defaultBindAddress: '0.0.0.0',
      defaultBindPort: 3001,
    );

Handler init() {
  var app = Router().plus;

  var rooms = <Room>[];
  var players = <Player>[];

  // Web socket route
  app.get(
    '/api/ws',
    () => WebSocketSession(
      onOpen: (ws) {},
      onClose: (ws) {},
      onMessage: (ws, dynamic data) {
        final message = Message.fromJson(data);

        switch (message.event) {
          case Event.joinRoom:
            final pinCode = message.data['pinCode'];
            final id = message.data['id'];

            Room room = rooms.firstWhere((room) => room.id == pinCode);

            if (room.isGameStarted) {
              ws.send('Game already started');
              return;
            }

            final player = Player(
              id: id,
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

            if (room.isEveryoneReady) {
              room.startGame();
            }

            room.broadcastChange();
          case Event.selectCard:
            final cardId = message.data['cardId'];

            final player = players.firstWhere((player) => player.ws == ws);
            final room = rooms.firstWhere((room) => room.id == player.roomId);

            final isRoundOver = room.playCard(player.id, cardId);

            if (isRoundOver) {
              room.startReview();
            }

            room.broadcastChange();
          case Event.selectWinner:
            final winnerId = message.data['winnerId'];

            final player = players.firstWhere((player) => player.ws == ws);
            final room = rooms.firstWhere((room) => room.id == player.roomId);

            room.selectWinner(winnerId);

            room.broadcastChange();
        }
      },
    ),
  );

  app.get('/api/room/<id>', (Request request, String id) {
    final room = rooms
        .cast<Room?>()
        .firstWhere((room) => room!.id == id, orElse: () => null);

    if (room == null) {
      return Response.notFound('Room $id not found');
    }

    return Response.ok(jsonEncode(room.toJson()));
  });

  app.post('/api/room', (Request request) async {
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
    );

    rooms.add(room);

    return Response.ok(room.id);
  });

  return app.call;
}
