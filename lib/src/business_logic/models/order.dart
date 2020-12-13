import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';

class Order extends Equatable {
  final String id;
  final Menu menu;
  final Variant variant;
  final String note;
  final ToppingList toppingList;
  final DateTime creationDate;
  int quantity;
  double price;
  Order(
      {
        this.id,
      this.menu,
        this.note,
      this.variant,
      this.toppingList,
        this.creationDate,
      this.quantity = 1});

  @override
  List<Object> get props {
    return [id,menu,variant,toppingList,creationDate];
  }

  double getUnitPrice() {
    final variantPrice = this.menu.pricings.getPriceOfVariant(this.variant);
    final toppingsPrice = this.toppingList.getListPrice();
    if(variantPrice != null && toppingsPrice != null) return (variantPrice+toppingsPrice);
    return 0;
  }
  double getFullPrice() {
    return this.getUnitPrice() *this.quantity;
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
  int countDistinct(Menu menu);
  int count(Menu menu);
}

class OrderListImpl extends OrderList {
  final List<Order> _items;

  @override
  // TODO: implement props
  List<Object> get props => _items;

  OrderListImpl(List<Order> orders) : this._items = orders;

  @override
  void addNewOrder(Order order) {
    if(_items.isEmpty) return _items.add(order);
    // check if this order exists first
    print("checking if exists");
    Order existOrder = _items.firstWhere((element){
      return element.menu == order.menu && element.variant == order.variant && element.toppingList == order.toppingList;
    },orElse: ()=>null);
    if(existOrder == null) {
      print("order does not exist");
      return _items.add(order);
    }
    int quantity = existOrder.quantity;
    order.quantity = order.quantity+quantity;
    removeOrder(existOrder);
    return _items.add(order);
  }

  @override
  void removeOrder(Order order) {
    // TODO: implement removeOrder
    if(this._items != null && this._items.isNotEmpty) this._items.remove(order);
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

  @override
  int countDistinct(Menu menu) {
    int _count = 0;
    this._items.forEach((element) {
      if(element.menu == menu) _count++;
    });
    return _count;
  }
  @override
  int count(Menu menu) {
    int _count = 0;
    this._items.forEach((element) {
      if(element.menu == menu) _count+=element.quantity;
    });
    return _count;
  }
}
