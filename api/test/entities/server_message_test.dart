import 'package:api/entities/server_event.dart';
import 'package:api/entities/server_message.dart';
import 'package:test/test.dart';

void main() {
  group('ServerMessage', () {
    test('fromJson', () {
      final json = {
        'event': ServerEvent.playerWonRound.toJson(),
        'data': {
          'score': 10,
        },
      };

      final message = ServerMessage.fromJson(json);

      expect(message.event, ServerEvent.playerWonRound);
      expect(message.data['score'], 10);
    });
  });
}
