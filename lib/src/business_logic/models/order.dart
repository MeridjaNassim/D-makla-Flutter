import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';

class Order extends Equatable {
  final Menu menu;
  final Variant variant;
  final ToppingList toppingList;
  int quantity;

  Order(
      {
      this.menu,
      this.variant,
      this.toppingList,
      this.quantity = 1});

  @override
  List<Object> get props {
    return [menu.id,variant.id];
  }
}

abstract class OrderList extends Equatable {
  void clear();
  int size();
  Iterable<Order> items();

  void addNewOrder(Order order);

  void removeOrder(Order order);

  void removeOrderByIndex(int index);

  Order getOrderByIndex(int index);

  void incrementQuantity(Order order, int amount);

  void incrementQuantityByIndex(int index, int amount);

  void decrementQuantity(Order order, int amount);

  void decrementQuantityByIndex(int index, int amount);

  void setQuantity(Order order, int value);

  void setQuantityByIndex(int index, int value);
  int numberOfDistinctOrders();
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
  void decrementQuantity(Order order, int amount) {
      print("current order quantity:"+ order.quantity.toString());
      if(order.quantity > amount) order.quantity = order.quantity -amount;
      print("current order quantity:"+ order.quantity.toString());
  }

  @override
  void decrementQuantityByIndex(int index, int amount) {
    // TODO: implement decrementQuantityByIndex
  }

  @override
  Order getOrderByIndex(int index) {
    if(_items.length > index) return _items[index];
    return null;
  }

  @override
  void incrementQuantity(Order order, int amount) {
    print("current order quantity:"+ order.quantity.toString());
    int value = order.quantity+amount;
    if(value < 99) order.quantity = value;
    print("current order quantity:"+ order.quantity.toString());
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

  @override
  int size() {
    int size = 0;
    for(Order order in _items) {
      size = size + order.quantity;
    }
    return size;
  }
  @override
  int numberOfDistinctOrders() {
    return this._items.length;
  }
}