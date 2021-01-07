import 'dart:math';
import 'dart:async';
import 'package:dmakla_flutter/src/business_logic/models/order.dart';
import 'package:dmakla_flutter/src/views/elements/common/loading.dart';
import 'package:dmakla_flutter/src/views/elements/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:dmakla_flutter/src/models/order.dart';
import 'package:dmakla_flutter/src/models/user.dart';
import 'package:dmakla_flutter/src/views/elements/OrderItemWidget.dart';
import 'package:dmakla_flutter/src/views/elements/ShoppingCartButtonWidget.dart';

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
  _TrackingWidgetState createState() => _TrackingWidgetState();
}

class _TrackingWidgetState extends State<OrderDetailWidget> {
  User _user = new User.init().getCurrentUser();
  OrdersList _ordersList = new OrdersList();
  int _currentStep = Random().nextInt(4);
  Completer<WebViewController> _controller = Completer<WebViewController>();
  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        state: StepState.complete,
        title: Text(
          'Order Received',
          style: Theme.of(context).textTheme.subhead,
        ),
        subtitle: Text(
          '16:30 - Your order got confirmed',
          style: Theme.of(context).textTheme.caption,
        ),
        content: SizedBox(height: 50, width: double.infinity),
        isActive: _currentStep >= 0,
      ),
      Step(
        state: StepState.complete,
        title: Text(
          'Preparing',
          style: Theme.of(context).textTheme.subhead,
        ),
        subtitle: Text(
          '16:40 - We start pereparing your dish',
          style: Theme.of(context).textTheme.caption,
        ),
        content: SizedBox(height: 50, width: double.infinity),
        isActive: _currentStep >= 1,
      ),
      Step(
        state: StepState.complete,
        title: Text(
          'Cooking',
          style: Theme.of(context).textTheme.subhead,
        ),
        subtitle: Text(
          '16:50 - We are started cooking the food',
          style: Theme.of(context).textTheme.caption,
        ),
        content: SizedBox(height: 50, width: double.infinity),
        isActive: _currentStep >= 2,
      ),
      Step(
        state: StepState.complete,
        title: Text(
          'It\'s Ready',
          style: Theme.of(context).textTheme.subhead,
        ),
        subtitle: Text(
          'Start to deliver your order',
          style: Theme.of(context).textTheme.caption,
        ),
        content: SizedBox(height: 50, width: double.infinity),
        isActive: _currentStep >= 3,
      ),
      Step(
        state: StepState.complete,
        title: Text(
          'Delivered',
          style: Theme.of(context).textTheme.subhead,
        ),
        subtitle: Text(
          'Enjoy your meal, and have great day',
          style: Theme.of(context).textTheme.caption,
        ),
        content: SizedBox(height: 50, width: double.infinity),
        isActive: _currentStep >= 4,
      )
    ];
    return _steps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Details commande',
            style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
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
