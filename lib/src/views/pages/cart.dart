import 'package:dmakla/src/views/utils/connectivity_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.event.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.state.dart';
import 'package:dmakla/src/business_logic/blocs/delivery/delivery.cubit.dart';
import 'package:dmakla/src/views/elements/CartItemWidget.dart';
import 'package:dmakla/src/views/elements/common/loading.dart';
import 'package:dmakla/src/core/connectivity.dart';

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
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Theme.of(context).accentColor,
            ),
            tooltip: "vider panier",
            splashRadius: 10,
            onPressed: () {
              BlocProvider.of<CartBloc>(context).add(CartCleared());
            },
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Panier',
          style: Theme.of(context)
              .textTheme
              .title
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: _buildCartScreen(),
    );
  }

  Widget _buildCartItems(BuildContext context, LoadedCartState state) {
    final hasItems = state.cart.totalNumberOfOrders() > 0;
    if (!hasItems)
      return Center(
        child: Text(
          'Pas d\'élements dans le panier',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.body2,
        ),
      );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            'glisser pour supprimer des éléments',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
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
            final order = state.cart.getOrderByIndex(index);
            return Dismissible(
                background: Container(
                  color: Theme.of(context).accentColor,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: Icon(
                          Icons.delete,
                          size: 24,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ),
                secondaryBackground: Container(
                  color: Theme.of(context).accentColor,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: const EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.delete,
                          size: 24,
                          color: Theme.of(context).primaryColor,
                        )),
                  ),
                ),
                onDismissed: (direction) {
                  BlocProvider.of<CartBloc>(context).add(OrderRemoved(order));
                  Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Theme.of(context).accentColor,
                      content: Text(
                          "Order ${order.menu.name + " " + order.variant.name} supprimé",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor))));
                  // Remove the item from the data source.
                },
                key: Key("${order.id}"),
                child: CartItemWidget(order: order, heroTag: 'cart'));
          },
        ),
      ],
    );
  }

  Widget _buildCartScreen() {
    return BlocConsumer<CartBloc, CartState>(
      listener: (context, state) {
        //print(state.name);
        if (state is LoadedCartState) {
          //print(state.cart);
          //print("price : " + state.currentCartPrice.toString());
        }
      },
      builder: (context, state) {
        if (state is LoadingCartState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [LoadingIndicator(loadingText: "chargement panier ...")],
          );
        }
        if (state is LoadedCartState) {
          final numberOfOrders = state.cart.totalNumberOfOrders();
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
                            color: Theme.of(context).hintColor,
                          ),
                          title: Text(
                            'Panier',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.display1,
                          ),
                          subtitle: Text(
                            'Vérifiez vos commandes et confirmez',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                      ),
                      _buildCartItems(context, state)
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
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.15),
                            offset: Offset(0, -2),
                            blurRadius: 5.0)
                      ]),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        // Row(
                        //   children: <Widget>[
                        //     Expanded(
                        //       child: Text(
                        //         'Tax',
                        //         style: Theme.of(context).textTheme.body2,
                        //       ),
                        //     ),
                        //     Text(state.currentCartPrice.toString() + " DA",
                        //         style: Theme.of(context).textTheme.subhead),
                        //   ],
                        // ),
                        // Row(
                        //   children: <Widget>[
                        //     Expanded(
                        //       child: Text(
                        //         'Réduction',
                        //         style: Theme.of(context).textTheme.body2,
                        //       ),
                        //     ),
                        //     Text(state.currentCartPrice.toString() + " DA",
                        //         style: Theme.of(context).textTheme.subhead),
                        //   ],
                        // ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Total',
                                style: Theme.of(context).textTheme.display1,
                              ),
                            ),
                            Text(
                                state.currentCartPrice.toInt().toString() +
                                    " DA",
                                style: Theme.of(context).textTheme.display3),
                          ],
                        ),
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
                        SizedBox(height: 20),
                        Stack(
                          fit: StackFit.loose,
                          alignment: AlignmentDirectional.centerEnd,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 40,
                              child: FlatButton(
                                disabledColor: Colors.grey,
                                disabledTextColor: Colors.black54,
                                onPressed: numberOfOrders != 0
                                    ? () {
                                        final connectivity =
                                            BlocProvider.of<ConnectivityCubit>(
                                                context);
                                        if (connectivity.state.isConnected) {
                                          BlocProvider.of<DeliveryCubit>(
                                                  context)
                                              .initDelivery();
                                          Navigator.of(context)
                                              .pushNamed('/Checkout');
                                          return;
                                        }
                                        showConnectivityWidget(context, () {});
                                      }
                                    : null,
                                padding: EdgeInsets.symmetric(vertical: 14),
                                color: Theme.of(context).accentColor,
                                shape: StadiumBorder(),
                                child: Text(
                                  numberOfOrders != 0
                                      ? 'Confirmer'
                                      : "Panier Vide",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
