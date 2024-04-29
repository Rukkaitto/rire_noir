import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rire_noir/core/services/router_service/router_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late final _router = RouterService.createRouter();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp.router(
      title: 'Rire Noir',
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      routerDelegate: _router.routerDelegate,
      theme: ThemeData(
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.inter(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF5F2F0),
          ),
          labelLarge: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF5F2F0),
          ),
          labelSmall: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF5F2F0),
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFF5F2F0),
          secondary: Color(0xFFF5F2F0),
          tertiary: Color(0xFFF5F2F0),
          onPrimary: Color(0xFF29302E),
          onSecondary: Color(0xFF29302E),
          onTertiary: Color(0xFF29302E),
          background: Color(0xFF29302E),
          surface: Color(0xFF29302E),
          outline: Color(0xFFF5F2F0),
        ),
        useMaterial3: true,
      ),
    );
  }
}
