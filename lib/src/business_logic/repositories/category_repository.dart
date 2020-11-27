
/*
* Gets all data related to Repositories;
* */

import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/image.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<List<Category>> getCategoriesByRestaurantId(String restaurant_id);
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

  @override
  Future<List<Category>> getCategoriesByRestaurantId(String restaurant_id) {
    // TODO: implement getCategoriesByRestaurantId
    throw UnimplementedError();
  }
}

class MockCategoryRepository implements CategoryRepository {
  final mockData =[
    Category(id: "cat1",name: "pizza",image: NetworkImage(url: "https://images.unsplash.com/photo-1574126154517-d1e0d89ef734?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80" )),
    Category(id: "cat2" , name: "sandwish",image: NetworkImage(url:"https://images.unsplash.com/photo-1555554317-766200eb80d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80" ))
  ];
  @override
  Future<List<Category>> getCategories() async {
    // TODO: implement getCategories
    return Future.delayed(Duration(seconds: 1),()=>mockData);
  }

  @override
  Future<List<Category>> getCategoriesByRestaurantId(String restaurant_id) {
    // TODO: implement getCategoriesByRestaurantId
    throw UnimplementedError();
  }

  @override
  Future<Category> getCategoryById(String id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

}