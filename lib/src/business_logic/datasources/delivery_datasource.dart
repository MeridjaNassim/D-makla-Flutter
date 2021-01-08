import 'package:dmakla/src/business_logic/models/cart.dart';
import 'package:dmakla/src/business_logic/models/common/wilaya.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dmakla/src/business_logic/models/delivery.dart';
import 'package:dmakla/src/business_logic/models/order.dart';
import 'package:dmakla/src/business_logic/repositories/delivery_repository.dart';

abstract class DeliveryDataSource {
  Future<List<Commune>> getDeliveryDataOfWilaya(String wilaya_id);
  Future<DeliveryDataResult> getDeliveryPrice(
      DeliveryPriceParams deliveryPriceParams);
}

class RemoteDeliveryDataSource extends DeliveryDataSource {
  final String zones_endpoint;
  final String delivery_fees_endpoint;
  RemoteDeliveryDataSource({this.zones_endpoint, this.delivery_fees_endpoint});

  @override
  Future<List<Commune>> getDeliveryDataOfWilaya(String wilaya_id) async {
    final formData = {"city_id": wilaya_id};
    final response = await http.post(this.zones_endpoint, body: formData);
    if (response.body.isNotEmpty) {
      final jsonData = json.decode(response.body);
      final data = jsonData["CITY_LIST"] as List;
      if (data.isNotEmpty) {
        final retData = data.map<Commune>((cityData) {
          List<DeliveryZone> zones = (cityData["zone_list"] as List)
              .map<DeliveryZone>(
                  (zone) => DeliveryZone(id: zone["id"], name: zone["name"]))
              .toList();
          return Commune(
              id: cityData["id"], name: cityData["city_name"], zones: zones);
        }).toList();
        return retData;
      }
    }
    throw Exception("no data");
  }

  @override
  Future<DeliveryDataResult> getDeliveryPrice(
      DeliveryPriceParams deliveryPriceParams) async {
    final formData = {
      "zone_id": deliveryPriceParams.zoneId.toString(),
      "timestamps":
          deliveryPriceParams.timestamps.millisecondsSinceEpoch.toString(),
      "orders":
          json.encode(deliveryPriceParams.menus.map((e) => e.toJson()).toList())
    };
    print(formData);
    final response =
        await http.post(this.delivery_fees_endpoint, body: formData);
    if (response.body.isNotEmpty) {
      final data = json.decode(response.body);
      print(data);
      if (data != null) {
        final ret = DeliveryDataResult(
          delivery_fee: parsePrice(data["delivery_fees"]) ?? 0,
          order_fee: parsePrice(data["sub_total_cart"]) ?? 0,
          discount: parsePrice(data["discount_amount"]) ?? 0,
        );
        print(ret.order_fee);
        print(ret.delivery_fee);
        print(ret.discount);
        return ret;
      }
    }
    throw Exception("no data");
  }
}

double parsePrice(dynamic data) {
  if (data == null) return null;
  if (data is int) return data.toDouble();
  if (data is double) return data;
  if (data is String) {
    return num.parse(data).toDouble();
  }
  return null;
}

class DeliveryPriceParams {
  final String zoneId;
  final DateTime timestamps;
  final List<MenuPriceParam> menus;

  DeliveryPriceParams({this.zoneId, this.timestamps, this.menus = const []});

  Map<String, dynamic> toJson() {
    return {
      "zone_id": this.zoneId,
      "timestamps": timestamps.millisecondsSinceEpoch,
      "orders": this.menus.map((e) => e.toJson()).toList()
    };
  }
}

class MenuPriceParam {
  final String menu_id;
  final int quantity;
  final String variant_id;
  final List garnitures;
  factory MenuPriceParam.fromOrder(Order order) {
    List garnitures = order.toppingList
        .getItemsList()
        .map((item) => {"id": item.id, "name": item.name})
        .toList();
    return MenuPriceParam(
        order.menu.id, order.quantity, order.variant.id, garnitures);
  }
  MenuPriceParam(this.menu_id, this.quantity, this.variant_id, this.garnitures);
  Map<String, dynamic> toJson() {
    return {
      "menu_id": this.menu_id,
      "menu_qty": this.quantity,
      "variant_id": this.variant_id,
      "garnitures_list": garnitures
    };
  }
}
