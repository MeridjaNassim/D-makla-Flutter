import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'common/loading.dart';
import 'package:restaurant_rlutter_ui/src/features/Menu/restaurants/bloc/restaurant_cubit.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';

import 'CardWidget.dart';

class CardsCarouselWidget extends StatefulWidget {
  @override
  _CardsCarouselWidgetState createState() => _CardsCarouselWidgetState();
}

class _CardsCarouselWidgetState extends State<CardsCarouselWidget> {
  RestaurantsList _restaurantsList;
  @override
  void initState() {
    _restaurantsList = new RestaurantsList();
    super.initState();
  }
  Widget BuildRestaurantCarousel(RestaurantState state) {
    if(state is RestaurantLoading) {
      return LoadingIndicator(loadingText: "Loading restaurants");
    }
    if(state is RestaurantLoaded) {
      _restaurantsList.restaurantList = state.restaurants;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _restaurantsList.restaurantsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/Details', arguments: _restaurantsList.restaurantsList.elementAt(index).id);
            },
            child: CardWidget(restaurant: _restaurantsList.restaurantsList.elementAt(index)),
          );
        },
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 288,
      child: BlocBuilder<RestaurantCubit,RestaurantState>(
        builder: (context,state)=> BuildRestaurantCarousel(state),
      )
    );
  }
}
