import 'package:flutter/material.dart';

import 'package:dmakla_flutter/src/models/restaurant.dart';

import 'GridItemWidget.dart';

class GridWidget extends StatelessWidget {
  RestaurantsList _restaurantsList = new RestaurantsList();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(vertical: 10),
      crossAxisCount:
          MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
      children: List.generate(_restaurantsList.popularRestaurantsList.length,
          (index) {
        return GridItemWidget(
            restaurant:
                _restaurantsList.popularRestaurantsList.elementAt(index));
      }),
    );
  }
}
