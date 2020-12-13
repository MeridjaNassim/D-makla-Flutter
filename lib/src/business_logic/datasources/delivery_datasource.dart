import 'package:restaurant_rlutter_ui/src/business_logic/models/common/wilaya.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:restaurant_rlutter_ui/src/business_logic/models/delivery.dart';

abstract class DeliveryDataSource {

  Future<List<Commune>> getDeliveryDataOfWilaya(String wilaya_id);
}

class RemoteDeliveryDataSource extends DeliveryDataSource {
  final String zones_endpoint;

  RemoteDeliveryDataSource({this.zones_endpoint = "https://www.d-makla.com/nassim_api/AppFlutter_all_api.php?city_area_list"});

  @override
  Future<List<Commune>> getDeliveryDataOfWilaya(String wilaya_id) async {
    final formData = {
      "city_id": wilaya_id
    };
    final response = await http.post(this.zones_endpoint, body: formData);
    if (response.body.isNotEmpty) {
      final jsonData = json.decode(response.body);
      final data = jsonData["CITY_LIST"] as List;
      if (data.isNotEmpty) {
        final retData = data.map<Commune>((cityData) {
          List<DeliveryZone> zones = (cityData["zone_list"] as List).map<
              DeliveryZone>((zone) => DeliveryZone(
              id: zone["id"],
              name: zone["name"]
          )).toList();
          return Commune(
              id: cityData["id"],
              name: cityData["city_name"],
              zones: zones
          );
        }).toList();
        return retData;
      }
    }
    throw Exception("no data");
  }

}