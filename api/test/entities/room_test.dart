import 'package:api/entities/mode.dart';
import 'package:api/entities/player.dart';
import 'package:api/entities/playing_card.dart';
import 'package:api/entities/room.dart';
import 'package:api/entities/round.dart';
import 'package:test/test.dart';

void main() {
  group('Room', () {
    late Room tRoom;
    late Room tRoomStarted;

    setUp(() {
      tRoom = Room(
        id: 'F9A9LE',
        winningScore: 10,
        master: Player(
          id: 'abcd',
          isReady: true,
          score: 0,
          cards: [
            PlayingCard(
              id: 1,
              text: 'Hello',
            ),
          ],
          roomId: '1',
        ),
        players: [
          Player(
            id: 'efgh',
            isReady: false,
            score: 0,
            cards: [
              PlayingCard(
                id: 2,
                text: 'World',
              ),
            ],
            roomId: '1',
          ),
          Player(
            id: 'ijkl',
            isReady: false,
            score: 0,
            cards: [
              PlayingCard(
                id: 3,
                text: 'Test',
              ),
            ],
            roomId: '1',
          ),
        ],
        rounds: [],
        mode: Mode.active,
        whiteCards: [
          PlayingCard(
            id: 1,
            text: 'Hello',
          ),
          PlayingCard(
            id: 2,
            text: 'World',
          ),
          PlayingCard(
            id: 3,
            text: '!',
          ),
        ],
        blackCards: [
          PlayingCard(
            id: 1,
            text: 'Hello, %@, %@!',
          ),
        ],
      );

      tRoomStarted = Room(
        id: 'F9A9LE',
        winningScore: 2,
        master: Player(
          id: 'abcd',
          isReady: true,
          score: 0,
          cards: [
            PlayingCard(
              id: 1,
              text: 'Hello',
            ),
          ],
          roomId: '1',
        ),
        players: [
          Player(
            id: 'efgh',
            isReady: true,
            score: 0,
            cards: [
              PlayingCard(
                id: 2,
                text: 'World',
              ),
            ],
            roomId: '1',
          ),
          Player(
            id: 'ijkl',
            isReady: true,
            score: 0,
            cards: [
              PlayingCard(
                id: 3,
                text: 'Test',
              ),
            ],
            roomId: '1',
          ),
        ],
        rounds: [
          Round(
            blackCard: PlayingCard(
              id: 1,
              text: 'Hello, %@!',
            ),
            whiteCards: {},
          ),
        ],
        mode: Mode.active,
        whiteCards: [
          PlayingCard(
            id: 1,
            text: 'Hello',
          ),
          PlayingCard(
            id: 2,
            text: 'World',
          ),
          PlayingCard(
            id: 3,
            text: '!',
          ),
        ],
        blackCards: [
          PlayingCard(
            id: 1,
            text: 'Hello, %@, %@!',
          ),
        ],
      );
    });

    test('fromJson', () {
      final json = {
        'id': 'F9A9LE',
        'winningScore': 10,
        'master': {
          'id': 'abcd',
          'isReady': true,
          'score': 0,
          'cards': [
            {
              'id': 1,
              'text': 'Hello',
            },
          ],
          'roomId': '1',
        },
        'players': [
          {
            'id': 'abcd',
            'isReady': false,
            'score': 0,
            'cards': [
              {
                'id': 2,
                'text': 'World',
              },
            ],
            'roomId': '1',
          },
        ],
        'rounds': [
          {
            'blackCard': {
              'id': 1,
              'text': 'Hello, %@, %@!',
            },
            'whiteCards': {
              'abcd': [
                {
                  'id': 1,
                  'text': 'Hello',
                }
              ],
              'efgh': [
                {
                  'id': 2,
                  'text': 'World',
                }
              ]
            },
          },
        ],
        'mode': 0,
      };

      final room = Room.fromJson(json);

      expect(room.id, 'F9A9LE');
      expect(room.winningScore, 10);
      expect(room.master?.id, 'abcd');
      expect(room.players.length, 1);
      expect(room.rounds.length, 1);
      expect(room.blackCards.length, 0);
      expect(room.whiteCards.length, 0);
      expect(room.mode, Mode.active);
    });

    test('toJson', () {
      final json = tRoomStarted.toJson();

      expect(json['id'], 'F9A9LE');
      expect(json['winningScore'], 2);
      expect(json['master']['id'], 'abcd');
      expect(json['players'].length, 2);
      expect(json['rounds'].length, 1);
      expect(json['mode'], 0);
    });

    test('playerCount', () {
      expect(tRoomStarted.playerCount, 2);
    });

    test('isEveryoneReady', () {
      expect(tRoomStarted.isEveryoneReady, true);
    });

    test('isGameStarted', () {
      expect(tRoomStarted.isGameStarted, true);
    });

    test('readyPlayerCount', () {
      expect(tRoomStarted.readyPlayerCount, 2);
    });

    test('currentRound', () {
      expect(tRoomStarted.currentRound.blackCard.id, 1);
      expect(tRoomStarted.currentRound.blackCard.text, 'Hello, %@!');
      expect(tRoomStarted.currentRound.whiteCards.length, 0);
    });

    test('currentBlackCard', () {
      expect(tRoomStarted.currentBlackCard.id, 1);
      expect(tRoomStarted.currentBlackCard.text, 'Hello, %@!');
    });

    test('amITheMaster', () {
      expect(tRoomStarted.amITheMaster('abcd'), true);
    });

    test('addPlayer', () {
      final player = Player(
        id: 'abcd',
        isReady: true,
        score: 0,
        cards: [
          PlayingCard(
            id: 1,
            text: 'Hello',
          ),
        ],
        roomId: '1',
      );

      tRoomStarted.addPlayer(player);

      expect(tRoomStarted.players.length, 3);
    });

    test('startGame', () {
      tRoom.startGame();

      expect(tRoom.rounds.length, 1);
      expect(tRoom.blackCards.isNotEmpty, true);
      expect(tRoom.whiteCards.isNotEmpty, true);
    });

    test('startReview', () {
      tRoomStarted.startReview();

      expect(tRoomStarted.mode, Mode.review);
    });

    test('selectWinner', () {
      final player = tRoomStarted.players[0];
      tRoomStarted.selectWinner(player.id);

      expect(player.score, 1);
    });

    test('nextRound', () {
      tRoomStarted.nextRound();

      expect(tRoomStarted.rounds.length, 2);
      expect(tRoomStarted.master?.id, 'efgh');
    });

    test('dealWhiteCards', () {
      tRoomStarted.dealWhiteCards(each: 1);

      expect(tRoomStarted.players[0].cards.length, 2);
      expect(tRoomStarted.players[1].cards.length, 2);
      expect(tRoomStarted.whiteCards.length, 1);
      expect(tRoomStarted.players[0].cards.last.playerId,
          tRoomStarted.players[0].id);
    });

    test('pickBlackCard', () {
      final card = tRoomStarted.pickBlackCard();

      expect(card.id, 1);
      expect(card.text, 'Hello, %@, %@!');
      expect(tRoomStarted.blackCards.length, 0);
    });

    test('playCard', () {
      var isRoundOver = tRoomStarted.playCard('efgh', 2);
      expect(isRoundOver, false);
      isRoundOver = tRoomStarted.playCard('ijkl', 3);
      expect(isRoundOver, true);

      expect(tRoomStarted.players[0].cards.length, 0);
      expect(tRoomStarted.players[1].cards.length, 0);
      expect(tRoomStarted.currentRound.whiteCards.length, 2);
    });

    test('allPlayers', () {
      expect(tRoomStarted.allPlayers.length, 3);
    });
  });
}
