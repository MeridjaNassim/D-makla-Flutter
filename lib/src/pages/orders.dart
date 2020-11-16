import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/OrderItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/SearchBarWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/order.dart';

class OrdersWidget extends StatelessWidget {
  OrdersList _ordersList = new OrdersList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SearchBarWidget(),
            ),
            SizedBox(height: 10),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: _ordersList.orderedList.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return OrderItemWidget(heroTag: 'my_orders', order: _ordersList.orderedList.elementAt(index));
              },
            ),
          ],
        ),
      ),
    );
  }
}
