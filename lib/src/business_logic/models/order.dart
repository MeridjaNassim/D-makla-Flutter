

import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';

class Order extends Equatable{
  final Restaurant restaurant;
  final Menu menu;
  final Variant variant;
  final ToppingList toppingList;
  final int quantity;

  Order(
      {this.restaurant,
      this.menu,
      this.variant,
      this.toppingList,
      this.quantity});

  @override
  List<Object> get props {
    return [restaurant,menu,variant,toppingList,quantity];
  }
}

abstract class OrderList extends Equatable {
  void clear();
  Iterable<Order> items();
  void addNewOrder(Order order);
  void removeOrder(Order order);
  void removeOrderByIndex(int index);
  Order getOrderByIndex(int index);
  void incrementQuantity(Order order,int amount);
  void incrementQuantityByIndex(int index,int amount);
  void decrementQuantity(Order ,int amount);
  void decrementQuantityByIndex(int index,int amount);
  void setQuantity(Order order, int value);
  void setQuantityByIndex(int index,int value);
}

class OrderListImpl extends OrderList {
  final List<Order> _items;

  @override
  // TODO: implement props
  List<Object> get props => _items;

  OrderListImpl(List<Order> orders) : this._items = orders;

  @override
  void addNewOrder(Order order) {
    // TODO: implement addNewOrder
  }

  @override
  void removeOrder(Order order) {
    // TODO: implement removeOrder
  }

  @override
  void removeOrderByIndex(int index) {
    // TODO: implement removeOrderByIndex
  }

  @override
  void clear() {
    // TODO: implement clear
    this._items.clear();
  }

  @override
  Iterable<Order> items() {
    // TODO: implement items
   return this._items;
  }

  @override
  void decrementQuantity(Order, int amount) {
    // TODO: implement decrementQuantity
  }

  @override
  void decrementQuantityByIndex(int index, int amount) {
    // TODO: implement decrementQuantityByIndex
  }

  @override
  Order getOrderByIndex(int index) {
    // TODO: implement getOrderByIndex
    throw UnimplementedError();
  }

  @override
  void incrementQuantity(Order order, int amount) {
    // TODO: implement incrementQuantity
  }

  @override
  void incrementQuantityByIndex(int index, int amount) {
    // TODO: implement incrementQuantityByIndex
  }

  @override
  void setQuantity(Order order, int value) {
    // TODO: implement setQuantity
  }

  @override
  void setQuantityByIndex(int index, int value) {
    // TODO: implement setQuantityByIndex
  }
}