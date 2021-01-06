import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.state.dart';
import 'package:dmakla_flutter/src/business_logic/models/category.dart';
import 'package:dmakla_flutter/src/business_logic/models/menu.dart';
import 'package:dmakla_flutter/src/business_logic/models/restaurant.dart';
import 'package:dmakla_flutter/src/business_logic/models/user.dart';
import 'package:dmakla_flutter/src/business_logic/repositories/menu_repository.dart';

abstract class MenuState extends Equatable {}

class InitialMenuState extends MenuState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class MenuStateLoading extends MenuState {
  final String loadingMessage;

  MenuStateLoading(this.loadingMessage);

  @override
  // TODO: implement props
  List<Object> get props => [loadingMessage];
}

abstract class MenuReadyState extends MenuState {
  final List<Menu> trendingMenus;
  final List<Menu> allMenus;

  MenuReadyState(this.trendingMenus, this.allMenus);
}

class MenuByCategoryStateReady extends MenuReadyState {
  final Category category;

  MenuByCategoryStateReady(
      this.category, List<Menu> trendingMenus, List<Menu> allMenus)
      : super(trendingMenus, allMenus);

  @override
  // TODO: implement props
  List<Object> get props => [category];
}

class MenuByRestaurantStateReady extends MenuReadyState {
  final Restaurant restaurant;

  MenuByRestaurantStateReady(
      this.restaurant, List<Menu> trendingMenus, List<Menu> allMenus)
      : super(trendingMenus, allMenus);

  @override
  // TODO: implement props
  List<Object> get props => [restaurant];
}

class MenuByRestaurantCategoryState extends MenuReadyState {
  final Restaurant restaurant;
  final Category category;

  MenuByRestaurantCategoryState(this.restaurant, this.category,
      List<Menu> trendingMenus, List<Menu> allMenus)
      : super(trendingMenus, allMenus);

  @override
  // TODO: implement props
  List<Object> get props => [restaurant, category];
}

class MenuCubit extends Cubit<MenuState> {
  final MenuRepository _menuRepository;
  final AuthenticationBloc _authenticationBloc;
  MenuCubit(
      AuthenticationBloc authenticationBloc, MenuRepository menuRepository)
      : assert(menuRepository != null),
        assert(authenticationBloc != null),
        this._authenticationBloc = authenticationBloc,
        this._menuRepository = menuRepository,
        super(InitialMenuState());

  Future<void> setMenusByCategory(Category category) async {
    print(category);
    emit(MenuStateLoading("chargement menus de ${category.name}"));
    //final trending = await _menuRepository.getTrendingMenusByCategory(category);
    final authState = _authenticationBloc.state;
    if (authState is AuthenticationAuthenticated) {
      User user = authState.user;
      final allMenus =
          await _menuRepository.getMenusByCategory(category, user.wilaya);
      emit(MenuByCategoryStateReady(category, [], allMenus));
    }
  }

  Future<void> setMenusByRestaurant(Restaurant restaurant) async {
    print(restaurant);
    emit(MenuStateLoading("chargement menus de ${restaurant.name}"));
    final menus = await _menuRepository.getAllMenusByRestaurant(restaurant);
    emit(MenuByRestaurantStateReady(restaurant, [], menus));
  }

  Future<void> setMenusByRestaurantCategory(
      Restaurant restaurant, Category category) async {
    print(restaurant);
    print(category);
    emit(MenuStateLoading(
        "chargement ${category.name} menus de ${restaurant.name}"));
    final menus = await _menuRepository.getAllMenusOfCategoryByRestaurant(
        restaurant, category);
    emit(MenuByRestaurantCategoryState(restaurant, category, [], menus));
  }
}
