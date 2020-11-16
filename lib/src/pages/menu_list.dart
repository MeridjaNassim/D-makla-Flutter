import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/DrawerWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/FoodsCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/OrderItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ShoppingCartButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/order.dart';

class MenuWidget extends StatelessWidget {
  OrdersList _ordersList = new OrdersList();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'The Dairy Miralova',
          style: Theme.of(context).textTheme.title.merge(TextStyle(letterSpacing: 0)),
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.search, color: Theme.of(context).accentColor),
                  suffixIcon: Icon(Icons.mic_none, color: Theme.of(context).focusColor.withOpacity(0.7)),
                  border:
                      OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                ),
              ),
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.trending_up,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Trending This Week',
                style: Theme.of(context).textTheme.display1,
              ),
              subtitle: Text(
                'Double click on the food to add it to the cart',
                style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 11)),
              ),
            ),
            FoodsCarouselWidget(),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.list,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'All Menu',
                style: Theme.of(context).textTheme.display1,
              ),
              subtitle: Text(
                'Longpress on the food to add suplements',
                style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 11)),
              ),
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: _ordersList.orderedList.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                return OrderItemWidget(
                  heroTag: 'menu_list',
                  order: _ordersList.orderedList.elementAt(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
