import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/common/wilaya.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:restaurant_rlutter_ui/src/business_logic/models/delivery.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/delivery_repository.dart';

abstract class DeliveryDataSource {

  Future<List<Commune>> getDeliveryDataOfWilaya(String wilaya_id);
  Future<DeliveryDataResult> getDeliveryPrice(DeliveryPriceParams deliveryPriceParams);
}
class RemoteDeliveryDataSource extends DeliveryDataSource {
  final String zones_endpoint;
  final String delivery_fees_endpoint;
  RemoteDeliveryDataSource({this.zones_endpoint = "https://www.d-makla.com/nassim_api/AppFlutter_all_api.php?city_area_list",
  this.delivery_fees_endpoint = "https://www.d-makla.com/nassim_api/AppFlutter_all_api.php?total_cart_amount"});

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

  @override
  Future<DeliveryDataResult> getDeliveryPrice(DeliveryPriceParams deliveryPriceParams) async{
    final data = deliveryPriceParams.toJson();
    final jsonEncoded = json.encode(data);
    print(jsonEncoded);
    final response = await http.post(this.delivery_fees_endpoint, body: jsonEncoded );
    if (response.body.isNotEmpty) {
      final data = json.decode(response.body);
      print(data);
      if (data != null) {
        print(data);
       return DeliveryDataResult(
         delivery_fee: (data["delivery_fees"] as int).toDouble() ?? 0,
         order_fee: (data["sub_total_cart"] as int).toDouble() ?? 0,
         discount: (data["discount_amount"] as int).toDouble() ?? 0,
       );
      }
    }
    throw Exception("no data");
  }

}
class DeliveryPriceParams {
  final String zoneId;
  final DateTime timestamps;
  final List<MenuPriceParam> menus;

  DeliveryPriceParams({this.zoneId, this.timestamps, this.menus = const []});

  Map<String,dynamic> toJson() {
    return {
      "zone_id" : this.zoneId,
      "timestamps" : timestamps.millisecondsSinceEpoch,
      "orders" : this.menus.map((e) => e.toJson()).toList()
    };
  }
}

class MenuPriceParam {
  final String menu_id;
  final int quantity;
  final String variant_id;
  final List garnitures;
  factory MenuPriceParam.fromOrder(Order order) {
    List garnitures = order.toppingList.getItemsList().map((item) => {
      "id" : item.id,
      "name": item.name
    }).toList();
    return MenuPriceParam(order.menu.id, order.quantity, order.variant.id,garnitures);
  }
  MenuPriceParam(this.menu_id, this.quantity,this.variant_id,this.garnitures);
  Map<String,dynamic> toJson() {
    return {
      "menu_id" : this.menu_id,
      "menu_qty" : this.quantity,
      "variant_id" : this.variant_id,
      "garnitures_list" : garnitures
    };
  }
}