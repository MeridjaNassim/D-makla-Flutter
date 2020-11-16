import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/elements/CardsCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/CaregoriesCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/FoodsCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/GridWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/ReviewsListWidget.dart';
import 'package:restaurant_rlutter_ui/src/elements/SearchBarWidget.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Icon(
              Icons.trending_up,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Trending This Week',
              style: Theme.of(context).textTheme.display1,
            ),
            subtitle: Text(
              'Double click on the food to add it to the cart',
              style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 11)),
            ),
          ),
          FoodsCarouselWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                Icons.stars,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Top Restaurants',
                style: Theme.of(context).textTheme.display1,
              ),
              subtitle: Text(
                'Ordered by Nearby first',
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
          CardsCarouselWidget(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                Icons.category,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Food Categeries',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
          CategoriesCarouselWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                Icons.trending_up,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Most Popular',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridWidget(),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: ListTile(
          //     dense: true,
          //     contentPadding: EdgeInsets.symmetric(vertical: 20),
          //     leading: Icon(
          //       Icons.recent_actors,
          //       color: Theme.of(context).hintColor,
          //     ),
          //     title: Text(
          //       'Recent Reviews',
          //       style: Theme.of(context).textTheme.display1,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: ReviewsListWidget(),
          // ),
        ],
      ),
    );
  }
}
