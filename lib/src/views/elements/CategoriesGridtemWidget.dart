import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';

// ignore: must_be_immutable
class CategoriesGridItemWidget extends StatelessWidget {
  double marginLeft;
  Category category;
  CategoriesGridItemWidget({Key key, this.marginLeft, this.category}) : super(key: key);
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
        children: <Widget>[
          Hero(
            tag: category.id,
            child: Container(
              margin: EdgeInsets.only(left: this.marginLeft, right: 20),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: getCategoryImage(),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.only(left: this.marginLeft, right: 20),
            child: Text(
              category.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.body1,
            ),
          ),
        ],
      ),
    );
  }
}
