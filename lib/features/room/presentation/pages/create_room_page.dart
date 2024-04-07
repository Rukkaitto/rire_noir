import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/core/services/router_service/app_routes.dart';
import 'package:rire_noir/core/services/router_service/router_service.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CreateRoomPage extends StatelessWidget {
  final TextEditingController _playersController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();

  CreateRoomPage({super.key});

  void handleCreate(BuildContext context) async {
    final capacity = _playersController.text;
    final winningScore = _pointsController.text;

    final capacityInt = int.tryParse(capacity);
    final winningScoreInt = int.tryParse(winningScore);

    if (capacityInt == null || winningScoreInt == null) {
      return;
    }

    try {
      final response = await Dio().post<String>(
        'http://localhost:8081/room',
        data: {
          'capacity': capacityInt,
          'winningScore': winningScoreInt,
        },
      );

      final pinCode = response.data;

      if (!context.mounted) {
        return;
      }

      RouterService.of(context).go(AppRoutes.createdRoom, queryParameters: {
        'pinCode': pinCode,
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _playersController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de joueurs',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pointsController,
                decoration: const InputDecoration(
                  labelText: 'Points pour gagner',
                ),
              ),
              const SizedBox(height: 16),
              MyButton(
                onPressed: () => handleCreate(context),
                text: 'Créer',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
