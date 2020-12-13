import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/delivery.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';

abstract class OrderRepository {

  Future<List<Order>> getOrders(User user);
  Future<Order> getOrderDetails(User user, Order order);
  Future<void> createNewOrder(User user,Cart cart,DeliveryLocation location , DeliveryTime time);
}

class MockOrderRepository extends OrderRepository {
  @override
  Future<void> createNewOrder(User user, Cart cart, DeliveryLocation location , DeliveryTime time) async{
    print("Ordering ... ");
    print("User : " + user.toString());
    print("Cart : " +cart.toString());
    print("Location : " +location.toString());
    print("Time : " +time.toString());
  }

  @override
  Future<Order> getOrderDetails(User user, Order order) {
    // TODO: implement getOrderDetails
    throw UnimplementedError();
  }

  @override
  Future<List<Order>> getOrders(User user) {
    // TODO: implement getOrders
    throw UnimplementedError();
  }

}
