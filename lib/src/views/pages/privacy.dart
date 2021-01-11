import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dmakla/src/views/elements/ShoppingCartButtonWidget.dart';

import 'package:webview_flutter/webview_flutter.dart';

class ConfidentialityArguments {
  final String webViewUrl;

  ConfidentialityArguments(this.webViewUrl);
}

class ConfidentialityPage extends StatefulWidget {
  final ConfidentialityArguments arguments;

  ConfidentialityPage({this.arguments});

  @override
  _ConfidentialityPageState createState() => _ConfidentialityPageState();
}

class _ConfidentialityPageState extends State<ConfidentialityPage> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Theme.of(context).accentColor),
          title: Text(
            'Confidentialité',
            style: Theme.of(context)
                .textTheme
                .title
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor,
                labelColor: Theme.of(context).accentColor),
          ],
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: widget.arguments.webViewUrl,
          onWebViewCreated: (controller) {
            _controller.complete(controller);
          },
        ));
  }
}
