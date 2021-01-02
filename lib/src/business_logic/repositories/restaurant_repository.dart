
import 'package:dmakla_flutter/src/business_logic/datasources/restaurant_datasource.dart';
import 'package:dmakla_flutter/src/business_logic/models/common/image.dart';
import 'package:dmakla_flutter/src/business_logic/models/restaurant.dart';

abstract class RestaurantRepository {

  Future<List<Restaurant>> getAllRestaurants(String city_id);
  Future<Restaurant> getRestaurantById(String restaurant_id);
}


List<Restaurant> mockData = [
  Restaurant(id: "resto1",name: "Capri",phoneNumber:"06736499764",rating: Rating(score: 4.5),description:"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ",image: NetworkImage(url: "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80")),
  Restaurant(id: "resto2",name: "Syriana",image: NetworkImage(url: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80")),
  Restaurant(id: "resto3",name: "papas",image: NetworkImage(url: "https://images.unsplash.com/photo-1544148103-0773bf10d330?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80")),
  Restaurant(id: "resto4",name: "tacos by paris",image: NetworkImage(url: "https://images.unsplash.com/photo-1544148103-0773bf10d330?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80")),
  Restaurant(id: "resto5",name: "brother ts",image: NetworkImage(url: "https://images.unsplash.com/photo-1544148103-0773bf10d330?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80")),
  Restaurant(id: "resto6",name: "burgerking",image: NetworkImage(url: "https://images.unsplash.com/photo-1544148103-0773bf10d330?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"))

];

class RestaurantRepositoryImpl extends RestaurantRepository {
  final RemoteRestaurantDataSource remoteRestaurantDataSource;

  RestaurantRepositoryImpl({this.remoteRestaurantDataSource});

  @override
  Future<List<Restaurant>> getAllRestaurants(String city_id) async{
    final data = await remoteRestaurantDataSource.getRestaurantsOfCity(city_id);
    return data;
  }

  @override
  Future<Restaurant> getRestaurantById(String restaurant_id) {
    // TODO: implement getRestaurantById
    throw UnimplementedError();
  }

}
class MockRestaurantRepository extends RestaurantRepository{
  @override
  Future<List<Restaurant>> getAllRestaurants(String city_id) async{
    // TODO: implement getAllRestaurants
   return Future.delayed(Duration(seconds: 1),()=>mockData);
  }

  @override
  Future<Restaurant> getRestaurantById(String restaurant_id) async{
    return mockData.firstWhere((element) => element.id == restaurant_id);
  }

}