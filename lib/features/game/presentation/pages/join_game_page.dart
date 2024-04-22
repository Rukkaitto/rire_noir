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

class JoinGamePage extends StatelessWidget {
  final TextEditingController _pinCodeController = TextEditingController();

  JoinGamePage({super.key});

  void _handleJoin(BuildContext context) async {
    final pinCode = _pinCodeController.text.toUpperCase().trim();

    try {
      await Dio()
          .getUri(EnvironmentService().uri.resolve('/api/room/$pinCode'));

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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF29302E),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFF5F2F0),
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
                          controller: _pinCodeController,
                          labelText: 'Code PIN du jeu',
                          keyboardType: TextInputType.visiblePassword,
                          textCapitalization: TextCapitalization.characters,
                        ),
                        const SizedBox(height: 22),
                        MyButton(
                          text: 'Rejoindre',
                          style: const MyButtonStylePrimary(),
                          onPressed: () => _handleJoin(context),
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
