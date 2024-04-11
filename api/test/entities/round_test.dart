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
        whiteCards: {
          'abcd': [
            PlayingCard(
              id: 1,
              text: 'Hello',
            )
          ],
          'efgh': [
            PlayingCard(
              id: 2,
              text: 'World',
            )
          ]
        },
      );

      final json = round.toJson();
      expect(json['blackCard']['id'], 1);
      expect(json['blackCard']['text'], 'Hello, %@, %@!');
      expect(json['whiteCards'].length, 2);
    });

    test('donePlayersCount', () {
      final round = Round(
        blackCard: PlayingCard(
          id: 1,
          text: 'Hello, %@, %@!',
        ),
        whiteCards: {
          'abcd': [
            PlayingCard(
              id: 1,
              text: 'Hello',
            )
          ],
          'efgh': [
            PlayingCard(
              id: 2,
              text: 'World',
            )
          ]
        },
      );

      expect(round.donePlayersCount, 0);

      round.whiteCards['abcd']!.add(
        PlayingCard(
          id: 3,
          text: 'World',
          playerId: 'abcd',
        ),
      );

      expect(round.donePlayersCount, 1);

      round.whiteCards['efgh']!.add(
        PlayingCard(
          id: 4,
          text: 'Hello',
          playerId: 'efgh',
        ),
      );

      expect(round.donePlayersCount, 2);
    });
  });
}
