import 'app_route.dart';

class AppRoutes {
  static const AppRoute home = AppRoute(
    path: '/',
    name: 'Home',
  );

  static const AppRoute createRoom = AppRoute(
    path: 'create-room',
    name: 'CreateRoom',
  );

  static const AppRoute joinRoom = AppRoute(
    path: 'join-room',
    name: 'JoinRoom',
  );

  static const AppRoute createdRoom = AppRoute(
    path: 'room',
    name: 'createdRoom',
  );

  static const AppRoute joinedRoom = AppRoute(
    path: 'room',
    name: 'joinedRoom',
  );
}
