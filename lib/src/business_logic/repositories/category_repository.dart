
/*
* Gets all data related to Repositories;
* */
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category> getCategoryById(String id);
}

class CategoryRespositoryImpl implements CategoryRepository{
  
  @override
  Future<List<Category>> getCategories() {
    ///TODO implement code to get all categories
    ///TODO implement code to convert the data from raw data to 
  }

  @override
  Future<Category> getCategoryById(String id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }
}