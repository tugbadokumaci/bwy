import 'package:flutter/material.dart';

class BwyView extends StatelessWidget {
  const BwyView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text('Bursa Web Yazılım')),
    ));
  }
}
