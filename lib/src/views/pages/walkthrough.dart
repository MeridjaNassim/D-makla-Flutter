import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:restaurant_rlutter_ui/config/app_config.dart' as config;
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/views/utils/image_handling.dart';

class Walkthrough extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: new WalkthroughWidget(),
    );
  }

  AppBar buildAppBar(context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        MaterialButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/Login');
            },
            child: Row(
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.account_circle,
                  color: Theme.of(context).accentColor,
                ),
              ],
            )),
      ],
    );
  }
}

class WalkthroughWidget extends StatelessWidget {
  RestaurantsList _restaurantsList = new RestaurantsList();
  WalkthroughWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ac = config.App(context);
    return Container(
      height: _ac.appHeight(100),
      child: Swiper(
        itemCount: 3,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(bottom: _ac.appHeight(10)),
          builder: DotSwiperPaginationBuilder(
            activeColor: Theme.of(context).accentColor,
            color: Theme.of(context).accentColor.withOpacity(0.2),
          ),
        ),
        itemBuilder: (context, index) {
          return new WalkthroughItemWidget(_restaurantsList.popularRestaurantsList.elementAt(index));
        },
      ),
    );
  }
}

class WalkthroughItemWidget extends StatelessWidget {
  Restaurant restaurant;

  WalkthroughItemWidget(this.restaurant, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ac = config.App(context);
    return Stack(
      children: <Widget>[
        Positioned(
          top: 140,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(3)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                  )
                ]),
            margin: EdgeInsets.symmetric(
              horizontal: _ac.appHorizontalPadding(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: _ac.appWidth(80),
            height: _ac.appHeight(55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 150),
                Text(
                  "designation restaurant",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.place,
                      color: Theme.of(context).focusColor.withOpacity(1),
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Address restaurant",
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  "description restaurant",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: Theme.of(context).textTheme.body2,
                )
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: restaurant.image == null? null : getImageProvider(restaurant.image),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 50,
                  color: Theme.of(context).hintColor.withOpacity(0.2),
                )
              ]),
          margin: EdgeInsets.symmetric(
            horizontal: _ac.appHorizontalPadding(16),
            vertical: _ac.appVerticalPadding(10),
          ),
          width: _ac.appWidth(100),
          height: 220,
        ),
      ],
    );
  }
}
