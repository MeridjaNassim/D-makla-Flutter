import 'package:flutter/material.dart';
import 'package:dmakla_flutter/src/business_logic/models/menu.dart';
import 'package:dmakla_flutter/src/models/food.dart';

import 'FoodsCarouselItemWidget.dart';

class FoodsCarouselWidget extends StatelessWidget {
  FoodsList _foodsList = new FoodsList();
  List<Menu> menus;
  FoodsCarouselWidget({
    this.menus,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 210,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: menus.length,
          itemBuilder: (context, index) {
            double _marginLeft = 0;
            (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
            return FoodsCarouselItemWidget(
              heroTag: 'home_food_carousel',
              marginLeft: _marginLeft,
              menu: menus.elementAt(index),
            );
          },
          scrollDirection: Axis.horizontal,
        ));
  }
}
