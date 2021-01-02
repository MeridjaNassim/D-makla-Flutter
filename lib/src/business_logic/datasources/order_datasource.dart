import 'package:dmakla_flutter/src/business_logic/blocs/delivery/delivery.cubit.dart';
import 'package:dmakla_flutter/src/business_logic/models/cart.dart';
import 'package:dmakla_flutter/src/business_logic/models/delivery.dart';
import 'package:dmakla_flutter/src/business_logic/models/order.dart';
import 'package:dmakla_flutter/src/business_logic/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
abstract class OrderDataSource {
  Future<bool> createNewOrder(
      User user, Cart cart, DeliveryLocation location, DeliveryTime time,
      {AdditionalDataPayload additionalInfo});
  Future<List<ConfirmedOrder>> getOrders(String userId);
}

class RemoteOrderDataSource extends OrderDataSource {
  final String endpoint;

  RemoteOrderDataSource({this.endpoint = "https://www.d-makla.com/nassim_api/AppFlutter_all_api.php?signup_order"})
      : assert(endpoint != null),
        assert(endpoint.isNotEmpty);

  @override
  Future<bool> createNewOrder(
      User user, Cart cart, DeliveryLocation location, DeliveryTime time,
      {AdditionalDataPayload additionalInfo}) async{
      /// TODO: convert data to json;
      final body = {
        "user_id" : user.id,
        "timestamps" : time.dateTime.millisecondsSinceEpoch,
        "orders" : cart.orderList.toJson(),
        "zone_id" : location.zone.id,
        "order_place_latitude" : additionalInfo.gpsPosition.latitude,
        "order_place_longitude" : additionalInfo.gpsPosition.longitude,
        "delivery_address_latitude" : additionalInfo.gpsPosition.latitude,
        "delivery_address_longitude" : additionalInfo.gpsPosition.longitude,
        "name_adr_livr" : "",
        "mobile_adr_livr" : additionalInfo.contactPhoneNumber,
        "adresse_text" : additionalInfo.address,
        "comment_livr" : additionalInfo.deliveryComment,
      };
      final encodedJson = json.encode(body);
      print("Encoded JSON data");
      print(encodedJson);
      final response = await http.post(endpoint,body: encodedJson);
      if(response.body.isNotEmpty) {
        final decoded= json.decode(response.body);
        final data  = decoded["ORDER_REGISTRATION"];
        print("Decoded JSON data");
        print(data);
        return true;
      }else
        return false;
  }

  @override
  Future<List<ConfirmedOrder>> getOrders(String userId) async{
    // TODO: GET DATA FROM API FOR ORDERS
    // TODO: CONVERT DATA TO ENTITIES
    // TODO : RETURN VALID DATA
    return [
      ConfirmedOrder(
          id: "FD-17",
          status: "completed",
          statusText: "Votre commande est terminée",
          imageUrl: "https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
          date: "22/12/2020",
          time: "15:00",
          totalPrice: 1000,
          deliveryLocation: "Mohammadia",
          deliveryPrice: 200,
          discount: null,
          webViewUrl: "https://pub.dev/",
          orderedMenus: [
            OrderedMenuData(menuName: "Tacos1" , quantity: 2,restaurantName: "Capri",price: 300),
            OrderedMenuData(menuName: "Tacos2" , quantity: 2,restaurantName: "Papas",price: 300),
          ]
      ),
      ConfirmedOrder(
          id: "FD-18",
          status: "pending",
          webViewUrl: "https://flutter.dev/",
          statusText: "Votre commande est terminée",
          imageUrl: "https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
          date: "22/12/2020",
          time: "15:00",
          totalPrice: 1000,
          deliveryLocation: "Mohammadia",
          deliveryPrice: 200,
          discount: null,
          orderedMenus: [
            OrderedMenuData(menuName: "Tacos1" , quantity: 2,restaurantName: "Capri",price: 300),
            OrderedMenuData(menuName: "Tacos2" , quantity: 2,restaurantName: "Papas",price: 300),
          ]
      ),
    ];
  }

}
