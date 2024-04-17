import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rire_noir/core/services/asset_service/asset_service.dart';

class ScrollingBackground extends StatefulWidget {
  final Widget child;

  const ScrollingBackground({
    super.key,
    required this.child,
  });

  @override
  State<ScrollingBackground> createState() => _ScrollingBackgroundState();
}

class _ScrollingBackgroundState extends State<ScrollingBackground>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 16),
      upperBound: 512,
      vsync: this,
    )..repeat();

    _controller!.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -_controller!.value,
          left: -_controller!.value,
          child: SizedBox(
            width: 2048,
            height: 2048,
            child: Image.asset(
              AssetService().images.bgTile,
              repeat: ImageRepeat.repeat,
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}
