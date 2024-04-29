import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/ui_components/bottom_menu/bottom_menu.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button_style.dart';
import 'package:rire_noir/core/ui_components/my_text_form_field/my_text_form_field.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseNameWidget extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  ChooseNameWidget({super.key});

  void _handleJoin(BuildContext context) async {
    final name = _nameController.text.trim();

    context.read<WebSocketCubit>().setName(name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                    controller: _nameController,
                    labelText: AppLocalizations.of(context)!.chooseNameLabel,
                    keyboardType: TextInputType.visiblePassword,
                    textCapitalization: TextCapitalization.characters,
                  ),
                  const SizedBox(height: 22),
                  MyButton(
                    text: AppLocalizations.of(context)!.join,
                    style: MyButtonStylePrimary(context),
                    onPressed: () => _handleJoin(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
