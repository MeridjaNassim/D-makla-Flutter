import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.state.dart';
import 'package:restaurant_rlutter_ui/src/models/food.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/CartItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/common/loading.dart';


class CartWidget extends StatefulWidget {
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Cart',
          style: Theme
              .of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: _buildCartScreen(),
    );
  }

  _buildCartScreen() {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        print(state.name);
        if(state is LoadedCartState) {
          print(state.cart);
          print("price : " + state.currentCartPrice.toString());
        }
      },
      builder: (context, state) {
        if (state is LoadingCartState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LoadingIndicator(loadingText: "loading cart ...")],
          );
        }
        if (state is LoadedCartState) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 150),
                padding: EdgeInsets.only(bottom: 15),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                          leading: Icon(
                            Icons.shopping_cart,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                          title: Text(
                            'Shopping Cart',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .display1,
                          ),
                          subtitle: Text(
                            'Verify your quantity and click checkout',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme
                                .of(context)
                                .textTheme
                                .caption,
                          ),
                        ),
                      ),
                      ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.cart.numberOfOrders(),
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 15);
                        },
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                              order: state.cart.getOrderByIndex(index),
                              heroTag: 'cart');
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 170,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Theme
                                .of(context)
                                .focusColor
                                .withOpacity(0.15),
                            offset: Offset(0, -2),
                            blurRadius: 5.0)
                      ]),
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Total',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .body2,
                              ),
                            ),
                            Text(state.currentCartPrice.toString() + " DA",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .subhead),
                          ],
                        ),
                        SizedBox(height: 5),
                        // Row(
                        //   children: <Widget>[
                        //     Expanded(
                        //       child: Text(
                        //         'TAX (20%)',
                        //         style: Theme
                        //             .of(context)
                        //             .textTheme
                        //             .body2,
                        //       ),
                        //     ),
                        //     Text('\$13.23',
                        //         style: Theme
                        //             .of(context)
                        //             .textTheme
                        //             .subhead),
                        //   ],
                        // ),
                        SizedBox(height: 10),
                        Stack(
                          fit: StackFit.loose,
                          alignment: AlignmentDirectional.centerEnd,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 40,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/Checkout');
                                },
                                padding: EdgeInsets.symmetric(vertical: 14),
                                color: Theme
                                    .of(context)
                                    .accentColor,
                                shape: StadiumBorder(),
                                child: Text(
                                  'Checkout',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Theme
                                          .of(context)
                                          .primaryColor),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Text(
                                state.currentCartPrice.toString() +" DA",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .display1
                                    .merge(
                                    TextStyle(
                                        color: Theme
                                            .of(context)
                                            .primaryColor)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return
          Container
            (
          );
      },
    );
  }
}
