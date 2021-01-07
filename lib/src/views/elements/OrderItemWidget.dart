import 'package:dmakla/src/business_logic/models/order.dart';
import 'package:dmakla/src/views/elements/BlockButtonWidget.dart';
import 'package:dmakla/src/views/pages/order_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

import 'common/loading.dart';
import 'common/widgets.dart';
class OrderItemWidget extends StatelessWidget {
  final String heroTag;
  final ConfirmedOrder order;

  const OrderItemWidget({Key key, this.order, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal : 20.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.2), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Hero(
                      tag: this.heroTag+order.id,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        height: 80,
                        width: 80,
                        child: OctoImage(
                          placeholderBuilder: (context)=> LoadingImage(),
                          errorBuilder: (context,obj,trace)=> Image(image: FAILED_TO_LOAD_FOOD_IMAGE),
                          fit: BoxFit.cover,
                          image: NetworkImage(order.imageUrl),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Order ID",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                           order.id,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Text(
                          order.statusText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                 Expanded(
                     child: Align(
                       alignment: Alignment.topRight,
                       child: Text(
                   getStatusText(context, order.status),
                   overflow: TextOverflow.ellipsis,
                   style: Theme.of(context).textTheme.body2.copyWith(color: getTextColor(context,order.status)),
                 ),
                     ))
                ],
              ),
            ),
            ListTile(
              dense: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                Icons.menu,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Menus commandés',
                style: Theme.of(context).textTheme.display1.copyWith(color: Theme.of(context).accentColor),
              ),
            ),
            ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context,index) {
              final menuData = order.orderedMenus[index];
              return ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  menuData.menuName +" (Qt: "+menuData.quantity.toString()+")",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.display1,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      menuData.variante,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      menuData.restaurantName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.body2.copyWith(color: Theme.of(context).accentColor.withOpacity(0.6)),
                    )
                  ],
                ),
                trailing: Text(
                  menuData.price.toString()+"DA",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.display2,
                ),
              );
            }, separatorBuilder: (context,index){
              return SizedBox(height: 5,);
            }, itemCount: order.orderedMenus.length),
            ListTile(
              dense: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                Icons.delivery_dining,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Livraison',
                style: Theme.of(context).textTheme.display1.copyWith(color: Theme.of(context).accentColor),
              ),
            ),
            ListTile(
              dense: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 0),
              title: Text(
                "Date & Heure",
                style: Theme.of(context).textTheme.display1,
              ),
              trailing:  Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    order.date,
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Text(
                    order.time,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ],
              ),
            ),
            ListTile(
              dense: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 0),
              title: Text(
                "Livrée à",
                style: Theme.of(context).textTheme.display1,
              ),
              trailing:  Text(
                order.deliveryLocation,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.body2,
              ),
            ),
            ListTile(
              dense: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 0),
              title: Text(
                "Total commande",
                style: Theme.of(context).textTheme.display1,
              ),
              trailing:  Text(
                order.orderPrice.toString()+"DA",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.display1.copyWith(color: Theme.of(context).accentColor),
              ),
            ),
            ListTile(
              dense: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 0),
              title: Text(
                "Frais livraison",
                style: Theme.of(context).textTheme.display1,
              ),
              trailing:  Text(
                order.deliveryPrice.toString()+"DA",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            ListTile(
              dense: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 0),
              title: Text(
                "Réduction",
                style: Theme.of(context).textTheme.display1,
              ),
              trailing:  Text(
                "-"+(order.discount ?? 0).toString()+"DA",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subhead.copyWith(color : Colors.green),
              ),
            ),
            ListTile(
              dense: true,
              contentPadding:
              EdgeInsets.symmetric(vertical: 0),
              title: Text(
                "Total",
                style: Theme.of(context).textTheme.display2,
              ),
              trailing:  Text(
                order.totalPrice.toString()+"DA",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.display3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: BlockButtonWidget(
                  color: Theme.of(context).accentColor,
                  text: Text("Voir détails",textAlign: TextAlign.center,style: TextStyle(color: Theme.of(context).primaryColor),),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/OrderDetail',arguments: OrderDetailArguments(this.order));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  getStatusText(BuildContext context,String status) {
    if(status == "1")
      return "en cours";
    if(status == "2")
      return "lancé";
    if(status == "3")
      return "terminé";
  }
  getTextColor(BuildContext context,String status) {
    if(status == "3")
      return Colors.green;
    if(status == "1")
      return Colors.yellow[900];
    if(status == "2")
      return Colors.red;
    return Theme.of(context).accentColor;
  }
}
