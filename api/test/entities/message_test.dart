import 'package:api/entities/event.dart';
import 'package:api/entities/message.dart';
import 'package:test/test.dart';

void main() {
  group('Message', () {
    test('fromJson', () {
      final json = {
        'event': Event.joinRoom.toJson(),
        'data': {
          'id': '123456',
          'pinCode': 'T9E0J2',
        },
      };

      final message = Message.fromJson(json);

      expect(message.event, Event.joinRoom);
      expect(message.data['id'], '123456');
      expect(message.data['pinCode'], 'T9E0J2');
    });
  });
}
