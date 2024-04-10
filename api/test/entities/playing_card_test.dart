import 'package:api/entities/playing_card.dart';
import 'package:test/test.dart';

void main() {
  group('PlayingCard', () {
    test('formattedText', () {
      final json = {
        'id': 1,
        'text': 'Hello, %@, %@!',
      };

      final playingCard = PlayingCard.fromJson(json);
      expect(playingCard.formattedText, 'Hello, _____, _____!');
    });

    test('requiredWhiteCardCount', () {
      final json = {
        'id': 1,
        'text': 'Hello, %@, %@!',
      };

      final playingCard = PlayingCard.fromJson(json);
      expect(playingCard.requiredWhiteCardCount, 2);
    });

    test('toJson', () {
      final playingCard = PlayingCard(
        id: 1,
        text: 'Hello, %@, %@!',
      );

      final json = playingCard.toJson();
      expect(json['id'], 1);
      expect(json['text'], 'Hello, %@, %@!');
      expect(json['playerId'], null);
    });

    test('fromJson', () {
      final json = {
        'id': 1,
        'text': 'Hello, %@, %@!',
        'playerId': '1',
      };

      final playingCard = PlayingCard.fromJson(json);
      expect(playingCard.id, 1);
      expect(playingCard.text, 'Hello, %@, %@!');
      expect(playingCard.playerId, '1');
    });

    test('fillInBlanks', () {
      final json = {
        'id': 1,
        'text': 'Hello, %@, %@!',
      };

      final playingCard = PlayingCard.fromJson(json);
      final filledInText = playingCard.fillInBlanks([
        PlayingCard(
          id: 1,
          text: 'World',
        ),
        PlayingCard(
          id: 2,
          text: 'Everyone',
        ),
      ]);
      expect(filledInText, 'Hello, @World@, @Everyone@!');
    });
  });
}
