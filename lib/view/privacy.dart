// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://orbachinujbuk.com/tasbih-app/privacy-policy.php'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontFamily: 'HindSiliguri'),
        ),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
      // const WebView(
      //   initialUrl: '$baseAPIURL/privacy-policy',
      //   javascriptMode: JavascriptMode.unrestricted,
      //   gestureNavigationEnabled: true,
      // ),
    );
  }
}
