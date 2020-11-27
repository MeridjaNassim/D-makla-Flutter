import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';

// ignore: must_be_immutable
class CategoriesGridItemWidget extends StatelessWidget {
  Category category;
  CategoriesGridItemWidget({Key key, this.category}) : super(key: key);
  ImageProvider getCategoryImage(){
    if(category.image ==null) return null;
    return category.image.getImageProvider();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed('/Menu');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: category.id,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: getCategoryImage(),
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
      ),
    );
  }
}
