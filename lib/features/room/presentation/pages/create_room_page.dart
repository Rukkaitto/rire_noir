import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/core/services/environment_service/environment_service.dart';
import 'package:rire_noir/core/services/router_service/app_routes.dart';
import 'package:rire_noir/core/services/router_service/router_service.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';

class CreateRoomPage extends StatelessWidget {
  final TextEditingController _pointsController = TextEditingController();

  CreateRoomPage({super.key});

  void handleCreate(BuildContext context) async {
    final winningScore = _pointsController.text;
    final winningScoreInt = int.tryParse(winningScore);

    if (winningScoreInt == null) {
      return;
    }

    try {
      final response = await Dio().postUri<String>(
        EnvironmentService().uri.resolve('/api/room'),
        data: {
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
      appBar: AppBar(
        title: const Text('Créer une partie'),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
