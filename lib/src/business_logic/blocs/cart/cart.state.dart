import 'package:equatable/equatable.dart';
import 'package:dmakla/src/business_logic/models/cart.dart';

abstract class CartState extends Equatable {
  final String name;

  CartState(this.name);

  @override
  List<Object> get props {
    return [name];
  }
}

class InitialCartState extends CartState {
  InitialCartState() : super("initial");
}

class LoadingCartState extends CartState {
  LoadingCartState() : super("loading");
}

class LoadedCartState extends CartState{
  final Cart cart;
  final double currentCartPrice;
  LoadedCartState({this.cart,this.currentCartPrice}) : super("loaded");
  @override
  // TODO: implement props
  List<Object> get props => [super.name,cart,currentCartPrice];
}
class CartClearedState extends CartState {
  CartClearedState() : super("cleared");
}
class CartCheckedoutState extends CartState {
  CartCheckedoutState() : super("checkout");
}


class CartErrorState extends CartState {
  final String errorMessage ;

  CartErrorState(this.errorMessage) : super("error");
  @override
  // TODO: implement props
  List<Object> get props => [super.name,errorMessage];
}