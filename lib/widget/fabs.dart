import 'package:bwy/widget/chat_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';
import '../utils/custom_colors.dart';

class FABs {
  static FloatingActionButton buildMessageFab(BuildContext context) {
    return FloatingActionButton(
        heroTag: 'messageButton',
        tooltip: 'Start the chat',
        backgroundColor: Color(0xffFF7D00),
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
    Future<void> _makePhoneCall() async {
      // final Uri launchUri = Uri(
      //   scheme: 'tel',
      //   path: '+1-555-010-9999',
      // );
      Uri launchUri = Uri.parse('tel:+1-555-010-9999');

      await launchUrl(launchUri);
    }
    // final Uri _url = Uri(scheme: 'tel', path: '+1-555-010-9999');
    // Future<void> openDialer(String phoneNumber) async {
    //   Uri callUrl = Uri.parse('tel:$phoneNumber');
    //   await launchUrl(callUrl);
    //   debugPrint('2');
    // }

    // dynamic makeCall() async {
    //   Uri phone = Uri(
    //     scheme: 'tel',
    //     path: '+1-555-010-9999',
    //   );

    //   await launchUrl(phone);
    // }

    return FloatingActionButton(
      heroTag: 'callButton',
      backgroundColor: CustomColors.bwyRed,
      tooltip: 'Ara $phoneNumber',
      onPressed: () {
        _makePhoneCall();
      },
      child: Icon(Icons.call, color: Colors.white),
    );
  }
}
