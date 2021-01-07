import 'package:dmakla_flutter/src/business_logic/models/category.dart';
import 'package:dmakla_flutter/src/business_logic/models/common/image.dart';
import 'package:dmakla_flutter/src/business_logic/models/menu.dart';
import 'package:http/http.dart' as http;
import 'package:dmakla_flutter/src/business_logic/models/topping.dart';
import 'dart:convert';

import 'package:dmakla_flutter/src/business_logic/models/variant.dart';

abstract class MenuDataSource {
  Future<List<Menu>> getTrendingMenus(String city_id);
  Future<List<Menu>> getAllMenusOfRestaurant(String restaurant_id);
  Future<List<Menu>> getAllMenusOfCategoryOfRestaurant(
      String restaurant_id, String category_id);
  Future<List<Menu>> getAllMenusOfCategory(String category_id, String city_id);
}

/// new api file AppFlutter_all_api.php
class RemoteMenuDataSourceImpl extends MenuDataSource {
  final String trending_endpoint;
  final String all_menus_restaurant_endpoint;
  final String all_menus_category_endpoint;
  final String toppingImageUrl;
  RemoteMenuDataSourceImpl(
      {this.trending_endpoint,
      this.all_menus_restaurant_endpoint,
      this.all_menus_category_endpoint,
      this.toppingImageUrl});

  @override
  Future<List<Menu>> getTrendingMenus(String city_id) async {
    final formData = {"city_id": city_id};
    final response = await http.post(this.trending_endpoint, body: formData);
    if (response.body.isNotEmpty) {
      final jsonDecoded = json.decode(response.body);
      final data = jsonDecoded["TRENDING_MENU"] as List;
      if (data.isNotEmpty) {
        final retData = data.map<Menu>(_convertMenuDataToMenu).toList();
        return retData;
      }
    }
    throw Exception("no data");
  }

  @override
  Future<List<Menu>> getAllMenusOfRestaurant(String restaurant_id) async {
    final formData = {"rest_id": restaurant_id};
    final response =
        await http.post(this.all_menus_restaurant_endpoint, body: formData);
    if (response.body.isNotEmpty) {
      final jsonDecoded = json.decode(response.body);
      print(jsonDecoded);
      final data = jsonDecoded["RESTAURANT_TRENDING_MENU"] as List;
      print(data);
      if (data.isNotEmpty) {
        final retData = data.map<Menu>(_convertMenuDataToMenu).toList();
        return retData;
      }
    }
    throw Exception("no data");
  }

  @override
  Future<List<Menu>> getAllMenusOfCategoryOfRestaurant(
      String restaurant_id, String category_id) async {
    final formData = {"rest_id": restaurant_id, "category_id": category_id};
    final response =
        await http.post(this.all_menus_restaurant_endpoint, body: formData);
    if (response.body.isNotEmpty) {
      final jsonDecoded = json.decode(response.body);
      print(jsonDecoded);
      final data = jsonDecoded["RESTAURANT_TRENDING_MENU"] as List;
      print(data);
      if (data.isNotEmpty) {
        final retData = data.map<Menu>(_convertMenuDataToMenu).toList();
        return retData;
      }
    }
    throw Exception("no data");
  }

  @override
  Future<List<Menu>> getAllMenusOfCategory(
      String category_id, String city_id) async {
    final formData = {"category_id": category_id, "city_id": city_id};
    final response =
        await http.post(this.all_menus_category_endpoint, body: formData);
    if (response.body.isNotEmpty) {
      final jsonDecoded = json.decode(response.body);
      print(jsonDecoded);
      final data = jsonDecoded["ALL_MENU_CATEGORY"] as List;
      print(data);
      if (data.isNotEmpty) {
        final retData = data.map<Menu>(_convertMenuDataToMenu).toList();
        return retData;
      }
    }
    throw Exception("no data");
  }

  Menu _convertMenuDataToMenu(dynamic data) {
    PricingsPerVariant pricings = PricingsPerVariantImpl();
    List<Variant> variants =
        (data["variantes_list"] as List).map<Variant>((variant) {
      final _variant = Variant(
        id: variant["id"],
        name: variant["name"],
      );
      print(_variant);
      print(variant["price"]);
      final priceStr = variant["price"] as String;
      double price = 0;
      if (priceStr.isNotEmpty) price = double.parse(priceStr);
      pricings.setPriceForVariant(_variant, price);
      return _variant;
    }).toList();
    List<Topping> toppings = [];
    (data["garnitures_list"] as List).forEach((topping) {
      if (topping["error"] == null) {
        toppings.add(Topping(
            id: topping["id"],
            name: topping["name"],
            price: double.parse(topping["price"]),
            image: NetworkImage(url: this.toppingImageUrl)));
      }
    });
    return Menu(
        id: data["id"],
        restaurant_name: data["restaurant_name"],
        image: NetworkImage(url: data["image"]),
        category: Category(
            id: data["categorie"]["id"], name: data["categorie"]["name"]),
        description: data["description"],
        name: data["name"],
        variants: VariantListImpl(variants),
        toppings: ToppingListImpl(toppings),
        pricings: pricings);
  }
}
