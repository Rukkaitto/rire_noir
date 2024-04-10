import 'package:flutter/material.dart';
import 'package:rire_noir/core/services/router_service/app_routes.dart';
import 'package:rire_noir/core/services/router_service/router_service.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(
              text: 'Rejoindre',
              onPressed: () {
                RouterService.of(context).go(AppRoutes.joinRoom);
              },
            ),
            const SizedBox(height: 16),
            MyButton(
              text: 'Commencer',
              onPressed: () {
                RouterService.of(context).go(AppRoutes.createRoom);
              },
            ),
          ],
        ),
      ),
    );
  }
}