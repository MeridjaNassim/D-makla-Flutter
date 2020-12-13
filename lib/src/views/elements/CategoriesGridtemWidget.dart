import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';
import 'package:restaurant_rlutter_ui/src/views/utils/image_handling.dart';

// ignore: must_be_immutable
class CategoriesGridItemWidget extends StatelessWidget {
  Category category;
  CategoriesGridItemWidget({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Hero(
          tag: category.id,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: getImageProvider(category.image),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: Text(
            category.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.body2,
          ),
        ),
      ],
    );
  }
}
