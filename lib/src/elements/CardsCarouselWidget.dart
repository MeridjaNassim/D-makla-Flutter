import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';

import 'CardWidget.dart';

class CardsCarouselWidget extends StatefulWidget {
  @override
  _CardsCarouselWidgetState createState() => _CardsCarouselWidgetState();
}

class _CardsCarouselWidgetState extends State<CardsCarouselWidget> {
  RestaurantsList _restaurantsList;
  @override
  void initState() {
    _restaurantsList = new RestaurantsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 288,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _restaurantsList.restaurantsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/Details', arguments: _restaurantsList.restaurantsList.elementAt(index).id);
            },
            child: CardWidget(restaurant: _restaurantsList.restaurantsList.elementAt(index)),
          );
        },
      ),
    );
  }
}
