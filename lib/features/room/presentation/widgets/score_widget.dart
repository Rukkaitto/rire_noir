import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ScoreWidget extends StatelessWidget {
  final int score;

  const ScoreWidget({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text(
          score.toString(),
          style: GoogleFonts.inter(
            color: const Color(0xFFF5F2F0),
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
