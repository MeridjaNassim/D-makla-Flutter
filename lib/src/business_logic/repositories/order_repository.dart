import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';

abstract class OrderRepository {

  Future<List<Order>> getOrders(String user_id);
  Future<Order> getOrder(String user_id,String order_id);
  Future<List<Order>> createNewOrder(User user,Cart cart);
}