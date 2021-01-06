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
  final String all_category_endpoint;
  final String restaurant_category_endpoint;
  RemoteCategoryDataSource(
      {this.all_category_endpoint, this.restaurant_category_endpoint});
  @override
  Future<List<Category>> getCategories() async {
    final response = await http.post(this.all_category_endpoint);

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
  Future<List<Category>> getCategoriesByRestaurant(String restaurant_id) async {
    final response = await http.post(this.restaurant_category_endpoint, body: {
      "rest_id": restaurant_id,
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
