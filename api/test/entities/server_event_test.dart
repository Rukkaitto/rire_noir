import 'package:api/entities/server_event.dart';
import 'package:test/test.dart';

void main() {
  group('ServerEvent', () {
    test('fromJson', () {
      final readyPlayersCountChanged =
          ServerEventExtension.fromJson("readyPlayersCountChanged");
      expect(readyPlayersCountChanged, ServerEvent.readyPlayersCountChanged);

      final roundDonePlayersCountChanged =
          ServerEventExtension.fromJson("roundDonePlayersCountChanged");
      expect(roundDonePlayersCountChanged,
          ServerEvent.roundDonePlayersCountChanged);

      final playerWonRound = ServerEventExtension.fromJson("playerWonRound");
      expect(playerWonRound, ServerEvent.playerWonRound);

      final playerLostRound = ServerEventExtension.fromJson("playerLostRound");
      expect(playerLostRound, ServerEvent.playerLostRound);

      final newCardsDealt = ServerEventExtension.fromJson("newCardsDealt");
      expect(newCardsDealt, ServerEvent.newCardsDealt);

      final playerWonGame = ServerEventExtension.fromJson("playerWonGame");
      expect(playerWonGame, ServerEvent.playerWonGame);

      final playerLostGame = ServerEventExtension.fromJson("playerLostGame");
      expect(playerLostGame, ServerEvent.playerLostGame);
    });

    test('toJson', () {
      final readyPlayersCountChanged =
          ServerEvent.readyPlayersCountChanged.toJson();
      expect(readyPlayersCountChanged, "readyPlayersCountChanged");

      final roundDonePlayersCountChanged =
          ServerEvent.roundDonePlayersCountChanged.toJson();
      expect(roundDonePlayersCountChanged, "roundDonePlayersCountChanged");

      final playerWonRound = ServerEvent.playerWonRound.toJson();
      expect(playerWonRound, "playerWonRound");

      final playerLostRound = ServerEvent.playerLostRound.toJson();
      expect(playerLostRound, "playerLostRound");

      final newCardsDealt = ServerEvent.newCardsDealt.toJson();
      expect(newCardsDealt, "newCardsDealt");

      final playerWonGame = ServerEvent.playerWonGame.toJson();
      expect(playerWonGame, "playerWonGame");

      final playerLostGame = ServerEvent.playerLostGame.toJson();
      expect(playerLostGame, "playerLostGame");
    });
  });
}
