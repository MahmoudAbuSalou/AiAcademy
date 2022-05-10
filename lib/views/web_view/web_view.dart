// ignore: slash_for_doc_comments
/**
 * this page responsible for display web page inside Flutter App
 * like Register and display BDF file
 *
 * **/
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  String  Url;

  // ignore: non_constant_identifier_names, use_key_in_widget_constructors
  WebPage({required this.Url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl:Url,
      ),
    );
  }
}
