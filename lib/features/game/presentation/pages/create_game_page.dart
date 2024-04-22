import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/core/services/environment_service/environment_service.dart';
import 'package:rire_noir/core/services/router_service/app_routes.dart';
import 'package:rire_noir/core/services/router_service/router_service.dart';
import 'package:rire_noir/core/ui_components/bottom_menu/bottom_menu.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button_style.dart';
import 'package:rire_noir/core/ui_components/my_text_form_field/my_text_form_field.dart';
import 'package:rire_noir/core/ui_components/scrolling_background/scrolling_background.dart';

class CreateGamePage extends StatelessWidget {
  final TextEditingController _pointsController = TextEditingController();

  CreateGamePage({super.key});

  void handleCreate(BuildContext context) async {
    final winningScore = _pointsController.text.trim();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: ScrollingBackground(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Hero(
                tag: 'bottom-menu',
                child: BottomMenu(
                  child: Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MyTextFormField(
                          controller: _pointsController,
                          labelText: 'Score gagnant',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 22),
                        MyButton(
                          text: 'Créer',
                          style: MyButtonStylePrimary(context),
                          onPressed: () => handleCreate(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}