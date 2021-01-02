import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async{
  final formData = {
    "zone_id" : "1",
    "timestamps" : "1609587634481",
    "orders" : json.encode([{"menu_id":"482","menu_qty":3,"variant_id":"776","garnitures_list":[]}])
  };
  final response = await http.post("https://www.d-makla.com/nassim_api/AppFlutter_all_api.php?total_cart_amount", body: formData);
  print(response.body);
}