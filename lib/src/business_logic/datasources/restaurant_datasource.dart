import 'package:restaurant_rlutter_ui/src/business_logic/models/common/image.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/wilaya.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
abstract class RestaurantDataSource {
  Future<List<Restaurant>> getRestaurantsOfCity(String cityId);
}

/// new api file AppFlutter_all_api.php
class RemoteRestaurantDataSource extends RestaurantDataSource{
  final String endpoint;

  RemoteRestaurantDataSource({this.endpoint = "https://www.d-makla.com/nassim_api/AppFlutter_all_api.php?all_restaurant"});

  @override
  Future<List<Restaurant>> getRestaurantsOfCity(String cityId) async{
    final formData = {
      "city_id" : cityId
    };
    final response = await http.post(this.endpoint,body: formData);
    if(response.body.isNotEmpty){
      final jsonData = json.decode(response.body);
      final data = jsonData["ALL_RESTAURANT"] as List;
      if(data.isNotEmpty)
        {
          final retData = data.map<Restaurant>((restaurantData) => Restaurant(
            id: restaurantData["id"],
            name: restaurantData["restaurant_title"],
            address: restaurantData["restaurant_address"],
            image: NetworkImage(url: restaurantData["image"]),
            wilaya: Wilaya(code: restaurantData["city_id"]),
              commune: Commune(id: restaurantData["sub_city_id"]),
            description: restaurantData["restaurant_description"],
            rating: Rating(score: double.parse((restaurantData["rating"] as String).isNotEmpty ? restaurantData["rating"] :"0"))
          )).toList();
          return retData;
        }
    }
    throw Exception("no data");
  }

}