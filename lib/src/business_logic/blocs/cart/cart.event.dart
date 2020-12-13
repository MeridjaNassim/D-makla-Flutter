import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';

abstract class CartEvent extends Equatable{

}
class CartInitialized extends CartEvent{
  final Cart cart;

  CartInitialized(this.cart);

  @override
  // TODO: implement props
  List<Object> get props => null;

}

class OrderAdded extends CartEvent {
  final Menu menu ;
  final Variant variant;
  final ToppingList toppingList;
  final int quantity;
  final String note;
  OrderAdded({this.menu, this.variant, this.toppingList,this.note, this.quantity = 1});

  @override
  // TODO: implement props
  List<Object> get props => [menu];

}
class OrderRemoved extends CartEvent {
  final Order order ;

  OrderRemoved(this.order);

  @override
  // TODO: implement props
  List<Object> get props => [order];

}
class OrderQuantityInceremented extends CartEvent {
  final Order order ;
  final int value;
  OrderQuantityInceremented(this.order, this.value);

  @override
  // TODO: implement props
  List<Object> get props => [order,value];

}
class OrderQuantityDeceremented extends CartEvent {
  final Order order ;
  final int value;
  OrderQuantityDeceremented(this.order, this.value);

  @override
  // TODO: implement props
  List<Object> get props => [order,value];

}
class CartCleared extends CartEvent {
  CartCleared();

  @override
  // TODO: implement props
  List<Object> get props => null;
}
class CartCheckedOut extends CartEvent {
  CartCheckedOut();

  @override
  // TODO: implement props
  List<Object> get props => null;
}
