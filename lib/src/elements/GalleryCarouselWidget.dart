import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/GalleryItemWidget.dart';

class ImageThumbCarouselWidget extends StatelessWidget {
  const ImageThumbCarouselWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: [1, 2, 3, 4, 5, 6, 7, 8, 9].map((i) {
            double _marginLeft = 0;
            (i == 1) ? _marginLeft = 20 : _marginLeft = 0;
            return InkWell(
              splashColor: Theme.of(context).accentColor.withOpacity(0.8),
              highlightColor: Colors.transparent,
              onTap: () {},
              child: GalleryItemWidget(),
            );
          }).toList()),
    );
  }
}
