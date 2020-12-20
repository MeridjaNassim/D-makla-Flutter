import 'package:restaurant_rlutter_ui/src/business_logic/blocs/delivery/delivery.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/delivery.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
abstract class OrderDataSource {
  Future<bool> createNewOrder(
      User user, Cart cart, DeliveryLocation location, DeliveryTime time,
      {ConfirmDeliveryPayload additionalInfo});
}

class RemoteOrderDataSource extends OrderDataSource {
  final String endpoint;

  RemoteOrderDataSource({this.endpoint = "https://www.d-makla.com/nassim_api/AppFlutter_all_api.php?signup_order"})
      : assert(endpoint != null),
        assert(endpoint.isNotEmpty);

  @override
  Future<bool> createNewOrder(
      User user, Cart cart, DeliveryLocation location, DeliveryTime time,
      {ConfirmDeliveryPayload additionalInfo}) async{
      /// TODO: convert data to json;
      final body = {
        "user_id" : user.id,
        "timestamps" : time.dateTime.millisecondsSinceEpoch,
        "orders" : cart.orderList.toJson(),
        "zone_id" : location.zone.id,
        "order_place_latitude" : 36.77558,
        "order_place_longitude" : 3.060501,
        "delivery_address_latitude" : 36.77558,
        "delivery_address_longitude" : 3.060501,
        "name_adr_livr" : additionalInfo.address,
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
}
