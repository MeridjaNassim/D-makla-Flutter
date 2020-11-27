import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';

abstract class RestaurantState extends Equatable {

}

class InitialRestaurantState extends RestaurantState {

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class RestaurantSelectedState extends RestaurantState {

  final Restaurant restaurant;

  RestaurantSelectedState(this.restaurant);

  @override
  // TODO: implement props
  List<Object> get props => [restaurant];
}
class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit() : super(InitialRestaurantState());

  void setCurrentRestaurant(Restaurant restaurant) {
    emit(RestaurantSelectedState(restaurant));
  }


}