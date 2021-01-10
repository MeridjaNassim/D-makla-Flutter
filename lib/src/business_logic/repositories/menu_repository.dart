/*
* Gets all data related to Repositories;
* */
import 'package:dmakla/src/business_logic/datasources/menu_datasource.dart';
import 'package:dmakla/src/business_logic/models/category.dart';
import 'package:dmakla/src/business_logic/models/common/image.dart';
import 'package:dmakla/src/business_logic/models/common/wilaya.dart';
import 'package:dmakla/src/business_logic/models/menu.dart';
import 'package:dmakla/src/business_logic/models/restaurant.dart';
import 'package:dmakla/src/business_logic/models/topping.dart';
import 'package:dmakla/src/business_logic/models/variant.dart';

abstract class MenuRepository {
  /// Trending API
  Future<List<Menu>> getTrendingMenus(Wilaya wilaya);
  Future<List<Menu>> getTrendingMenusByRestaurant(Restaurant restaurant);
  Future<List<Menu>> getTrendingMenusByCategory(Category category);

  /// Menu API
  Future<List<Menu>> getAllMenus();
  Future<Menu> getMenuById(String id);
  Future<List<Menu>> getAllMenusByRestaurant(Restaurant restaurant);

  Future<List<Menu>> getAllMenusOfCategoryByRestaurant(
      Restaurant restaurant, Category category);
  Future<List<Menu>> getMenusByCategory(Category category, Wilaya wilaya);
}

class MenuRepositoryImpl implements MenuRepository {
  final RemoteMenuDataSourceImpl remoteMenuDataSourceImpl;

  MenuRepositoryImpl(this.remoteMenuDataSourceImpl);

  @override
  Future<List<Menu>> getAllMenus() {
    // TODO: implement getAllMenus
    throw UnimplementedError();
  }

  @override
  Future<List<Menu>> getAllMenusByRestaurant(Restaurant restaurant) async {
    try {
      final menus =
          await remoteMenuDataSourceImpl.getAllMenusOfRestaurant(restaurant.id);
      return menus;
    } catch (e) {
      //print(e);
      return [];
    }
  }

  @override
  Future<List<Menu>> getAllMenusOfCategoryByRestaurant(
      Restaurant restaurant, Category category) async {
    try {
      final menus = await remoteMenuDataSourceImpl
          .getAllMenusOfCategoryOfRestaurant(restaurant.id, category.id);
      return menus;
    } catch (e) {
      //print(e);
      return [];
    }
  }

  @override
  Future<Menu> getMenuById(String id) {
    // TODO: implement getMenuById
    throw UnimplementedError();
  }

  @override
  Future<List<Menu>> getMenusByCategory(
      Category category, Wilaya wilaya) async {
    try {
      final menus = await remoteMenuDataSourceImpl.getAllMenusOfCategory(
          category.id, wilaya.code);
      return menus;
    } catch (e) {
      //print(e);
      return [];
    }
  }

  @override
  Future<List<Menu>> getTrendingMenus(Wilaya wilaya) async {
    final trendingMenus =
        await this.remoteMenuDataSourceImpl.getTrendingMenus(wilaya.code);
    return trendingMenus;
  }

  @override
  Future<List<Menu>> getTrendingMenusByCategory(Category category) {
    // TODO: implement getTrendingMenusByCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Menu>> getTrendingMenusByRestaurant(Restaurant restaurant) {
    // TODO: implement getTrendingMenusByRestaurant
    throw UnimplementedError();
  }
}

