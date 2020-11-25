
/*
* Gets all data related to Repositories;
* */
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';

abstract class MenuRepository {
  Future<List<Menu>> getAllMenus();
  Future<Menu> getMenuById(String id);
  Future<Menu> getAllMenusByRestaurantId(String restaurant_id);
  Future<Map<Category,List<Menu>>> getAllMenusOfCategoryByRestaurantId(String restaurant_id,List<Category> categories);
  Future<List<Menu>> getMenusByCategoryId(String category_id);
}

class MenuRepositoryImpl implements MenuRepository{

  @override
  Future<List<Menu>> getAllMenus() async {
    ///TODO implement code to get all menus
    ///TODO implement code to convert the data from raw data to
    throw UnimplementedError();
  }

  @override
  Future<Menu> getMenuById(String id) {
    // TODO: implement getMenuById
    throw UnimplementedError();
  }

  @override
  Future<Menu> getAllMenusByRestaurantId(String restaurant_id) {
    // TODO: implement getAllMenusByRestaurantId
    throw UnimplementedError();
  }

  @override
  Future<Map<Category, List<Menu>>> getAllMenusOfCategoryByRestaurantId(String restaurant_id,List<Category> categories) {
    // TODO: implement getMenusOfCategoryByRestaurantId
    throw UnimplementedError();
  }

  @override
  Future<List<Menu>> getMenusByCategoryId(String category_id) {
    // TODO: implement getMenusByCategoryId
    throw UnimplementedError();
  }
}