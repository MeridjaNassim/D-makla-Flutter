import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';

class GridItemWidget extends StatelessWidget {
  Restaurant restaurant;

  GridItemWidget({Key key, this.restaurant}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Details', arguments: restaurant.id);
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 5)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Image.asset(
                restaurant.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              restaurant.name,
              style: Theme.of(context).textTheme.body1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            SizedBox(height: 2),
            Row(
              children: List.generate(5, (index) {
                return index < restaurant.rate
                    ? Icon(Icons.star, size: 18, color: Color(0xFFFFB24D))
                    : Icon(Icons.star_border, size: 18, color: Color(0xFFFFB24D));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
