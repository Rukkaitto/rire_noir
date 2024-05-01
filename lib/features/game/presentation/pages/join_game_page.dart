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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JoinGamePage extends StatefulWidget {
  const JoinGamePage({super.key});

  @override
  State<JoinGamePage> createState() => _JoinGamePageState();
}

class _JoinGamePageState extends State<JoinGamePage> {
  final TextEditingController _pinCodeController = TextEditingController();
  bool _isFormValid = false;

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
          SnackBar(
            content: Text(AppLocalizations.of(context)!.joinGameError),
          ),
        );
      }
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
                          controller: _pinCodeController,
                          onChanged: (value) {
                            setState(() {
                              _isFormValid =
                                  value.isNotEmpty && value.trim().length == 6;
                            });
                          },
                          labelText: AppLocalizations.of(context)!.joinGameCode,
                          keyboardType: TextInputType.visiblePassword,
                          textCapitalization: TextCapitalization.characters,
                        ),
                        const SizedBox(height: 22),
                        MyButton(
                          text: AppLocalizations.of(context)!.join,
                          style: MyButtonStylePrimary(context),
                          onPressed: () => _handleJoin(context),
                          enabled: _isFormValid,
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
