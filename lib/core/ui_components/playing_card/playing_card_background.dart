import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'playing_card_style.dart';

class PlayingCardBackground extends StatelessWidget {
  final PlayingCardStyle style;
  final Widget? child;

  const PlayingCardBackground({
    super.key,
    required this.style,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1 / 1.5,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: style.foregroundColor,
          ),
          borderRadius: BorderRadius.circular(20),
          color: style.backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: child ?? const SizedBox(),
            ),
            Row(
              children: [
                Text(
                  'Rire Noir',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: style.foregroundColor,
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  AssetService().svgs.logo,
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
