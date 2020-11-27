
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/image.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';

abstract class RestaurantRepository {

  Future<List<Restaurant>> getAllRestaurants(String city_id);
  Future<Restaurant> getRestaurantById(String restaurant_id);
}


List<Restaurant> mockData = [
  Restaurant(id: "resto1",name: "Capri",image: NetworkImage(url: "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80")),
  Restaurant(id: "resto2",name: "Syriana",image: NetworkImage(url: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"))
];

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