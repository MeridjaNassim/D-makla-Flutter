import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.event.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.state.dart';
import 'package:dmakla/src/business_logic/blocs/store/order.cubit.dart';
import 'package:dmakla/src/business_logic/models/order.dart';
import 'package:dmakla/src/models/route_argument.dart';
import 'package:dmakla/src/views/utils/image_handling.dart';
import 'package:octo_image/octo_image.dart';

import 'common/loading.dart';

class CartItemWidget extends StatefulWidget {
  String heroTag;
  Order order;

  CartItemWidget({Key key, this.order, this.heroTag}) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  void _incrementOrder() {
    BlocProvider.of<CartBloc>(context)
        .add(OrderQuantityInceremented(widget.order, 1));
  }

  void _decrement() {
    BlocProvider.of<CartBloc>(context)
        .add(OrderQuantityDeceremented(widget.order, 1));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 90,
            width: 90,
            child: OctoImage(
              placeholderBuilder: (context) => LoadingImage(),
              errorBuilder: (context, obj, trace) => Image(
                image: NetworkImage(
                    "https://scontent-mrs2-2.xx.fbcdn.net/v/t1.0-9/122494003_105148951389175_3661855520522376578_n.jpg?_nc_cat=102&ccb=2&_nc_sid=09cbfe&_nc_eui2=AeFxcuRlac4GH3vpvnSMNWlJTwaMXICKbSVPBoxcgIptJfrGHjEXcfBlob9Lk5qIFCD9_84FZKPBIPxDzuh8-L_Z&_nc_ohc=GnQTehWWkuUAX9YpUPA&_nc_ht=scontent-mrs2-2.xx&oh=5b069011fd606cd7b3182cd228beb4f1&oe=600723C1"),
              ),
              fit: BoxFit.cover,
              image: getImageProvider(widget.order.menu.image),
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
                        style: Theme.of(context).textTheme.display3,
                      ),
                      Text(
                        widget.order.variant.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.body2,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.order.toppingList.size(),
                          itemBuilder: (item, index) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  size: 16,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    widget.order.toppingList
                                        .getToppingByIndex(index)
                                        .name,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                )
                              ],
                            );
                          }),
                      widget.order.note.isNotEmpty
                          ? Row(
                              children: [
                                Icon(
                                  Icons.chat,
                                  size: 14,
                                  color: Theme.of(context).accentColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(widget.order.note,
                                    style: Theme.of(context).textTheme.caption),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "unit : ",
                            style: Theme.of(context).textTheme.body2,
                          ),
                          Expanded(
                            child: Text(
                              widget.order.getUnitPrice().toInt().toString() +
                                  " DA",
                              style: Theme.of(context)
                                  .textTheme
                                  .subhead
                                  .copyWith(
                                      color: Theme.of(context).accentColor),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "total : ",
                            style: Theme.of(context).textTheme.body2,
                          ),
                          Expanded(
                            child: Text(
                              widget.order.getFullPrice().toInt().toString() +
                                  " DA",
                              style: Theme.of(context).textTheme.display2,
                            ),
                          ),
                        ],
                      ),
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
                      color: Theme.of(context).hintColor,
                    ),
                    Text(widget.order.quantity.toString(),
                        style: Theme.of(context).textTheme.subhead),
                    IconButton(
                      onPressed: _decrement,
                      iconSize: 30,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icon(Icons.remove_circle_outline),
                      color: Theme.of(context).hintColor,
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
