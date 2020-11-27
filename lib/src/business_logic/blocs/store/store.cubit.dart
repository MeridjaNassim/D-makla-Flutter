import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/store.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/category_repository.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/menu_repository.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/restaurant_repository.dart';

abstract class StoreState extends Equatable {

}


class StoreInitialState extends StoreState {
  @override
  // TODO: implement props
  List<Object> get props => null;

}
class StoreLoadingState extends StoreState {
  final String message;

  StoreLoadingState(this.message);

  List<Object> get props => [message];

}
class StoreLoadedState extends StoreState {
  final Store store;
  StoreLoadedState(this.store);
  List<Object> get props => [store];

}
class StoreCubit extends Cubit<StoreState> {
  final CategoryRepository categoryRepository;
  final MenuRepository menuRepository;
  final RestaurantRepository restaurantRepository;
  StoreCubit({this.restaurantRepository,this.menuRepository,this.categoryRepository}) :
  assert(categoryRepository != null),
  assert(menuRepository != null),
  assert(restaurantRepository != null),
        super(StoreInitialState()) {
    loadStore();
  }

  ///Loads the store of the application
  void loadStore() async {
    print("loading store ...");
    emit(StoreLoadingState("loading restaurants"));
    ///TODO: implement load store
    print("getting restaurants");
    final restaurants = await restaurantRepository.getAllRestaurants("10");
    emit(StoreLoadingState("loading categories"));
    print("getting categories");
    final categories = await categoryRepository.getCategories();
    emit(StoreLoadingState("loading trending menus"));
    print("getting trending");
    final trending = await menuRepository.getTrendingMenus();
    final store = Store(
      trendingMenus: trending,
      restaurants: restaurants,
      categories: categories
    );
    emit(StoreLoadedState(store));
  }
}