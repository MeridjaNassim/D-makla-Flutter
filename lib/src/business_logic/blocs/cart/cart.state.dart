import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';

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
  LoadedCartState({this.cart}) : super("loaded");
  @override
  // TODO: implement props
  List<Object> get props => [super.name,cart];
}
