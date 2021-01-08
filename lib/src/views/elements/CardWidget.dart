import 'package:dmakla/src/views/elements/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/src/business_logic/blocs/store/menu.cubit.dart';
import 'package:dmakla/src/business_logic/models/restaurant.dart';
import 'package:dmakla/src/views/elements/common/loading.dart';
import 'package:dmakla/src/views/utils/image_handling.dart';
import 'package:octo_image/octo_image.dart';
class CardWidget extends StatelessWidget {
  Restaurant restaurant;

  CardWidget({Key key, this.restaurant}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 292,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Image of the card
          Hero(
            tag: "restaurant" + restaurant.id,
            child: Container(
              width: 292,
              height: 150,
              child: OctoImage(
                placeholderBuilder: (context)=> LoadingImage(size : 70),
                errorBuilder: (context,obj,trace)=> Image(image: FAILED_TO_LOAD_FOOD_IMAGE),
                fit: BoxFit.cover,
                image: getImageProvider(restaurant.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subhead,
                      ),
                      Text(
                        restaurant?.description ?? "no description",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: List.generate(5, (index) {
                          Rating rating = restaurant?.rating;
                          if(rating == null) rating = Rating(score: 0);
                          return index < (rating.score.floor())
                              ? Icon(Icons.star, size: 18, color: Color(0xFFFFB24D))
                              : Icon(Icons.star_border, size: 18, color: Color(0xFFFFB24D));
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      BlocProvider.of<MenuCubit>(context)
                          .setMenusByRestaurant(restaurant);
                      Navigator.of(context).pushNamed('/Menu', arguments: restaurant.id);
                    },
                    child: Icon(Icons.restaurant, color: Theme.of(context).primaryColor),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
