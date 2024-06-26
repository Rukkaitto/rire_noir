import 'package:flutter/material.dart';
import 'package:rire_noir/core/services/router_service/app_routes.dart';
import 'package:rire_noir/core/services/router_service/router_service.dart';
import 'package:rire_noir/core/ui_components/bottom_menu/bottom_menu.dart';
import 'package:rire_noir/core/ui_components/main_title/main_title.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button_style.dart';
import 'package:rire_noir/core/ui_components/scrolling_background/scrolling_background.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScrollingBackground(
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MyButton(
                        text: AppLocalizations.of(context)!.join,
                        style: MyButtonStylePrimary(context),
                        onPressed: () {
                          RouterService.of(context).go(AppRoutes.joinRoom);
                        },
                      ),
                      const SizedBox(height: 22),
                      MyButton(
                        text: AppLocalizations.of(context)!.start,
                        style: MyButtonStyleSecondary(context),
                        onPressed: () {
                          RouterService.of(context).go(AppRoutes.createRoom);
                        },
                      ),
                    ],
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
