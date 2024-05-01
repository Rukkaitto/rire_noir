import 'package:flutter/material.dart';
import 'package:rire_noir/core/ui_components/my_button/my_button_style.dart';

class MyButton extends StatelessWidget {
  final String text;
  final MyButtonStyle style;
  final IconData? trailingIcon;
  final void Function() onPressed;
  final bool enabled;

  const MyButton({
    super.key,
    required this.text,
    required this.style,
    this.trailingIcon,
    required this.onPressed,
    this.enabled = true,
  });

  ButtonStyle buildStyle() {
    return FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      backgroundColor: style.backgroundColor,
      foregroundColor: style.foregroundColor,
      disabledBackgroundColor: style.backgroundColor,
      disabledForegroundColor: style.foregroundColor,
      side: BorderSide(
        color: style.strokeColor,
        width: 3,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      opacity: enabled ? 1 : 0.5,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        style: buildStyle(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: style.foregroundColor),
            ),
            if (trailingIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  trailingIcon,
                  color: style.foregroundColor,
                  size: 30,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
