import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final IconData? trailingIcon;
  final void Function() onPressed;

  const MyButton({
    super.key,
    required this.text,
    this.trailingIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (trailingIcon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(trailingIcon),
        label: Text(text),
      );
    } else {
      return ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      );
    }
  }
}
