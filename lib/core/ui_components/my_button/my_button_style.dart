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
  const MyButtonStylePrimary()
      : super(
          backgroundColor: const Color(0xFFF5F2F0),
          foregroundColor: const Color(0xFF29302E),
          strokeColor: const Color(0xFFF5F2F0),
        );
}

class MyButtonStyleSecondary extends MyButtonStyle {
  const MyButtonStyleSecondary()
      : super(
          backgroundColor: const Color(0xFF29302E),
          foregroundColor: const Color(0xFFF5F2F0),
          strokeColor: const Color(0xFFF5F2F0),
        );
}
