import 'dart:math';

import 'package:api/entities/playing_card.dart';
import 'package:flutter/material.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_style.dart';
import 'package:rire_noir/core/ui_components/playing_card/playing_card_widget.dart';

class CardsReceivedAnimation extends StatefulWidget {
  final List<PlayingCard> cards;

  const CardsReceivedAnimation({
    super.key,
    required this.cards,
  });

  @override
  State<CardsReceivedAnimation> createState() => _CardsReceivedAnimationState();
}

class _CardsReceivedAnimationState extends State<CardsReceivedAnimation>
    with TickerProviderStateMixin {
  late PlayingCard _currentCard;
  late AnimationController _controller;
  late AnimationController _opacityController;
  late Animation<Alignment> _alignment;
  late Animation<double> _scale;
  late Animation<double> _backgroundOpacity;
  late Animation<double> _rotationX;

  @override
  void didChangeDependencies() {
    _startAnimation();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _startAnimation();
    super.initState();
  }

  void _startAnimation() {
    if (widget.cards.isEmpty) {
      return;
    }

    _currentCard = widget.cards.first;

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _opacityController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _backgroundOpacity = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(
      CurvedAnimation(
        parent: _opacityController,
        curve: Curves.easeInOut,
      ),
    );

    _alignment = TweenSequence([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: const Alignment(-8, 0),
          end: const Alignment(0, 0),
        ).chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 20.0,
      ),
      TweenSequenceItem(
        tween: ConstantTween<Alignment>(const Alignment(0, 0)),
        weight: 60.0,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: const Alignment(0, 0),
          end: const Alignment(8, 0),
        ).chain(CurveTween(curve: Curves.easeInOutSine)),
        weight: 20.0,
      ),
    ]).animate(_controller);

    _scale = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.5,
          end: 1,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20.0,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1),
        weight: 60.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1,
          end: 0.5,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20.0,
      ),
    ]).animate(_controller);

    _rotationX = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: -pi,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20.0,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(0),
        weight: 60.0,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: pi,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 20.0,
      ),
    ]).animate(_controller);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          widget.cards.removeAt(0);
          if (widget.cards.isNotEmpty) {
            _currentCard = widget.cards.first;
            _controller.reset();
            _controller.forward();
          } else {
            _opacityController.reverse();
          }
        });
      }
    });

    _controller.forward();
    _opacityController.forward();

    _controller.addListener(() {
      setState(() {});
    });

    _opacityController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(_backgroundOpacity.value),
      child: Align(
        alignment: _alignment.value,
        child: Transform.scale(
          scale: _scale.value,
          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Perspective
              ..rotateY(_rotationX.value),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: PlayingCardWidget(
                text: _currentCard.text,
                style: PlayingCardStyleWhite(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
