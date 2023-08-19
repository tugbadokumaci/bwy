import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor; // Yeni özellik: Arka plan rengi

  const MyContainer({required this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    Color containerColor = backgroundColor ?? Color(0xff222023);

    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
