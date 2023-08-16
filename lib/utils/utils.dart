import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_colors.dart';

class Utils {
  Utils._();

  static void showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    required Function onTap,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                onTap();
              },
              child: Text('OK', style: TextStyle(color: CustomColors.bwyYellow)),
            ),
          ],
        );
      },
    );
  }

  static void showCustomSnackbar({
    required BuildContext context,
    required String content,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)),
    );
  }
}
