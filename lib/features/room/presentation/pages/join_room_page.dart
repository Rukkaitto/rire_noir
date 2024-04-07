import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/core/services/router_service/app_routes.dart';
import 'package:rire_noir/core/services/router_service/router_service.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';

class JoinRoomPage extends StatelessWidget {
  final TextEditingController _pinCodeController = TextEditingController();

  JoinRoomPage({super.key});

  void _handleJoin(BuildContext context) async {
    final pinCode = _pinCodeController.text;

    try {
      await Dio().get('http://localhost:8081/room/$pinCode');

      if (!context.mounted) {
        return;
      }

      RouterService.of(context).go(AppRoutes.joinedRoom, queryParameters: {
        'pinCode': pinCode,
      });
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code PIN invalide'),
          ),
        );
      } else {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rejoindre une partie'),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _pinCodeController,
                decoration: const InputDecoration(
                  labelText: 'Code PIN du jeu',
                ),
              ),
              const SizedBox(height: 16),
              MyButton(
                onPressed: () => _handleJoin(context),
                text: 'Rejoindre',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