class MockMenuRepository extends MenuRepository {
  static final mockData = [
    Menu(
        id: "menu1",
        name: "pizza peperroni",
        restaurant_name: "papas",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam",
        category: Category(id: "cat1", name: "pizza"),
        variants: VariantListImpl([
          Variant(id: "1", name: "Regulier"),
          Variant(id: "2", name: "Moyen")
        ]),
        image: NetworkImage(
            url:
                "https://images.unsplash.com/photo-1585238342024-78d387f4a707?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80"),
        pricings: PricingsPerVariantImpl()
          ..setPriceForVariant(Variant(id: "1", name: "Regulier"), 170)
          ..setPriceForVariant(Variant(id: "2", name: "Moyen"), 230),
        toppings: ToppingListImpl([
          Topping(
              id: "11",
              name: "sauce ketchup",
              price: 14,
              image: NetworkImage(
                  url:
                      "https://images.unsplash.com/photo-1514326640560-7d063ef2aed5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80")),
          Topping(
              id: "12",
              name: "sauce marinée",
              price: 10,
              image: NetworkImage(
                  url:
                      "https://images.unsplash.com/photo-1514326640560-7d063ef2aed5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80"))
        ])),
    Menu(
        id: "menu2",
        name: "tacos extra",
        restaurant_name: "Capri",
        category: Category(id: "2", name: "tacos"),
        variants: VariantListImpl([
          Variant(id: "1", name: "Regulier"),
          Variant(id: "2", name: "Large")
        ]),
        image: NetworkImage(
            url:
                "https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"),
        pricings: PricingsPerVariantImpl()
          ..setPriceForVariant(Variant(id: "2", name: "Large"), 160)
          ..setPriceForVariant(Variant(id: "1", name: "Regulier"), 100),
        toppings: ToppingListImpl([
          Topping(
              id: "11",
              name: "sauce ketchup",
              price: 14,
              image: NetworkImage(
                  url:
                      "https://images.unsplash.com/photo-1514326640560-7d063ef2aed5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80")),
          Topping(
              id: "12",
              name: "sauce marinée",
              price: 10,
              image: NetworkImage(
                  url:
                      "https://images.unsplash.com/photo-1514326640560-7d063ef2aed5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80"))
        ])),
    Menu(
        id: "menu4",
        name: "burger king",
        restaurant_name: "Syriana",
        category: Category(id: "cat2", name: "burger"),
        variants: VariantListImpl([
          Variant(id: "1", name: "Regulier"),
          Variant(id: "2", name: "Large")
        ]),
        pricings: PricingsPerVariantImpl()
          ..setPriceForVariant(Variant(id: "2", name: "Large"), 300)
          ..setPriceForVariant(Variant(id: "1", name: "Regulier"), 210),
        toppings: ToppingListImpl([]),
        image: NetworkImage(
            url:
                "https://images.unsplash.com/photo-1555554317-766200eb80d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80")),
    Menu(
        id: "menu3",
        name: "pizza vegeratrian",
        restaurant_name: "Capri",
        category: Category(id: "cat1", name: "pizza"),
        variants: VariantListImpl([
          Variant(id: "1", name: "Regulier"),
          Variant(id: "2", name: "Large")
        ]),
        pricings: PricingsPerVariantImpl()
          ..setPriceForVariant(Variant(id: "2", name: "Large"), 160)
          ..setPriceForVariant(Variant(id: "1", name: "Regulier"), 100),
        toppings: ToppingListImpl([]),
        image: NetworkImage(
            url:
                "https://images.unsplash.com/photo-1594007654729-407eedc4be65?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=669&q=80")),
  ];

  @override
  Future<List<Menu>> getAllMenus() {
    // TODO: implement getAllMenus
    throw UnimplementedError();
  }

  @override
  Future<Menu> getMenuById(String id) {
    // TODO: implement getMenuById
    throw UnimplementedError();
  }

  @override
  Future<List<Menu>> getMenusByCategory(
      Category category, Wilaya wilaya) async {
    List<Menu> trending = [];
    mockData.forEach((element) {
      if (element.category == category) trending.add(element);
    });
    return trending;
  }

  @override
  Future<List<Menu>> getTrendingMenus(Wilaya wilaya) async {
    return Future.delayed(Duration(seconds: 1), () => mockData);
  }

  @override
  Future<List<Menu>> getAllMenusByRestaurant(Restaurant restaurant) async {
    List<Menu> menus = [];
    mockData.forEach((menu) {
      if (menu.restaurant_name == restaurant.name) menus.add(menu);
    });
    return menus;
  }

  @override
  Future<List<Menu>> getAllMenusOfCategoryByRestaurant(
      Restaurant restaurant, Category category) async {
    List<Menu> menus = [];
    mockData.forEach((menu) {
      if (menu.restaurant_name == restaurant.name && menu.category == category)
        menus.add(menu);
    });
    return menus;
  }

  @override
  Future<List<Menu>> getTrendingMenusByCategory(Category category) async {
    List<Menu> trending = [];
    mockData.forEach((element) {
      if (element.category == category) trending.add(element);
    });
    return trending;
  }

  @override
  Future<List<Menu>> getTrendingMenusByRestaurant(Restaurant restaurant) async {
    return await getAllMenusByRestaurant(restaurant);
  }
}
