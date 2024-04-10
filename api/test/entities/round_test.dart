import 'package:api/entities/playing_card.dart';
import 'package:api/entities/round.dart';
import 'package:test/test.dart';

void main() {
  group('Round', () {
    test('fromJson', () {
      final json = {
        'blackCard': {
          'id': 1,
          'text': 'Hello, %@, %@!',
        },
        'whiteCards': [
          {
            'id': 1,
            'text': 'Hello',
          },
          {
            'id': 2,
            'text': 'World',
          }
        ],
      };

      final round = Round.fromJson(json);
      expect(round.blackCard.id, 1);
      expect(round.blackCard.text, 'Hello, %@, %@!');
      expect(round.whiteCards.length, 2);
    });

    test('toJson', () {
      final round = Round(
        blackCard: PlayingCard(
          id: 1,
          text: 'Hello, %@, %@!',
        ),
        whiteCards: [
          PlayingCard(
            id: 1,
            text: 'Hello',
          ),
          PlayingCard(
            id: 2,
            text: 'World',
          ),
        ],
      );

      final json = round.toJson();
      expect(json['blackCard']['id'], 1);
      expect(json['blackCard']['text'], 'Hello, %@, %@!');
      expect(json['whiteCards'].length, 2);
    });
  });
}
