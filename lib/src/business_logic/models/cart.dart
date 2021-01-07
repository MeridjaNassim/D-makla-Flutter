import 'package:equatable/equatable.dart';
import 'package:dmakla_flutter/src/business_logic/models/order.dart';

import 'menu.dart';
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
  int totalNumberOfOrders() => this.orderList.size();
  int numberOfOrderByMenu(Menu menu) => this.orderList.countDistinct(menu);
  int sizeOfOrderByMenu(Menu menu) => this.orderList.count(menu);
  Order getOrderByIndex(int index) => this.orderList.getOrderByIndex(index);
  List<Order> getOrdersByMenu(Menu menu) => this.orderList.getOrdersByMenu(menu);
  @override
  // TODO: implement props
  List<Object> get props => [orderList];

  Map<String,dynamic> toJson() {
    return {
      "count" : totalNumberOfOrders(),
      "orders" : orderList.toJson()
    };
  }
}