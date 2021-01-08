import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dmakla/src/business_logic/models/category.dart';
import 'package:dmakla/src/business_logic/models/restaurant.dart';
import 'package:dmakla/src/business_logic/repositories/category_repository.dart';

abstract class RestaurantState extends Equatable {
  final Restaurant restaurant;

  RestaurantState(this.restaurant);
}

class InitialRestaurantState extends RestaurantState {

  @override
  // TODO: implement props
  List<Object> get props => null;

  InitialRestaurantState(Restaurant restaurant) : super(restaurant);
}

class RestaurantLoadingState extends RestaurantState {
  final String message;

  RestaurantLoadingState(Restaurant restaurant , this.message) : super(restaurant);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
class RestaurantSelectedState extends RestaurantState {

  final List<Category> categories;
  RestaurantSelectedState(Restaurant restaurant,this.categories): super(restaurant);

  @override
  // TODO: implement props
  List<Object> get props => [restaurant];
}
class RestaurantCubit extends Cubit<RestaurantState> {
  final CategoryRepository _categoryRepository;
  RestaurantCubit(CategoryRepository categoryRepository) :
        assert(categoryRepository != null),
        this._categoryRepository = categoryRepository, super(InitialRestaurantState(null));

  void setCurrentRestaurant(Restaurant restaurant) async{
    emit(RestaurantLoadingState(restaurant,"loading categories"));
    final categories = await _categoryRepository.getCategoriesByRestaurant(restaurant);
    emit(RestaurantSelectedState(restaurant,categories));
  }


}