import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/OrderItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ShoppingCartButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/order.dart';
import 'package:restaurant_rlutter_ui/src/models/user.dart';

class TrackingWidget extends StatefulWidget {
  @override
  _TrackingWidgetState createState() => _TrackingWidgetState();
}

class _TrackingWidgetState extends State<TrackingWidget> {
  User _user = new User.init().getCurrentUser();
  OrdersList _ordersList = new OrdersList();
  int _currentStep = Random().nextInt(4);

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
            'Tracking Order',
            style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 1.3)),
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Column(
            children: <Widget>[
              OrderItemWidget(heroTag: 'my_orders', order: _ordersList.orderedList.elementAt(0)),
              SizedBox(height: 20),
              Theme(
                data: ThemeData(
                  primaryColor: Theme.of(context).accentColor,
                ),
                child: Stepper(
                  controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                    return SizedBox(height: 0);
                  },
                  steps: _mySteps(),
                  currentStep: this._currentStep,
                ),
              ),
            ],
          ),
        ));
  }
}
