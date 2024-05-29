import 'package:flutter/material.dart';

class DismissibleCarousel extends StatelessWidget {
  final List<Widget> children;
  final Function(int) onDismissed;
  final bool canDismiss;
  final Alignment alignment;

  const DismissibleCarousel({
    super.key,
    required this.children,
    required this.onDismissed,
    this.canDismiss = true,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      clipBehavior: Clip.none,
      physics: const PageScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      scrollDirection: Axis.horizontal,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: children[index].key!,
          movementDuration: const Duration(milliseconds: 500),
          direction: canDismiss ? DismissDirection.up : DismissDirection.none,
          onDismissed: (direction) {
            onDismissed(index);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            alignment: alignment,
            child: children[index],
          ),
        );
      },
    );
  }
}
