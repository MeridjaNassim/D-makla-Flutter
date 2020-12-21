import 'package:restaurant_rlutter_ui/src/business_logic/blocs/delivery/delivery.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/datasources/order_datasource.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/delivery.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';

abstract class OrderRepository {

  Future<List<Order>> getOrders(User user);
  Future<Order> getOrderDetails(User user, Order order);
  Future<bool> createNewOrder(User user,Cart cart,DeliveryLocation location , DeliveryTime time,
      {AdditionalDataPayload additionalInfo});
}


class OrderRepositoryImpl  extends OrderRepository{
  final OrderDataSource orderDataSource;

  OrderRepositoryImpl(this.orderDataSource);

  @override
  Future<bool> createNewOrder(User user, Cart cart, DeliveryLocation location, DeliveryTime time, {AdditionalDataPayload additionalInfo}) async{
    return this.orderDataSource.createNewOrder(user, cart, location, time,additionalInfo: additionalInfo);
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


class MockOrderRepository extends OrderRepository {
  @override
  Future<bool> createNewOrder(User user, Cart cart, DeliveryLocation location , DeliveryTime time, {AdditionalDataPayload additionalInfo}) async{
    print("Ordering ... ");
    print("User : " + user.toString());
    print("Cart : " +cart.toString());
    print("Location : " +location.toString());
    print("Time : " +time.toString());
    return true;
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
