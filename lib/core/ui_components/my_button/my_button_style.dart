import 'package:flutter/material.dart';

sealed class MyButtonStyle {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color strokeColor;

  const MyButtonStyle({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.strokeColor,
  });
}

class MyButtonStylePrimary extends MyButtonStyle {
  MyButtonStylePrimary(BuildContext context)
      : super(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          strokeColor: Theme.of(context).colorScheme.primary,
        );
}

class MyButtonStyleSecondary extends MyButtonStyle {
  MyButtonStyleSecondary(BuildContext context)
      : super(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          foregroundColor: Theme.of(context).colorScheme.primary,
          strokeColor: Theme.of(context).colorScheme.primary,
        );
}
