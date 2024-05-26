import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rire_noir/core/ui_components/bottom_menu/bottom_menu.dart';
import 'package:rire_noir/core/ui_components/main_title/main_title.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button_style.dart';
import 'package:rire_noir/core/ui_components/my_text_form_field/my_text_form_field.dart';
import 'package:rire_noir/core/ui_components/scrolling_background/scrolling_background.dart';
import 'package:rire_noir/features/game/presentation/bloc/web_socket/web_socket_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChooseNameWidget extends StatefulWidget {
  const ChooseNameWidget({super.key});

  @override
  State<ChooseNameWidget> createState() => _ChooseNameWidgetState();
}

class _ChooseNameWidgetState extends State<ChooseNameWidget> {
  final TextEditingController _nameController = TextEditingController();
  bool _isFormValid = false;

  void _handleJoin(BuildContext context) async {
    final name = _nameController.text.trim();

    context.read<WebSocketCubit>().setName(name);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollingBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Expanded(
            child: Center(
              child: Hero(
                tag: 'main-title',
                child: MainTitle(),
              ),
            ),
          ),
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
                      onChanged: (value) {
                        setState(() {
                          _isFormValid = value.isNotEmpty;
                        });
                      },
                      labelText: AppLocalizations.of(context)!.chooseNameLabel,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
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
    );
  }
}
