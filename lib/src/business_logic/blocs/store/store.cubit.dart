import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.state.dart';
import 'package:dmakla/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:dmakla/src/business_logic/models/store.dart';
import 'package:dmakla/src/business_logic/models/user.dart';
import 'package:dmakla/src/business_logic/repositories/category_repository.dart';
import 'package:dmakla/src/business_logic/repositories/menu_repository.dart';
import 'package:dmakla/src/business_logic/repositories/restaurant_repository.dart';

abstract class StoreState extends Equatable {}

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
  final AuthenticationBloc _authenticationBloc;
  StoreCubit(this._authenticationBloc,
      {this.restaurantRepository, this.menuRepository, this.categoryRepository})
      : assert(categoryRepository != null),
        assert(menuRepository != null),
        assert(restaurantRepository != null),
        super(StoreInitialState()) {
    loadStore();
  }

  ///Loads the store of the application
  Future<void> loadStore() async {
    final authState = this._authenticationBloc.state;
    if (authState is AuthenticationAuthenticated) {
      User user = authState.user;
      //print("chargement store ...");
      emit(StoreLoadingState("chargement des restaurants"));

      ///TODO: implement load store
      //print("getting restaurants");
      final wilayaId = user.wilaya.code;
      final restaurants =
          await restaurantRepository.getAllRestaurants(wilayaId);
      emit(StoreLoadingState("chargement des categories"));
      //print("getting categories");
      final categories = await categoryRepository.getCategories();
      emit(StoreLoadingState("chargement des menus"));
      //print("getting trending");
      final trending = await menuRepository.getTrendingMenus(user.wilaya);
      final store = Store(
          trendingMenus: trending,
          restaurants: restaurants,
          categories: categories);
      emit(StoreLoadedState(store));
    }
  }
}
