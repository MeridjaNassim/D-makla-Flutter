import 'package:flutter/material.dart';

class GalleryItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 250,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        image: DecorationImage(
          image: AssetImage('img/food2.jpg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(color: Theme.of(context).accentColor.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 5)),
        ],
      ),
    );
  }
}
