import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';

class RestaurantCubit extends Cubit<RestaurantState> {


  RestaurantCubit() : super(RestaurantInitial());


  /// loads all categories from the api
  void loadRestaurants() {
    emit(RestaurantLoading());


    ///TODO do the loading of the categories
    emit(RestaurantLoaded([]));
  }
  /// sets the current categories
  void setRestaurants(List<Restaurant> restaurants) {
    emit(RestaurantLoading());
    print("setting  restaurant cubit data");
    emit(RestaurantLoaded(restaurants));
  }
  void unsetRestaurants() {
    emit(RestaurantLoading());
    emit(RestaurantLoaded([]));
  }
}


abstract class RestaurantState extends Equatable{
  final String name;
  RestaurantState(this.name);
}

class RestaurantInitial extends RestaurantState{
  RestaurantInitial() : super("initial");
  @override
  // TODO: implement props
  List<Object> get props => [super.name];


}
class RestaurantLoading extends RestaurantState{
  RestaurantLoading() : super("loading");
  @override
  // TODO: implement props
  List<Object> get props => [super.name];

}
class RestaurantLoaded extends RestaurantState{

  final List<Restaurant> restaurants;

  RestaurantLoaded(this.restaurants) : super("loaded");

  @override
  // TODO: implement props
  List<Object> get props => [restaurants,super.name];

}