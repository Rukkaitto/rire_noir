import 'package:api/entities/client_event.dart';
import 'package:test/test.dart';

void main() {
  group('ClientEvent', () {
    test('fromMessageJson', () {
      final json = {
        "event": "joinRoom",
        "roomId": "1234",
      };

      final joinRoom = ClientEventExtension.fromMessageJson(json);
      expect(joinRoom, ClientEvent.joinRoom);
    });

    test('toJson', () {
      final joinRoom = ClientEvent.joinRoom.toJson();
      expect(joinRoom, "joinRoom");

      final ready = ClientEvent.ready.toJson();
      expect(ready, "ready");

      final selectCard = ClientEvent.selectCard.toJson();
      expect(selectCard, "selectCard");

      final selectWinner = ClientEvent.selectWinner.toJson();
      expect(selectWinner, "selectWinner");
    });
  });
}
