import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/src/business_logic/blocs/store/restaurant.cubit.dart';
import 'package:dmakla/src/business_logic/blocs/store/store.cubit.dart';
import 'package:dmakla/src/models/route_argument.dart';
import 'common/loading.dart';
import 'package:dmakla/src/models/restaurant.dart';

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
  Widget BuildRestaurantCarousel(StoreState state) {
    if(state is StoreLoadingState) {
      return LoadingIndicator(loadingText: "Loading restaurants");
    }
    if(state is StoreLoadedState) {
      _restaurantsList.restaurantList = state.store.restaurants;
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _restaurantsList.restaurantsList.length,
        itemBuilder: (context, index) {
          final restaurant = _restaurantsList.restaurantsList.elementAt(index);
          return GestureDetector(
            onTap: () {
              BlocProvider.of<RestaurantCubit>(context).setCurrentRestaurant(restaurant);
              Navigator.of(context)
                  .pushNamed('/Details');
            },
            child: CardWidget(restaurant: restaurant),
          );
        },
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 288,
      child: BlocBuilder<StoreCubit,StoreState>(
        builder: (context,state)=> BuildRestaurantCarousel(state),
      )
    );
  }
}
