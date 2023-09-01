import 'package:flutter/material.dart';

import '../size_config.dart';

class CustomTextStyles {
  CustomTextStyles();
  static TextStyle appBarTitleTextStyle() {
    return TextStyle(
        fontFamily: 'REM', color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.4, fontWeight: FontWeight.bold);
  }

  static TextStyle titleLargeTextStyle() {
    return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.5, fontWeight: FontWeight.bold);
  }

  static TextStyle titleMediumTextStyle() {
    return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold);
  }

  static TextStyle titleSmallTextStyle() {
    return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2, fontWeight: FontWeight.bold);
  }

  static TextStyle titleExtraSmallTextStyle() {
    return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 1.8, fontWeight: FontWeight.bold);
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
