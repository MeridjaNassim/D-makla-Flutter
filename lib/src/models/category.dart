

import 'package:dmakla_flutter/src/business_logic/models/category.dart';

class CategoriesList {
  List<Category> _categoriesList;

  void set categoriesList(List<Category> categories ) {
    this._categoriesList = categories;
  }
  List<Category> get categoriesList => _categoriesList;

  CategoriesList() {}
}
