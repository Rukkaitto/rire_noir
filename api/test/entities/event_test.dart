import 'package:api/entities/event.dart';
import 'package:test/test.dart';

void main() {
  group('Event', () {
    test('fromJson', () {
      final joinRoom = EventExtension.fromJson("joinRoom");
      expect(joinRoom, Event.joinRoom);

      final ready = EventExtension.fromJson("ready");
      expect(ready, Event.ready);

      final selectCard = EventExtension.fromJson("selectCard");
      expect(selectCard, Event.selectCard);

      final selectWinner = EventExtension.fromJson("selectWinner");
      expect(selectWinner, Event.selectWinner);
    });

    test('toJson', () {
      final joinRoom = Event.joinRoom.toJson();
      expect(joinRoom, "joinRoom");

      final ready = Event.ready.toJson();
      expect(ready, "ready");

      final selectCard = Event.selectCard.toJson();
      expect(selectCard, "selectCard");

      final selectWinner = Event.selectWinner.toJson();
      expect(selectWinner, "selectWinner");
    });
  });
}
