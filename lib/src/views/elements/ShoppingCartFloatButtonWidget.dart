import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.state.dart';

class ShoppingCartFloatButtonWidget extends StatelessWidget {
  const ShoppingCartFloatButtonWidget({
    this.iconColor,
    this.labelColor,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        color: Theme.of(context).accentColor,
        shape: StadiumBorder(),
        onPressed: () {
          Navigator.of(context).pushNamed('/Cart');
        },
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            Icon(
              Icons.shopping_cart,
              color: this.iconColor,
              size: 28,
            ),
            Container(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) => Text(
                  (state is LoadedCartState)
                      ? state.cart.totalNumberOfOrders().toString()
                      : "..",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption.merge(
                        TextStyle(
                            color: Theme.of(context).primaryColor, fontSize: 9),
                      ),
                ),
              ),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  color: this.labelColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              constraints: BoxConstraints(
                  minWidth: 15, maxWidth: 15, minHeight: 15, maxHeight: 15),
            ),
          ],
        ),
      ),
    );
//    return FlatButton(
//      onPressed: () {
//        //print('to shopping cart');
//      },
//      child:
//      color: Colors.transparent,
//    );
  }
}
