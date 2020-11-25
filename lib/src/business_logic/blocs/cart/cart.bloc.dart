import 'package:bloc/bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.state.dart';

class CartBloc extends Bloc<CartEvent,CartState> {
  CartBloc() : super(InitialCartState());
  @override
  Stream<CartState> mapEventToState(CartEvent event) {

  }
}