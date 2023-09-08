import 'package:bwy/extension/string_extension.dart';
import 'package:bwy/lang/locale_keys.g.dart';
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
              child: Text(LocaleKeys.profile_ok.locale, style: TextStyle(color: Colors.blue)),
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

  Utils.showCustomDialogWithOptions({
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Seçenekleri yatay olarak ortala
              children: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(LocaleKeys.profile_goBackButton.locale, style: TextStyle(color: Colors.blue)),
                ),
                Divider(
                  color: Colors.black87,
                  height: 10.0,
                  // indent: 5.0, // Starting Space
                  // endIndent: 5.0 // Ending Space
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    onTap();
                  },
                  child: Text(LocaleKeys.profile_deleteAccount.locale, style: TextStyle(color: CustomColors.bwyRed)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
