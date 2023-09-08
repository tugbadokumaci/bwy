import 'package:bwy/utils/custom_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InternetBottomSheet extends StatefulWidget {
  final String url;
  final String appBarTitle;
  const InternetBottomSheet({super.key, required this.url, required this.appBarTitle});

  @override
  State<InternetBottomSheet> createState() => _InternetBottomSheetState();
}

class _InternetBottomSheetState extends State<InternetBottomSheet> {
  var loadingPercentage = 0;
  late final WebViewController controller;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {Factory(() => EagerGestureRecognizer())};
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
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.appBarTitle, style: CustomTextStyles2.appBarTextStyle(context)),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            loadingPercentage < 100
                ? LinearProgressIndicator(
                    color: Colors.yellow, // Change to your desired color
                    backgroundColor: Colors.black,
                    value: loadingPercentage / 100.0,
                  )
                : SizedBox(), // Hide the progress bar when not loading

            Expanded(
              child: WebViewWidget(
                controller: controller,
                gestureRecognizers: gestureRecognizers,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
