import 'dart:async';

import 'package:bwy/size_config.dart';
import 'package:bwy/utils/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/custom_colors.dart';

class ChatBottomSheet extends StatefulWidget {
  const ChatBottomSheet({super.key});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  var loadingPercentage = 0;
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse('https://tawk.to/chat/59b774864854b82732fef7b8/default'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Canlı Destek', style: CustomTextStyles2.appBarTextStyle(context)),
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: SizeConfig.screenHeight! * 0.8),
            child: loadingPercentage < 100
                ? LinearProgressIndicator(
                    color: CustomColors.bwyYellow,
                    backgroundColor: Colors.black,
                    value: loadingPercentage / 100.0,
                  )
                : WebViewWidget(
                    controller: controller,
                  ),
          ),
          // child: Stack(
          //   children: [
          //     Align(
          //       alignment: Alignment.center,
          //       child:
          //     ),

          //   ],
          // ),
        ),
      ),
    );
  }
}
