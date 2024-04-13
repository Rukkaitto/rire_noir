import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'playing_card_style.dart';
import 'playing_card_title_widget.dart';

class PlayingCardWidget extends StatelessWidget {
  final String text;
  final PlayingCardStyle style;

  const PlayingCardWidget({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      height: 480,
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
          PlayingCardTitleWidget(text: text, style: style),
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
    );
  }
}
