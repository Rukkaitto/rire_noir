import 'package:api/entities/client_event.dart';
import 'package:test/test.dart';

void main() {
  group('ClientEvent', () {
    test('fromJson', () {
      final joinRoom = ClientEventExtension.fromJson("joinRoom");
      expect(joinRoom, ClientEvent.joinRoom);

      final ready = ClientEventExtension.fromJson("ready");
      expect(ready, ClientEvent.ready);

      final selectCard = ClientEventExtension.fromJson("selectCard");
      expect(selectCard, ClientEvent.selectCard);

      final selectWinner = ClientEventExtension.fromJson("selectWinner");
      expect(selectWinner, ClientEvent.selectWinner);
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
