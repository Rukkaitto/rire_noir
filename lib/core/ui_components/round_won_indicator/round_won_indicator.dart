import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';
import 'package:rire_noir/features/game/presentation/bloc/round_won/round_won_cubit.dart';

class RoundWonIndicator extends StatefulWidget {
  const RoundWonIndicator({super.key});

  @override
  State<RoundWonIndicator> createState() => _RoundWonIndicatorState();
}

class _RoundWonIndicatorState extends State<RoundWonIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _yPosition;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
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
        context.read<RoundWonCubit>().reset();
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
            SvgPicture.asset(AssetService().svgs.scoreIcon),
            const SizedBox(width: 10),
            Text(
              '+1',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
