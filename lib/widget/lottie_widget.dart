import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  final String path;
  const LottieWidget({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'animations/$path.json',
      height: 200,
      reverse: false,
      repeat: true,
      // fit: BoxFit.cover,
    );
  }
}
