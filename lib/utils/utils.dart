import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../navigator_key.dart';
import 'custom_colors.dart';

class Utils {
  Utils._();

  Utils.showCustomDialog({
    // required BuildContext context,
    required String title,
    required String content,
    required Function onTap,
  }) {
    showCupertinoDialog(
      context: navigatorKey.currentContext!,
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

  Utils.showCustomDialogSnackbar({
    required BuildContext context,
    required String content,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)),
    );
  }
}
