import 'package:flutter/material.dart';
import '../extension/context_extension.dart';
import '../size_config.dart';

// class CustomTextStyles {
//   CustomTextStyles();

//   // static TextStyle appBarTitleTextStyle() {
//   //   return TextStyle(
//   //       fontFamily: 'REM', color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.4, fontWeight: FontWeight.bold);
//   // }

//   static TextStyle titleLargeTextStyle() {
//     return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.5, fontWeight: FontWeight.bold);
//   }

//   static TextStyle titleMediumTextStyle() {
//     return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold);
//   }

//   static TextStyle titleSmallTextStyle() {
//     return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2, fontWeight: FontWeight.bold);
//   }

//   static TextStyle titleExtraSmallTextStyle() {
//     return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 1.8, fontWeight: FontWeight.bold);
//   }
// }

class CustomTextStyles2 {
  static TextStyle buttonTextStyle(BuildContext context, Color textColor) {
    return context.theme.textTheme.titleMedium!.copyWith(
      color: textColor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle titleLargeTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontSize: 25,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle titleMediumTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontSize: 22,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle titleSmallTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 20,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle titleExtraSmallTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 18,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle textSmallTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 15,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle textMediumTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 17,
          color: textColor,
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle appBarTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontFamily: 'REM',
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
