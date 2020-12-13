import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/order.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/views/utils/image_handling.dart';

class CartItemWidget extends StatefulWidget {
  String heroTag;
  Order order;

  CartItemWidget({Key key, this.order, this.heroTag}) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {

  void _incrementOrder() {
    BlocProvider.of<CartBloc>(context).add(
        OrderQuantityInceremented(widget.order, 1));
  }

  void _decrement() {
    BlocProvider.of<CartBloc>(context).add(
        OrderQuantityDeceremented(widget.order, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .primaryColor
            .withOpacity(0.9),
        boxShadow: [
          BoxShadow(color: Theme
              .of(context)
              .focusColor
              .withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                  image: getImageProvider(this.widget.order.menu.image), fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.order.menu.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme
                            .of(context)
                            .textTheme
                            .display3,
                      ),
                      Text(
                        widget.order.variant.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme
                            .of(context)
                            .textTheme
                            .body2,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.order.toppingList.size(),
                          itemBuilder: (item, index) {
                            return Row(
                              children: [
                                Icon(Icons.add_circle,size: 16, color: Theme
                                    .of(context)
                                    .accentColor,),
                                SizedBox(width: 10,),
                                Text(widget.order.toppingList
                                    .getToppingByIndex(index)
                                    .name, style: Theme
                                    .of(context)
                                    .textTheme
                                    .body1,)
                              ],
                            );
                          }),
                      Row(children: [
                        Text("unit : ",style: Theme.of(context).textTheme.body2,),
                        Text(
                          widget.order.getUnitPrice().toString() + " DA",
                          style: Theme.of(context).textTheme.subhead.copyWith(color : Theme.of(context).accentColor),
                        ),
                      ],),
                      Row(children: [
                        Text("full : ",style: Theme.of(context).textTheme.body2,),
                        Text(
                          widget.order.getFullPrice().toString() + " DA",
                          style: Theme.of(context).textTheme.display2,
                        ),
                      ],),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: _incrementOrder,
                      iconSize: 30,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icon(Icons.add_circle_outline),
                      color: Theme
                          .of(context)
                          .hintColor,
                    ),
                    Text(widget.order.quantity.toString(), style: Theme
                        .of(context)
                        .textTheme
                        .subhead),
                    IconButton(
                      onPressed: _decrement,
                      iconSize: 30,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icon(Icons.remove_circle_outline),
                      color: Theme
                          .of(context)
                          .hintColor,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
