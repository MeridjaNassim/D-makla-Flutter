import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:restaurant_rlutter_ui/src/elements/GalleryCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/OrderItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ReviewsListWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ShoppingCartFloatButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/order.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';

class DetailsWidget extends StatefulWidget {
  String id;

  DetailsWidget({Key key, this.id}) : super(key: key);

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends State<DetailsWidget> {
  OrdersList _ordersList = new OrdersList();
  RestaurantsList _restaurantsList;
  Restaurant _restaurant;

  @override
  void initState() {
    _restaurantsList = new RestaurantsList();
    _restaurant = getRestaurant();
    super.initState();
  }

  Restaurant getRestaurant() {
    return _restaurantsList.restaurantsList.firstWhere((res) {
      return widget.id == res.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/Menu');
        },
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        icon: Icon(Icons.restaurant),
        label: Text('Menu'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomScrollView(
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
                    tag: _restaurant.id,
                    child: Image.asset(
                      _restaurant.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Wrap(
//              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _restaurant.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.display2,
                            ),
                          ),
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(_restaurant.rate.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .body2
                                          .merge(TextStyle(color: Theme.of(context).primaryColor))),
                                  Icon(
                                    Icons.star_border,
                                    color: Theme.of(context).primaryColor,
                                    size: 18,
                                  ),
                                ],
                              ),
                              color: Theme.of(context).accentColor.withOpacity(0.9),
                              shape: StadiumBorder(),
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 45,
                            height: 45,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/Chat');
                              },
                              child: Icon(
                                Icons.chat,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              color: Theme.of(context).accentColor.withOpacity(0.9),
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(_restaurant.description),
                    ),
                    ImageThumbCarouselWidget(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.stars,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Information',
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        _restaurant.information,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              _restaurant.address,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 42,
                            height: 42,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
                              child: Icon(
                                Icons.directions,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              color: Theme.of(context).accentColor.withOpacity(0.9),
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${_restaurant.phone} \n${_restaurant.mobile}',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 42,
                            height: 42,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
                              child: Icon(
                                Icons.call,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              color: Theme.of(context).accentColor.withOpacity(0.9),
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.recent_actors,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'What They Say ?',
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ReviewsListWidget(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.restaurant,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Featured Foods',
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                    ),
                    ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _ordersList.recentOrderedList.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        return OrderItemWidget(
                          heroTag: 'details_featured_food',
                          order: _ordersList.recentOrderedList.elementAt(index),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 32,
            right: 20,
            child: ShoppingCartFloatButtonWidget(
              iconColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).hintColor,
              labelCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
