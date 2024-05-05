import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'package:rire_noir/features/game/presentation/bloc/cards_dealt/cards_dealt_cubit.dart';

class NewCardsIndicator extends StatefulWidget {
  final int newCardsCount;

  const NewCardsIndicator({
    super.key,
    required this.newCardsCount,
  });

  @override
  State<NewCardsIndicator> createState() => _NewCardsIndicatorState();
}

class _NewCardsIndicatorState extends State<NewCardsIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _yPosition;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0,
        0.5,
        curve: Curves.easeInOut,
      ),
    );

    _yPosition = Tween<double>(
      begin: 0,
      end: 30,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2), () {
          _controller.reverse();
        });
      } else if (status == AnimationStatus.dismissed) {
        context.read<CardsDealtCubit>().reset();
      }
    });

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _opacity.value,
      child: Padding(
        padding: EdgeInsets.only(top: _yPosition.value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AssetService().svgs.whiteCardIcon),
            const SizedBox(width: 10),
            Text(
              '+${widget.newCardsCount}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
