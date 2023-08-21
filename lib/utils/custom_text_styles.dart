import 'package:flutter/material.dart';

import '../size_config.dart';

class CustomTextStyles {
  Color? textColor;

  CustomTextStyles({this.textColor});

  TextStyle titleTextStyle() {
    Color color = textColor ?? Colors.white;
    return TextStyle(color: color, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold);
  }
}

class CustomTextStyles2 {
  static TextStyle buttonTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle titleTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        );
  }
}


// abstract class AppStyle {
//   TextStyle buttonTextStyle(BuildContext context, Color textColor) {
//     return Theme.of(context).textTheme.titleMedium!.copyWith(
//           color: textColor,
//           fontWeight: FontWeight.bold,
//         );
//   }

//   TextStyle titleTextStyle(BuildContext context, Color textColor) {
//     return Theme.of(context).textTheme.headlineMedium!.copyWith(
//           color: textColor,
//           fontWeight: FontWeight.bold,
//         );
//   }
// }
