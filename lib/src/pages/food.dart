import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/ExtraItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ReviewsListWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ShoppingCartFloatButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/extra.dart';
import 'package:restaurant_rlutter_ui/src/models/food.dart';
import 'package:restaurant_rlutter_ui/src/models/nutrition.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';

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
  int cartCount = 0;
  int quantity = 1;
//  double price = 13.95;
  double totalPrice = 0.00;
  FoodsList _foodsList;
  ExtrasList _extrasList;
  NutritionList _nutritionList;
  Food _food;

  @override
  void initState() {
    _foodsList = new FoodsList();
    _extrasList = new ExtrasList();
    _nutritionList = new NutritionList();
    _food = getFood();
    totalPrice = _food.price;
    super.initState();
  }

  Food getFood() {
    return _foodsList.foodsList.firstWhere((f) {
      return f.id == widget.routeArgument.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
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
                      tag: widget.routeArgument.heroTag + _food.id,
                      child: Image.asset(
                        _food.image, // <===   Add your own image to assets or use a .network image instead.
                        fit: BoxFit.cover,
                      ),
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
                                _food.name,
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
                                    _food.getPrice(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.display3,
                                  ),
                                  Text(
                                    _food.weight,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.body1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(_food.description),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Icon(
                            Icons.add_circle,
                            color: Theme.of(context).hintColor,
                          ),
                          title: Text(
                            'Extras',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                          subtitle: Text(
                            'Select extras to add them on the food',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        ListView.separated(
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            return ExtraItemWidget(extra: _extrasList.extrasList.elementAt(index));
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                          itemCount: _extrasList.extrasList.length,
                          primary: false,
                          shrinkWrap: true,
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Icon(
                            Icons.donut_small,
                            color: Theme.of(context).hintColor,
                          ),
                          title: Text(
                            'Ingredients',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        Text(_food.ingredients),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Icon(
                            Icons.local_activity,
                            color: Theme.of(context).hintColor,
                          ),
                          title: Text(
                            'Nutrition',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(_nutritionList.nutritionList.length, (index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).focusColor.withOpacity(0.2),
                                        offset: Offset(0, 2),
                                        blurRadius: 6.0)
                                  ]),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(_nutritionList.nutritionList.elementAt(index).name,
                                      overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.caption),
                                  Text(_nutritionList.nutritionList.elementAt(index).quantity.toString(),
                                      overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline),
                                ],
                              ),
                            );
                          }),
                        ),
                        ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Icon(
                            Icons.recent_actors,
                            color: Theme.of(context).hintColor,
                          ),
                          title: Text(
                            'Reviews',
                            style: Theme.of(context).textTheme.subhead,
                          ),
                        ),
                        ReviewsListWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 32,
            right: 20,
            child: ShoppingCartFloatButtonWidget(
              iconColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).hintColor,
              labelCount: this.cartCount,
            ),
          ),
          Positioned(
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
                                setState(() {
                                  this.quantity = this.decrementQuantity(this.quantity);
                                });
                              },
                              iconSize: 30,
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                              icon: Icon(Icons.remove_circle_outline),
                              color: Theme.of(context).hintColor,
                            ),
                            Text(quantity.toString(), style: Theme.of(context).textTheme.subhead),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  this.quantity = this.incrementQuantity(this.quantity);
                                });
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                              onPressed: () {
                                setState(() {
                                  this.cartCount += this.quantity;
                                });
                              },
                              padding: EdgeInsets.symmetric(vertical: 14),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                              child: Icon(
                                Icons.favorite,
                                color: Theme.of(context).primaryColor,
                              )),
                        ),
                        SizedBox(width: 10),
                        Stack(
                          fit: StackFit.loose,
                          alignment: AlignmentDirectional.centerEnd,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 110,
                              child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    this.cartCount += this.quantity;
                                  });
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
                                _food.getPrice(myPrice: this.totalPrice),
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .merge(TextStyle(color: Theme.of(context).primaryColor)),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
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
