import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/menu.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';
import 'package:restaurant_rlutter_ui/src/models/extra.dart';
import 'package:restaurant_rlutter_ui/src/models/food.dart';
import 'package:restaurant_rlutter_ui/src/models/nutrition.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/ExtraItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/ReviewsListWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/ShoppingCartFloatButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/VariantItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/common/loading.dart';

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
  int quantity = 1;
//  double price = 13.95;
  double totalPrice = 0.00;
  FoodsList _foodsList;
  ExtrasList _extrasList;
  Food _food;

  @override
  void initState() {
    _foodsList = new FoodsList();
    _extrasList = new ExtrasList();
    super.initState();
  }

  // Food getFood() {
  //   return _foodsList.foodsList.firstWhere((f) {
  //     return f.id == widget.routeArgument.id;
  //   });
  // }

  Widget _buildVariantsList(MenuSelectedState state){
    return ListView.separated(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        final variant = state.menu.variants.getVariantByIndex(index);
        return  ListTile(
          title: Text(variant.name),
          trailing: Text(state.menu.pricings.getPriceOfVariant(variant).toString()+ "DA",style: Theme.of(context).textTheme.display2,),
          leading: Radio<Variant>(
            value: variant,
            groupValue: state.selectedVariant,
            onChanged: (Variant value) {
             BlocProvider.of<MenuCubit>(context).setSelectedVariant(value);
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
  Widget _buildGarnituresList(MenuSelectedState state) {
    return ListView.separated(
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return ExtraItemWidget(topping: state.menu.toppings.getToppingByIndex(index));
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 20);
      },
      itemCount: state.menu.toppings.size(),
      primary: false,
      shrinkWrap: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            BlocBuilder<MenuCubit,MenuState>(
              builder:(context,menuState){
                if(menuState is MenuSelectedState) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 120),
                    padding: EdgeInsets.only(bottom: 15),
                    child: CustomScrollView(
                      primary: true,
                      shrinkWrap: false,
                      slivers: <Widget>[
                        SliverAppBar(
                          backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                          expandedHeight: 300,
                          elevation: 0,
                          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: Hero(
                              tag: widget.routeArgument.heroTag + menuState.menu.id,
                              child: Image(image: menuState.menu.image.getImageProvider(), fit: BoxFit.cover,)
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                                            menuState.menu.pricings.getPriceOfVariant(menuState.menu.variants.getVariantByIndex(0)).toString() +"DA",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: Theme.of(context).textTheme.display3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Text("description"),
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                                  leading: Icon(
                                    Icons.menu,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  title: Text(
                                    'Variant',
                                    style: Theme.of(context).textTheme.subhead,
                                  ),
                                  subtitle: Text(
                                    'Select variant of this menu',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                                _buildVariantsList(menuState),
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
                                    'Select garnitures to add them on the food',
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ),
                                _buildGarnituresList(menuState),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              }
            ),
            Positioned(
              top: 32,
              right: 20,
              child: BlocBuilder<CartBloc,CartState>(
                builder:(context,cartState)=> ShoppingCartFloatButtonWidget(
                  iconColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).hintColor,
                  labelCount: (cartState is LoadedCartState) ? cartState.cart.totalNumberOfOrders() : 0,
                ),
              ),
            ),
            BlocBuilder<MenuCubit,MenuState>(
              builder:(context,state){
                if(state is CreatingNewOrderFromMenuState) {
                  return Positioned(
                      bottom: 0,
                      child: LoadingIndicator(loadingText: "creating new order",));
                }
                if(state is CreatedNewOrderFromMenuState) {
                  return Positioned(
                      bottom: 0,
                      child: Text("Created new order in cart"));
                }
                if(state is MenuSelectedState) {
                  return Positioned(
                    bottom: 0,
                    child: Container(
                      height: 140,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context).focusColor.withOpacity(0.15), offset: Offset(0, -2), blurRadius: 5.0)
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
                                        BlocProvider.of<MenuCubit>(context).decrementQuantity();
                                      },
                                      iconSize: 30,
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                      icon: Icon(Icons.remove_circle_outline),
                                      color: Theme.of(context).hintColor,
                                    ),
                                    Text(state.quantity.toString(), style: Theme.of(context).textTheme.subhead),
                                    IconButton(
                                      onPressed: () {
                                        BlocProvider.of<MenuCubit>(context).incrementQuantity();
                                      },
                                      iconSize: 30,
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
                                  width: MediaQuery.of(context).size.width ,
                                  child: FlatButton(
                                    onPressed: () {
                                      BlocProvider.of<MenuCubit>(context).addCurrentMenuToCart();
                                    },
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    color: Theme.of(context).accentColor,
                                    shape: StadiumBorder(),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        'Add to Cart',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(color: Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    state.currentOrderPrice.toString()+"DA",
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .merge(TextStyle(color: Theme.of(context).primaryColor)),
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
              }
            )
          ],
        ),
      );
  }

  incrementQuantity(int quantity) {
    if (quantity <= 99) {
      this.totalPrice = _food.price * ++quantity;
      return quantity;
    } else {
      return quantity;
    }
  }

  decrementQuantity(int quantity) {
    if (quantity > 1) {
      this.totalPrice = _food.price * --quantity;
      return quantity;
    } else {
      return quantity;
    }
  }

  String getPrice(double price) {
    return '\$' + price.toString();
  }
}
