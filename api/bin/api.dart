import 'dart:convert';

import 'package:api/entities/client_event.dart';
import 'package:api/entities/messages/client/join_room_message.dart';
import 'package:api/entities/messages/client/ready_message.dart';
import 'package:api/entities/messages/client/select_card_message.dart';
import 'package:api/entities/messages/client/set_name_message.dart';
import 'package:api/entities/messages/client/winner_card_message.dart';
import 'package:api/entities/player.dart';
import 'package:api/entities/game.dart';
import 'package:api/utils/pin_code_generator.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_plus/shelf_plus.dart';
import 'package:collection/collection.dart';

void main() => shelfRun(
      init,
      defaultBindAddress: '0.0.0.0',
      defaultBindPort: 3001,
    );

Handler init() {
  var app = Router().plus;

  var games = <Game>[];
  var players = <Player>[];

  // Web socket route
  app.get(
    '/api/ws',
    () => WebSocketSession(
      onOpen: (ws) {
        print('Connection opened');
      },
      onClose: (ws) {
        print('Connection closed');
        final player = players.firstWhereOrNull((p) => p.ws == ws);
        final game = games.firstWhereOrNull((g) => g.id == player?.gameId);

        if (player == null || game == null) {
          return;
        }

        // Remove player from game
        game.players.removeWhere((p) => p.id == player.id);

        // If game is empty, remove it
        if (game.players.isEmpty) {
          print('Game ${game.id} removed');
          games.remove(game);
          return;
        }

        // If player is master, pick a new master
        if (game.master?.id == player.id) {
          game.nextRound();
        }

        // Remove player from players list
        players.removeWhere((player) => player.ws == ws);

        game.broadcastChange();
      },
      onMessage: (ws, dynamic data) {
        final jsonData = jsonDecode(data);
        final event = ClientEventExtension.fromMessageJson(jsonData);

        switch (event) {
          case ClientEvent.joinRoom:
            final joinRoomMessage = JoinRoomMessage.fromJson(jsonData);

            Game game =
                games.firstWhere((room) => room.id == joinRoomMessage.pinCode);

            // Check if player is already in the game
            // In that case, replace the ws
            final existingPlayer = players.firstWhereOrNull(
              (player) =>
                  player.id == joinRoomMessage.playerId &&
                  player.gameId == game.id,
            );

            if (existingPlayer != null) {
              print('Player ${existingPlayer.id} reconnected');
              existingPlayer.ws = ws;
            } else {
              if (game.isGameStarted) return;

              print('Player ${joinRoomMessage.playerId} joined');
              final player = Player(
                id: joinRoomMessage.playerId,
                score: 0,
                ws: ws,
                gameId: game.id,
              );

              game.addPlayer(player);
              players.add(player);
            }

            game.broadcastChange();
          case ClientEvent.setName:
            final setNameMessage = SetNameMessage.fromJson(jsonData);

            final player = players.firstWhere((player) => player.ws == ws);
            player.name = setNameMessage.name;

            final game = games.firstWhere((room) => room.id == player.gameId);

            game.broadcastChange();
          case ClientEvent.ready:
            final readyMessage = ReadyMessage.fromJson(jsonData);

            final player = players.firstWhere((player) => player.ws == ws);
            final game = games.firstWhere((room) => room.id == player.gameId);

            player.isReady = readyMessage.isReady;

            if (game.isEveryoneReady) {
              game.startGame();
            }

            game.broadcastChange();
          case ClientEvent.selectCard:
            final selectCardMessage = SelectCardMessage.fromJson(jsonData);

            final player = players.firstWhere((player) => player.ws == ws);
            final game = games.firstWhere((room) => room.id == player.gameId);

            final isRoundOver =
                game.playCard(player.id, selectCardMessage.cardId);

            if (isRoundOver) {
              game.startReview();
            }

            game.broadcastChange();
          case ClientEvent.selectWinner:
            final selectWinnerMessage = SelectWinnerMessage.fromJson(jsonData);

            final player = players.firstWhere((player) => player.ws == ws);
            final game = games.firstWhere((room) => room.id == player.gameId);

            game.selectWinner(selectWinnerMessage.winnerId);

            game.broadcastChange();
        }
      },
    ),
  );

  app.get('/api/room/<id>', (Request request, String id) {
    final game = games
        .cast<Game?>()
        .firstWhere((room) => room!.id == id, orElse: () => null);

    if (game == null) {
      return Response.notFound('Room $id not found');
    }

    return Response.ok(jsonEncode(game.toJson()));
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

    final game = Game(
      id: randomPinCode,
      whiteCardCount: 10,
      winningScore: winningScore,
    );

    games.add(game);

    return Response.ok(game.id);
  });

  return corsHeaders() >> app.call;
}
