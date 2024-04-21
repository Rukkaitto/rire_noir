import 'package:api/entities/player.dart';
import 'package:api/entities/playing_card.dart';
import 'package:test/test.dart';

void main() {
  group('Player', () {
    test('fromJson', () {
      final json = {
        'id': '1',
        'isReady': true,
        'score': 0,
        'cards': [
          {
            'id': 1,
            'text': 'Hello',
          },
        ],
        'gameId': '1',
      };

      final player = Player.fromJson(json);
      expect(player.id, '1');
      expect(player.isReady, true);
      expect(player.score, 0);
      expect(player.cards.length, 1);
      expect(player.gameId, '1');
    });

    test('toJson', () {
      final player = Player(
        id: '1',
        isReady: true,
        score: 0,
        cards: [
          PlayingCard(
            id: 1,
            text: 'Hello, %@, %@!',
          ),
        ],
        gameId: '1',
      );

      final json = player.toJson();
      expect(json['id'], '1');
      expect(json['isReady'], true);
      expect(json['score'], 0);
      expect(json['cards'].length, 1);
      expect(json['gameId'], '1');
    });
  });
}
