import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/CategoriesCarouselItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/models/category.dart';

class CategoriesCarouselWidget extends StatelessWidget {
  CategoriesList _categoriesList = new CategoriesList();

  CategoriesCarouselWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: _categoriesList.categoriesList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            double _marginLeft = 0;
            (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
            return new CategoriesCarouselItemWidget(
              marginLeft: _marginLeft,
              category: _categoriesList.categoriesList.elementAt(index),
            );
          },
        ));
  }
}
