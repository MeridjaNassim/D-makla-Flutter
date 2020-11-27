import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';

import 'user.dart';

class Cart extends Equatable{
  OrderList orderList;

  Cart(this.orderList);
  void increment(Order order,int amount) => this.orderList.incrementQuantity(order,amount);
  void decrement(Order order,int amount) => this.orderList.decrementQuantity(order,amount);
  void addOrderToCart(Order order) => this.orderList.addNewOrder(order);
  void removeOrderFromCart(Order order) => this.orderList.removeOrder(order);
  void removeOrderFromCartByIndex(int index) => this.orderList.removeOrderByIndex(index);
  void clearCart() =>this.orderList.clear();
  int numberOfOrders() => this.orderList.numberOfDistinctOrders();
  void totalNumberOfOrders() => this.orderList.size();
  Order getOrderByIndex(int index) => this.orderList.getOrderByIndex(index);
  @override
  // TODO: implement props
  List<Object> get props => [orderList];
}