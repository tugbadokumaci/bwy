import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Image? backgroundImage;

  const MyContainer({required this.child, this.backgroundColor, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    Color containerColor = backgroundColor ?? Color(0xff222023);
    Widget container = Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );

    if (backgroundImage != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(child: backgroundImage),
          ),
          container
        ],
      );
    }
    return container;
  }
}
