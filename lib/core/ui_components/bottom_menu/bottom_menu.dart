import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  final Widget child;

  const BottomMenu({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 3,
            ),
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 25,
            right: 25,
            bottom: 60,
            left: 25,
          ),
          child: child,
        ),
      ),
    );
  }
}
