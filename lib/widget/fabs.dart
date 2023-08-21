import 'package:bwy/size_config.dart';
import 'package:bwy/widget/chat_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants.dart';
import '../utils/custom_colors.dart';

class FABs {
  static FloatingActionButton buildMessageFab(BuildContext context) {
    return FloatingActionButton(
        heroTag: 'messageButton',
        tooltip: 'Start the chat',
        backgroundColor: CustomColors.bwyYellow,
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            useSafeArea: true,
            context: context,
            builder: (BuildContext context) {
              return ChatBottomSheet();
              // return SizedBox(
              //   height: SizeConfig.screenHeight! * 0.8,
              //   child: Center(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       mainAxisSize: MainAxisSize.min,
              //       children: <Widget>[
              //         const Text('Modal BottomSheet'),
              //         ElevatedButton(
              //           child: const Text('Close BottomSheet'),
              //           onPressed: () => Navigator.pop(context),
              //         ),
              //       ],
              //     ),
              //   ),
              // );
            },
          );
        },
        child: Icon(Icons.message, color: Colors.white));
  }

  static FloatingActionButton buildCallFab(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'callButton',
      backgroundColor: CustomColors.bwyRed,
      tooltip: 'Ara $phoneNumber',
      onPressed: () {
        debugPrint('must start call');
        dynamic launchTel() async {
          try {
            Uri phone = Uri(
              scheme: 'tel',
              path: '+90 532 44 99 224',
            );

            await launchUrl(phone);
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      },
      child: Icon(Icons.call, color: Colors.white),
    );
  }
}
