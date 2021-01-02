import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dmakla_flutter/src/business_logic/models/category.dart';
import 'package:dmakla_flutter/src/business_logic/models/common/image.dart';

abstract class CategoryDataSource {
  Future<List<Category>> getCategoriesByRestaurant(String restaurant_id);
  Future<List<Category>> getCategories();
}

/// new api file AppFlutter_all_api.php
class RemoteCategoryDataSource extends CategoryDataSource {
  static String REMOTE_CATEGORY_ENDPOINT =
      "https://www.d-makla.com/nassim_api/AppAndroid_all_apiBis.php?all_category";
  static String REMOTE_CATEGORY_RESTAURANT_ENDPOINT = "https://www.d-makla.com/nassim_api/AppFlutter_all_api.php?category";
  @override
  Future<List<Category>> getCategories() async {
    final response = await http.post(REMOTE_CATEGORY_ENDPOINT);

    /// if we have a body in the response
    if (response.body.isNotEmpty) {
      final jsonDecoded = json.decode(response.body);
      final data = jsonDecoded["ALL_CATEGORY"];
      if (data.isNotEmpty) {
        final retData = (data as List<dynamic>).map<Category>((categoryData) {
          return Category(
              id: categoryData["id"],
              name: categoryData["category_name"],
              image: NetworkImage(url: categoryData["image"]));
        }).toList();
        return retData;
      }
    }
    throw Exception("no data");
  }

  @override
  Future<List<Category>> getCategoriesByRestaurant(String restaurant_id) async{
    final response = await http.post(REMOTE_CATEGORY_RESTAURANT_ENDPOINT, body: {
      "rest_id" : restaurant_id,
    });

    /// if we have a body in the response
    if (response.body.isNotEmpty) {
      final jsonDecoded = json.decode(response.body);
      final data = jsonDecoded["CATEGORY_LIST"];
      if (data.isNotEmpty) {
        final retData = (data as List<dynamic>).map<Category>((categoryData) {
          return Category(
              id: categoryData["id"],
              name: categoryData["category_name"],
              image: NetworkImage(url: categoryData["image"]));
        }).toList();
        return retData;
      }
    }
    throw Exception("no data");
  }
}
