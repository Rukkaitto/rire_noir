import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TutorialOverlay extends StatefulWidget {
  final Widget child;

  const TutorialOverlay({
    super.key,
    required this.child,
  });

  @override
  State<TutorialOverlay> createState() => _TutorialOverlayState();
}

class _TutorialOverlayState extends State<TutorialOverlay> {
  static const String tutorialShownKey = 'tutorialShown';

  int _currentStep = 1;
  bool _showTutorial = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      _checkIfTutorialIsNeeded();
    });
    super.initState();
  }

  void _checkIfTutorialIsNeeded() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey(tutorialShownKey)) {
      setState(() {
        _showTutorial = true;
      });
    }
  }

  void _saveTutorialShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(tutorialShownKey, true);
  }

  void _incrementStep() {
    setState(() {
      _currentStep++;

      if (_currentStep > 2) {
        _showTutorial = false;
        _saveTutorialShown();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: Builder(
        key: ValueKey(_showTutorial),
        builder: (context) {
          if (_showTutorial == false) {
            return widget.child;
          }

          return Stack(
            children: [
              widget.child,
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.all(25),
                  width: double.infinity,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    child: SafeArea(
                      key: ValueKey(_currentStep),
                      child: buildStep(context),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildStep(BuildContext context) {
    switch (_currentStep) {
      case 1:
        return buildStep1(context);
      case 2:
        return buildStep2(context);
      default:
        return Container();
    }
  }

  Widget buildStep1(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.tutorialSwipeUp,
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        Lottie.asset(
          AssetService().lotties.swipeUp,
          frameRate: FrameRate.max,
        ),
        MyButton(
          text: AppLocalizations.of(context)!.tutorialNextButton,
          style: MyButtonStylePrimary(context),
          onPressed: _incrementStep,
        ),
      ],
    );
  }

  Widget buildStep2(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.tutorialSwipeLeft,
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
        Lottie.asset(
          AssetService().lotties.swipeLeft,
          frameRate: FrameRate.max,
        ),
        MyButton(
          text: AppLocalizations.of(context)!.tutorialBeginButton,
          style: MyButtonStylePrimary(context),
          onPressed: _incrementStep,
        ),
      ],
    );
  }
}
