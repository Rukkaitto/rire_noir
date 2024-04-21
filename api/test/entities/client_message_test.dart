import 'package:api/entities/client_event.dart';
import 'package:api/entities/client_message.dart';
import 'package:test/test.dart';

void main() {
  group('ClientMessage', () {
    test('fromJson', () {
      final json = {
        'event': ClientEvent.joinRoom.toJson(),
        'data': {
          'id': '123456',
          'pinCode': 'T9E0J2',
        },
      };

      final message = ClientMessage.fromJson(json);

      expect(message.event, ClientEvent.joinRoom);
      expect(message.data['id'], '123456');
      expect(message.data['pinCode'], 'T9E0J2');
    });
  });
}
