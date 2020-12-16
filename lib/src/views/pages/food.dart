import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/order.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/ExtraItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/ShoppingCartFloatButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/utils/image_handling.dart';

// ignore: must_be_immutable
class FoodWidget extends StatefulWidget {
  RouteArgument routeArgument;

  FoodWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _FoodWidgetState createState() {
    return _FoodWidgetState();
  }
}

class _FoodWidgetState extends State<FoodWidget> {
  String _orderNote;
  TextEditingController _noteController;
  @override
  void initState() {
    super.initState();
    _orderNote = "";
    _noteController = TextEditingController();
  }


  @override
  void dispose() {
    super.dispose();
    if(_noteController != null)
      _noteController.dispose();
  }

  Widget _buildVariantsList(OrderSelectedState state) {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        final variant = state.menu.variants.getVariantByIndex(index);
        return ListTile(
          title: Text(variant.name),
          trailing: Text(
            state.menu.pricings.getPriceOfVariant(variant).toStringAsFixed(2) + "DA",
            style: Theme.of(context).textTheme.display2,
          ),
          leading: Radio<Variant>(
            value: variant,
            groupValue: state.selectedVariant,
            onChanged: (Variant value) {
              BlocProvider.of<OrderCubit>(context).setSelectedVariant(value);
            },
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 0);
      },
      itemCount: state.menu.variants.size(),
      primary: false,
      shrinkWrap: true,
    );
  }
  Widget _buildCurrentOrdersOfThisMenu(Menu menu) {
    return BlocBuilder<CartBloc,CartState>(
        builder:(context,state){
          if(state is LoadedCartState) {
            final cart = state.cart;
            final orders = cart.getOrdersByMenu(menu);
            final size = cart.sizeOfOrderByMenu(menu);
            final ordersCount = orders.length ;
            if(ordersCount > 0){
              return Column(
                children: [
                  InkWell(
                    onTap: (){

                    },
                    child: ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      leading: Icon(
                        Icons.fastfood,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Commandes courantes ( '+size.toString()+" )",
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      subtitle: Text(
                        'swipe pour supprimer',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                  ListView.separated(
                    padding: EdgeInsets.all(0),
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Dismissible(
                          onDismissed: (direction){
                            BlocProvider.of<CartBloc>(context).add(OrderRemoved(order));
                          },
                          key: Key(order.id),
                          child: OrderWidget(order));
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                    itemCount: ordersCount,
                    primary: false,
                    shrinkWrap: true,
                  )
                ],
              );
            }
            return Container();
          }
      return Container();
    });
  }
  Widget _buildGarnituresList(OrderSelectedState state) {
    final toppings = state.menu.toppings;
    final size = toppings.size();
    if (size > 0) {
      return Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            leading: Icon(
              Icons.add_circle,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Garnitures',
              style: Theme.of(context).textTheme.subhead,
            ),
            subtitle: Text(
              'Séléctionnez les garnitures à cette commande',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          ListView.separated(
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) {
              final topping = toppings.getToppingByIndex(index);
              final isSelected = state.selectedToppings.contains(topping);
              print("is selected " +
                  topping.toString() +
                  ": " +
                  isSelected.toString());
              return ExtraItemWidget(
                topping: topping,
                isSelected: isSelected,
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 20);
            },
            itemCount: size,
            primary: false,
            shrinkWrap: true,
          )
        ],
      );
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BlocBuilder<OrderCubit, OrderState>(builder: (context, menuState) {
            if (menuState is OrderSelectedState) {
              return Container(
                margin: EdgeInsets.only(bottom: 120),
                padding: EdgeInsets.only(bottom: 15),
                child: CustomScrollView(
                  primary: true,
                  shrinkWrap: false,
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor:
                          Theme.of(context).primaryColor,
                      expandedHeight: 300,
                      elevation: 0,
                      iconTheme:
                          IconThemeData(color: Theme.of(context).primaryColor),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Hero(
                            tag: widget.routeArgument.heroTag +
                                menuState.menu.id,
                            child: Image(
                              image: getImageProvider(menuState.menu.image),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Wrap(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    menuState.menu.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.display2,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        menuState.menu.pricings
                                                .getPriceOfVariant(menuState
                                                    .menu.variants
                                                    .getVariantByIndex(0))
                                                .toStringAsFixed(0) +
                                            "DA",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display3,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(menuState.menu.description ?? "no description"),
                            SizedBox(height: 20,),
                            _buildCurrentOrdersOfThisMenu(menuState.menu),
                            Container(height: 20,),
                            Text("Créer une nouvelle commande",style: Theme.of(context).textTheme.display3,),
                            ListTile(
                              dense: true,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                              leading: Icon(
                                Icons.category,
                                color: Theme.of(context).hintColor,
                              ),
                              title: Text(
                                'Variante',
                                style: Theme.of(context).textTheme.subhead,
                              ),
                              subtitle: Text(
                                'Séléctionnez la variante de cette commande',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            _buildVariantsList(menuState),
                            _buildGarnituresList(menuState),
                            ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 10),
                              leading: Icon(
                                Icons.message,
                                color: Theme.of(context).hintColor,
                              ),
                              title: Text(
                                'Note de commande',
                                style: Theme.of(context).textTheme.subhead,
                              ),
                              subtitle: Text(
                                'ajouter une note pour la commande',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ),
                            TextField(

                              onChanged: (value) {
                                this.setState(() {
                                  _orderNote = value;
                                });
                              },
                              autofocus: false,
                              keyboardType: TextInputType.text,
                              controller: _noteController,
                              decoration: InputDecoration(
                                labelText: "Note",
                                errorText: null,
                                labelStyle:
                                TextStyle(color: Theme.of(context).accentColor),
                                contentPadding: EdgeInsets.all(12),
                                hintText: 'Votre note',
                                hintStyle: TextStyle(
                                    color: Theme.of(context).focusColor.withOpacity(0.7)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
                              ),
                            ),
                            SizedBox(height: 20,)

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
          Positioned(
            top: 32,
            right: 20,
            child: ShoppingCartFloatButtonWidget(
              iconColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).hintColor,
            ),
          ),

          BlocBuilder<OrderCubit, OrderState>(builder: (context, state) {
            if (state is OrderSelectedState) {
              return Positioned(
                bottom: 0,
                child: Container(
                  height: 140,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Quantity',
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {
                                    BlocProvider.of<OrderCubit>(context)
                                        .decrementQuantity();
                                  },
                                  iconSize: 30,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  icon: Icon(Icons.remove_circle_outline),
                                  color: Theme.of(context).hintColor,
                                ),
                                Text(state.quantity.toString(),
                                    style: Theme.of(context).textTheme.subhead),
                                IconButton(
                                  onPressed: () {
                                    BlocProvider.of<OrderCubit>(context)
                                        .incrementQuantity();
                                  },
                                  iconSize: 30,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  icon: Icon(Icons.add_circle_outline),
                                  color: Theme.of(context).hintColor,
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Stack(
                          fit: StackFit.loose,
                          alignment: AlignmentDirectional.centerEnd,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: FlatButton(
                                onPressed: () {

                                  BlocProvider.of<OrderCubit>(context)
                                      .addCurrentMenuToCart(note: _orderNote);
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      padding: const EdgeInsets.all(16),
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      content: Text(
                                        "Order added to cart",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Theme.of(context).primaryColor),
                                      )));
                                  _noteController.clear();
                                  setState(() {
                                    _orderNote = "";
                                  });
                                },
                                padding: EdgeInsets.symmetric(vertical: 14),
                                color: Theme.of(context).accentColor,
                                shape: StadiumBorder(),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    'Add new order',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                state.currentOrderPrice.toString() + "DA",
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .merge(TextStyle(
                                        color: Theme.of(context).primaryColor)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          })
        ],
      ),
    );
  }
}
class OrderWidget extends StatelessWidget {
  final Order order;

  OrderWidget(this.order);

  void _incrementOrder(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(
        OrderQuantityInceremented(order, 1));
  }

  void _decrement(BuildContext context) {
    BlocProvider.of<CartBloc>(context).add(
        OrderQuantityDeceremented(order, 1));
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
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        order.variant.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme
                            .of(context)
                            .textTheme
                            .display3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0),
                            separatorBuilder: (context,index)=>SizedBox(height: 2,),
                            itemCount: order.toppingList.size(),
                            itemBuilder: (item, index) {
                              return Row(
                                children: [
                                  Icon(Icons.add_circle,size: 16, color: Theme
                                      .of(context)
                                      .accentColor,),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Text(order.toppingList
                                        .getToppingByIndex(index)
                                        .name,

                                      style: Theme
                                        .of(context)
                                        .textTheme
                                        .body1,
                                    overflow: TextOverflow.fade,
                                    ),
                                  )
                                ],
                              );
                            }),
                      ),
                      Row(
                        children: [
                          Row(children: [
                            Icon(Icons.payments_outlined,color: Theme.of(context).accentColor,),
                            SizedBox(width: 5,),
                            Text(
                              order.getUnitPrice().toString() + " DA",
                              style: Theme.of(context).textTheme.subhead.copyWith(color : Theme.of(context).accentColor),
                            ),
                          ],),
                          SizedBox(width: 20,),
                          Row(children: [
                            Text("total: ",style: Theme.of(context).textTheme.body2,),
                            Text(
                              order.getFullPrice().toString() + " DA",
                              style: Theme.of(context).textTheme.display2.copyWith(color : Theme.of(context).accentColor),
                            ),
                          ],),
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
                      onPressed:()=> _incrementOrder(context),
                      iconSize: 30,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      icon: Icon(Icons.add_circle_outline),
                      color: Theme
                          .of(context)
                          .hintColor,
                    ),
                    Text(order.quantity.toString(), style: Theme
                        .of(context)
                        .textTheme
                        .subhead),
                    IconButton(
                      onPressed:()=> _decrement(context),
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
