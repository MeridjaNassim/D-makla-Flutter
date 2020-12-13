
/*
* Gets all data related to Repositories;
* */

import 'package:restaurant_rlutter_ui/src/business_logic/datasources/category_datasource.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/image.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<List<Category>> getCategoriesByRestaurant(Restaurant restaurant);
  Future<Category> getCategoryById(String id);
}

class CategoryRespositoryImpl implements CategoryRepository{
  final RemoteCategoryDataSource remoteCategoryDataSource ;

  CategoryRespositoryImpl({this.remoteCategoryDataSource});

  @override
  Future<List<Category>> getCategories() async{
    final data = await this.remoteCategoryDataSource.getCategories();
    return data;
  }

  @override
  Future<Category> getCategoryById(String id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getCategoriesByRestaurant(Restaurant restaurant) async{
    return await remoteCategoryDataSource.getCategoriesByRestaurant(restaurant.id);
  }
}

class MockCategoryRepository implements CategoryRepository {
  final mockData =[
    Category(id: "cat1",name: "pizza",image: NetworkImage(url: "https://images.unsplash.com/photo-1574126154517-d1e0d89ef734?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1267&q=80" )),
    Category(id: "cat2" , name: "burger",image: NetworkImage(url:"https://images.unsplash.com/photo-1555554317-766200eb80d6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80" )),
    Category(id: "cat3" , name: "sandwish",image: NetworkImage(url:"https://images.unsplash.com/photo-1554433607-66b5efe9d304?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80" )),
    Category(id: "cat4" , name: "icecream",image: NetworkImage(url:"https://images.unsplash.com/photo-1561845730-208ad5910553?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80" ))
  ];
  @override
  Future<List<Category>> getCategories() async {
    // TODO: implement getCategories
    return Future.delayed(Duration(seconds: 1),()=>mockData);
  }

  @override
  Future<List<Category>> getCategoriesByRestaurant(Restaurant restaurant) async{
    return mockData;
  }

  @override
  Future<Category> getCategoryById(String id) {
    // TODO: implement getCategoryById
    throw UnimplementedError();
  }

}