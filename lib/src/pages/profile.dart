import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/OrderItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ProfileAvatarWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/order.dart';

class ProfileWidget extends StatelessWidget {
  OrdersList _ordersList = new OrdersList();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        children: <Widget>[
          ProfileAvatarWidget(),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.person,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'About',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical professor Read More',
              style: Theme.of(context).textTheme.body1,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.shopping_basket,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Recent Orders',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: _ordersList.recentOrderedList.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return OrderItemWidget(
                heroTag: 'profile_orders',
                order: _ordersList.recentOrderedList.elementAt(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
