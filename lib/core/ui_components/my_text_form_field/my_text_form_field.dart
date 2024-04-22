import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  const MyTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      cursorColor: const Color(0xFFF5F2F0),
      style: GoogleFonts.inter(
        color: const Color(0xFFF5F2F0),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xFFF5F2F0),
        ),
        hintStyle: const TextStyle(
          color: Color(0xFFF5F2F0),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF5F2F0),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF5F2F0),
          ),
        ),
      ),
    );
  }
}
