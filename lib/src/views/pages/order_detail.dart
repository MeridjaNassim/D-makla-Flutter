import 'dart:math';
import 'dart:async';
import 'package:dmakla/src/business_logic/models/order.dart';
import 'package:dmakla/src/views/elements/common/loading.dart';
import 'package:dmakla/src/views/elements/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:dmakla/src/models/order.dart';
import 'package:dmakla/src/models/user.dart';
import 'package:dmakla/src/views/elements/OrderItemWidget.dart';
import 'package:dmakla/src/views/elements/ShoppingCartButtonWidget.dart';

import 'package:octo_image/octo_image.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderDetailArguments {
  final ConfirmedOrder order;

  OrderDetailArguments(this.order);
}

class OrderDetailWidget extends StatefulWidget {
  final OrderDetailArguments arguments;

  OrderDetailWidget({this.arguments});

  @override
  _OrderDetailWidgetState createState() => _OrderDetailWidgetState();
}

class _OrderDetailWidgetState extends State<OrderDetailWidget> {
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
            'Details commande',
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
          initialUrl: widget.arguments.order.webViewUrl,
          onWebViewCreated: (controller) {
            _controller.complete(controller);
          },
        ));
  }
}
