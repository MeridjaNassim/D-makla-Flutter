import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/menu.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';

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
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) =>
          InkWell(
            splashColor: Theme
                .of(context)
                .accentColor,
            focusColor: Theme
                .of(context)
                .accentColor,
            highlightColor: Theme
                .of(context)
                .primaryColor,
            onTap: () {
              BlocProvider.of<MenuCubit>(context).setCurrentMenu(
                  widget.order.menu, selectedVariant: widget.order.variant,
                  selectedToppings: widget.order.toppingList,
                  quantity: widget.order.quantity);
              Navigator.of(context).pushNamed('/Food', arguments: RouteArgument(
                  id: widget.order.menu.id, heroTag: widget.heroTag));
            },
            child: Container(
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
                          image: this.widget.order.menu.image
                              .getImageProvider(), fit: BoxFit.cover),
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
                                "Variant : " + widget.order.variant.name,
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
                                        Icon(Icons.add, color: Theme
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
                              Text(
                                widget.order.menu.pricings.getPriceOfVariant(
                                    widget.order.variant).toString() + " DA",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .display1,
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
            ),
          ),
    );
  }

  incrementQuantity(int quantity) {
    if (quantity <= 99) {
      return ++quantity;
    } else {
      return quantity;
    }
  }

  decrementQuantity(int quantity) {
    if (quantity > 1) {
      return --quantity;
    } else {
      return quantity;
    }
  }
}
