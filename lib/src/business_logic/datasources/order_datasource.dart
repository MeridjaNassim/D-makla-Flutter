import 'package:dmakla/src/business_logic/blocs/delivery/delivery.cubit.dart';
import 'package:dmakla/src/business_logic/models/cart.dart';
import 'package:dmakla/src/business_logic/models/delivery.dart';
import 'package:dmakla/src/business_logic/models/order.dart';
import 'package:dmakla/src/business_logic/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class OrderDataSource {
  Future<OrderConfirmation> createNewOrder(
      User user, Cart cart, DeliveryLocation location, DeliveryTime time,
      {AdditionalDataPayload additionalInfo});

  Future<List<ConfirmedOrder>> getOrders(String userId);
}

class RemoteOrderDataSource extends OrderDataSource {
  final String create_order_endpoint;
  final String history_orders;

  RemoteOrderDataSource({this.create_order_endpoint, this.history_orders})
      : assert(create_order_endpoint != null),
        assert(create_order_endpoint.isNotEmpty),
        assert(history_orders != null),
        assert(history_orders.isNotEmpty);

  @override
  Future<OrderConfirmation> createNewOrder(
      User user, Cart cart, DeliveryLocation location, DeliveryTime time,
      {AdditionalDataPayload additionalInfo}) async {
    /// TODO: convert data to json;
    final body = {
      "user_id": user.id,
      "timestamps": time.dateTime.millisecondsSinceEpoch,
      "orders": cart.orderList.toJson(),
      "zone_id": location.zone.id,
      "order_place_latitude": additionalInfo.gpsPosition.latitude,
      "order_place_longitude": additionalInfo.gpsPosition.longitude,
      "delivery_address_latitude": additionalInfo.gpsPosition.latitude,
      "delivery_address_longitude": additionalInfo.gpsPosition.longitude,
      "name_adr_livr": "",
      "mobile_adr_livr": additionalInfo.contactPhoneNumber,
      "adresse_text": additionalInfo.address,
      "comment_livr": additionalInfo.deliveryComment,
    };
    final encodedJson = json.encode(body);
    print("Encoded JSON data");
    print(encodedJson);
    final response = await http.post(create_order_endpoint, body: encodedJson);
    if (response.body.isNotEmpty) {
      final decoded = json.decode(response.body);
      final data = decoded["ORDER_REGISTRATION"];
      print("Decoded JSON data");
      print(data);
      final error = data["error"];
      if (error != "true")
        return OrderConfirmation(
            orderId: data["orderId"].toString(),
            message: data["message"],
            orderPrice: (data["order_subtotal"] as int).toDouble(),
            deliveryFees:
                num.parse(data["order_delivery_fees"] ?? "0").toDouble(),
            discountAmount: (data["order_discount_fees"] as int).toDouble(),
            total: (data["order_total_amount"] as int).toDouble());
    } else
      throw Exception("Error occured");
  }

  @override
  Future<List<ConfirmedOrder>> getOrders(String userId) async {
    ///TODO : Change this to userId
    final formData = {"user_id": userId};
    final response = await http.post(history_orders, body: formData);
    final data = response.body;
    print(data);
    if (data.isEmpty) {
      ///TODO Handle Error no data in body
      throw Exception("Une erreur est survenu");
    }
    final jsonDecoded = json.decode(data);
    final error = jsonDecoded["error"];
    if (error == "true") {
      throw Exception(jsonDecoded["message"]);
    }
    final items = jsonDecoded["HISTORY_MENU"];

    ConfirmedOrder _convertDataToConfirmedOrder(dynamic data) {
      return ConfirmedOrder(
          id: data["id_order"],
          status: data["status"],
          statusText: data["status_text"],
          webViewUrl: data["web_link"],
          discount: num.parse(data["discount_amount"]).toDouble(),
          deliveryPrice: num.parse(data["delivery_fees"]).toDouble(),
          orderPrice: num.parse(data["sub_price"]).toDouble(),
          totalPrice: num.parse(data["total_amount"]).toDouble(),
          deliveryLocation: data["delivery_Location"],
          imageUrl: data["imageUrl"],
          date: data["date_Order"],
          time: data["time_Order"],
          orderedMenus: (data["menu_list"] as List)
              .map((menuData) => OrderedMenuData(
                  menuName: menuData["menu_name"],
                  restaurantName: menuData["restaurant_name"],
                  quantity: num.parse(menuData["variant_qty"]).toInt(),
                  price: num.parse(menuData["variant_price"]).toDouble(),
                  variante: menuData["variant_type"]))
              .toList());
    }

    if (items != null && items is List) {
      final retValues = items.map(_convertDataToConfirmedOrder).toList();
      return retValues;
    }
    return [];

    // return [
    //   ConfirmedOrder(
    //       id: "FD-17",
    //       status: "completed",
    //       statusText: "Votre commande est terminée",
    //       imageUrl: "https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
    //       date: "22/12/2020",
    //       time: "15:00",
    //       totalPrice: 1000,
    //       deliveryLocation: "Mohammadia",
    //       deliveryPrice: 200,
    //       discount: null,
    //       webViewUrl: "https://pub.dev/",
    //       orderedMenus: [
    //         OrderedMenuData(menuName: "Tacos1",
    //             quantity: 2,
    //             restaurantName: "Capri",
    //             price: 300),
    //         OrderedMenuData(menuName: "Tacos2",
    //             quantity: 2,
    //             restaurantName: "Papas",
    //             price: 300),
    //       ]
    //   ),
    //   ConfirmedOrder(
    //       id: "FD-18",
    //       status: "pending",
    //       webViewUrl: "https://flutter.dev/",
    //       statusText: "Votre commande est terminée",
    //       imageUrl: "https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
    //       date: "22/12/2020",
    //       time: "15:00",
    //       totalPrice: 1000,
    //       deliveryLocation: "Mohammadia",
    //       deliveryPrice: 200,
    //       discount: null,
    //       orderedMenus: [
    //         OrderedMenuData(menuName: "Tacos1",
    //             quantity: 2,
    //             restaurantName: "Capri",
    //             price: 300),
    //         OrderedMenuData(menuName: "Tacos2",
    //             quantity: 2,
    //             restaurantName: "Papas",
    //             price: 300),
    //       ]
    //   ),
    // ];
  }
}
