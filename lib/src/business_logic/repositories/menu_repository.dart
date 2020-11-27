/*
* Gets all data related to Repositories;
* */
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/image.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';

abstract class MenuRepository {
  Future<List<Menu>> getTrendingMenus();

  Future<List<Menu>> getAllMenus();

  Future<Menu> getMenuById(String id);

  Future<Menu> getAllMenusByRestaurantId(String restaurant_id);

  Future<Map<Category, List<Menu>>> getAllMenusOfCategoryByRestaurantId(
      String restaurant_id, List<Category> categories);

  Future<List<Menu>> getMenusByCategoryId(String category_id);
}

class MenuRepositoryImpl implements MenuRepository {
  final mockData = [
    Menu(
        id: "1",
        name: "pizza",
        variants: VariantListImpl([
          Variant(id: "1", name: "XXL"),
          Variant(id: "2", name: "Regulier")
        ]),
        image: NetworkImage(
            url:
                "https://images.unsplash.com/photo-1516685018646-549198525c1b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
        pricings: PricingsPerVariantImpl()..setPriceForVariant( Variant(id: "1", name: "XXL"), 100)..setPriceForVariant( Variant(id: "2", name: "Regulier"), 120),
      toppings: ToppingListImpl([
        Topping(id: "11",price: 14,image: NetworkImage(
            url:
            "https://images.unsplash.com/photo-1514326640560-7d063ef2aed5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80")),
        Topping(id: "12",price: 10,image: NetworkImage(
            url:
            "https://images.unsplash.com/photo-1514326640560-7d063ef2aed5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80"))
      ])
    ),
    Menu(
        id: "2",
        name: "tacos",
        variants: VariantListImpl([
          Variant(id: "1", name: "XXL"),
          Variant(id: "2", name: "Regulier")
        ]),
        image: NetworkImage(
            url:
            "https://images.unsplash.com/photo-1516685018646-549198525c1b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"),
        pricings: PricingsPerVariantImpl()..setPriceForVariant( Variant(id: "1", name: "XXL"), 100)..setPriceForVariant( Variant(id: "2", name: "Regulier"), 120),
        toppings: ToppingListImpl([
          Topping(id: "11",price: 14,image: NetworkImage(
              url:
              "https://images.unsplash.com/photo-1514326640560-7d063ef2aed5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80")),
          Topping(id: "12",price: 10,image: NetworkImage(
              url:
              "https://images.unsplash.com/photo-1514326640560-7d063ef2aed5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80"))
        ])
    )
  ];

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
  Future<Map<Category, List<Menu>>> getAllMenusOfCategoryByRestaurantId(
      String restaurant_id, List<Category> categories) {
    // TODO: implement getMenusOfCategoryByRestaurantId
    throw UnimplementedError();
  }

  @override
  Future<List<Menu>> getMenusByCategoryId(String category_id) {
    // TODO: implement getMenusByCategoryId
    throw UnimplementedError();
  }

  @override
  Future<List<Menu>> getTrendingMenus() async{
    return mockData;
  }
}

class MockMenuRepository extends MenuRepository {
  @override
  Future<List<Menu>> getAllMenus() {
    // TODO: implement getAllMenus
    throw UnimplementedError();
  }

  @override
  Future<Menu> getAllMenusByRestaurantId(String restaurant_id) {
    // TODO: implement getAllMenusByRestaurantId
    throw UnimplementedError();
  }

  @override
  Future<Map<Category, List<Menu>>> getAllMenusOfCategoryByRestaurantId(
      String restaurant_id, List<Category> categories) {
    // TODO: implement getAllMenusOfCategoryByRestaurantId
    throw UnimplementedError();
  }

  @override
  Future<Menu> getMenuById(String id) {
    // TODO: implement getMenuById
    throw UnimplementedError();
  }

  @override
  Future<List<Menu>> getMenusByCategoryId(String category_id) {
    // TODO: implement getMenusByCategoryId
    throw UnimplementedError();
  }

  @override
  Future<List<Menu>> getTrendingMenus() {}
}
