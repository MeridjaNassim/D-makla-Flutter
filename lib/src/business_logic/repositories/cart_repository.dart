import 'package:dmakla/src/business_logic/models/cart.dart';
import 'package:dmakla/src/models/order.dart';

abstract class CartRepository {

  Future<Cart> createNewCart(String user_id);
  Future<Cart> getUserCart(String user_id);
  Future<Cart> addOrderToUserCart(String userId, Order order);
  Future<bool> removeUserCart(String user_id);
}

class CartRepositoryImpl extends CartRepository {
  @override
  Future<Cart> addOrderToUserCart(String userId, Order order) {
    // TODO: implement addOrderToUserCart
    throw UnimplementedError();
  }

  @override
  Future<Cart> createNewCart(String user_id) {
    // TODO: implement createNewCart
    throw UnimplementedError();
  }

  @override
  Future<Cart> getUserCart(String user_id) {
    // TODO: implement getUserCart
    throw UnimplementedError();
  }

  @override
  Future<bool> removeUserCart(String user_id) {
    // TODO: implement removeUserCart
    throw UnimplementedError();
  }
  
}