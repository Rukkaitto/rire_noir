import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rire_noir/core/services/environment_service/environment_service.dart';
import 'package:rire_noir/features/home/presentation/pages/home_page.dart';
import 'package:rire_noir/features/room/presentation/pages/create_room_page.dart';
import 'package:rire_noir/features/room/presentation/pages/join_room_page.dart';
import 'package:rire_noir/features/room/presentation/pages/room_page.dart';
import 'package:rire_noir/features/scratchpad/presentation/pages/scratchpad_page.dart';

import 'app_route.dart';
import 'app_routes.dart';

class RouterService {
  final BuildContext context;
  final GoRouter router;

  RouterService(this.context, this.router);

  factory RouterService.of(BuildContext context) {
    return RouterService(context, GoRouter.of(context));
  }

  static GoRouter createRouter() {
    final router = GoRouter(
      initialLocation: getInitialLocation(),
      routes: <RouteBase>[
        GoRoute(
          name: AppRoutes.scratchpad.name,
          path: AppRoutes.scratchpad.path,
          builder: (context, state) {
            return ScratchpadPage();
          },
        ),
        GoRoute(
          name: AppRoutes.home.name,
          path: AppRoutes.home.path,
          builder: (context, state) {
            return const HomePage();
          },
          routes: [
            GoRoute(
              name: AppRoutes.createRoom.name,
              path: AppRoutes.createRoom.path,
              builder: (context, state) {
                return CreateRoomPage();
              },
              routes: [
                GoRoute(
                  name: AppRoutes.createdRoom.name,
                  path: AppRoutes.createdRoom.path,
                  builder: (context, state) {
                    final pinCode = state.uri.queryParameters['pinCode']!;
                    return RoomPage(pinCode: pinCode);
                  },
                ),
              ],
            ),
            GoRoute(
              name: AppRoutes.joinRoom.name,
              path: AppRoutes.joinRoom.path,
              builder: (context, state) {
                return JoinRoomPage();
              },
              routes: [
                GoRoute(
                  name: AppRoutes.joinedRoom.name,
                  path: AppRoutes.joinedRoom.path,
                  builder: (context, state) {
                    final pinCode = state.uri.queryParameters['pinCode']!;
                    return RoomPage(pinCode: pinCode);
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );

    return router;
  }

  void go(
    AppRoute route, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    router.goNamed(
      route.name,
      queryParameters: queryParameters,
    );
  }

  Future<T?> push<T extends Object?>(
    AppRoute route, {
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    return router.pushNamed<T>(
      route.name,
      queryParameters: queryParameters,
    );
  }

  void pop<T extends Object?>([T? result]) {
    router.pop<T>(result);
  }

  static String getInitialLocation() {
    if (EnvironmentService().env == "scratchpad") {
      return AppRoutes.scratchpad.path;
    }

    return AppRoutes.home.path;
  }
}
