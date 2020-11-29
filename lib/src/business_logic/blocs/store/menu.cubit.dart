import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/controllers/pricing.controller.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';

abstract class MenuState extends Equatable {

}

class InitialMenuState extends MenuState {

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class MenuSelectedState extends MenuState {

  final Menu menu;
  final Variant selectedVariant;
  final ToppingList selectedToppings;
  final double currentOrderPrice;
  final int quantity;
  MenuSelectedState(this.menu,this.selectedVariant,this.selectedToppings,this.currentOrderPrice,this.quantity);

  @override
  // TODO: implement props
  List<Object> get props => [menu,selectedVariant,quantity,currentOrderPrice];
}
class CreatingNewOrderFromMenuState extends MenuState {

  CreatingNewOrderFromMenuState();

  @override
  // TODO: implement props
  List<Object> get props => null;
}
class CreatedNewOrderFromMenuState extends MenuState {

  CreatedNewOrderFromMenuState();

  @override
  // TODO: implement props
  List<Object> get props => null;
}
class MenuCubit extends Cubit<MenuState> {
  final CartBloc _cartBloc;
  MenuCubit(CartBloc cartBloc) :
        assert(cartBloc != null),
        this._cartBloc = cartBloc,
        super(InitialMenuState());

  void setCurrentMenu(Menu menu,{Variant selectedVariant,ToppingList selectedToppings,int quantity}) {
    Variant variant = selectedVariant ?? menu.variants.getVariantByIndex(0);
    ToppingList toppings = selectedToppings ?? ToppingListImpl([]);
    Order order = Order(menu: menu,variant: variant,toppingList: toppings ,quantity: quantity ?? 1);
    double price = OrderPricingController(order).getOrderBasePrice();
    emit(MenuSelectedState(menu,variant,toppings,price,1));
  }
  Future<void> addCurrentMenuToCart() async{
    final state = this.state;
    if(state is MenuSelectedState) {
      emit(CreatingNewOrderFromMenuState());
      _cartBloc.add(OrderAdded(
          menu: state.menu,
          variant: state.selectedVariant,
          quantity: state.quantity,
          toppingList:state.selectedToppings ));
      emit(CreatedNewOrderFromMenuState());
    }
  }
  void setSelectedVariant(Variant variant) {
    final state = this.state;
    print("Variant : " + variant.toString());
    if(state is MenuSelectedState) {
      Order order = Order(menu: state.menu,variant: variant,toppingList: state.selectedToppings,quantity: state.quantity);
      double price = OrderPricingController(order).getOrderBasePrice();
      final newState = MenuSelectedState(state.menu,variant,state.selectedToppings,price,state.quantity);
      emit(newState);
    }
  }
  void incrementQuantity() {
    print("Incrementing...");
    final state = this.state;
    if(state is MenuSelectedState) {
      int quantity= state.quantity;
      quantity +=1;
      if(quantity>99) quantity = 99;
      Order order = Order(menu: state.menu,variant: state.selectedVariant,toppingList: state.selectedToppings,quantity: quantity);
      double price = OrderPricingController(order).getOrderBasePrice();
      final newState = MenuSelectedState(state.menu,state.selectedVariant,state.selectedToppings,price,quantity);
      emit(newState);
    }
  }
  void decrementQuantity() {
    print("Decrementing...");
    final state = this.state;
    if(state is MenuSelectedState) {
      int quantity= state.quantity;
      quantity -=1;
      if(quantity<1) quantity = 1;
      Order order = Order(menu: state.menu,variant: state.selectedVariant,toppingList: state.selectedToppings,quantity: quantity);
      double price = OrderPricingController(order).getOrderBasePrice();
      final newState = MenuSelectedState(state.menu,state.selectedVariant,state.selectedToppings,price,quantity);
      emit(newState);
    }
  }
  void toggleTopping(Topping topping) {
    print("Topping toggle : " + topping.toString());
    final state = this.state;
    if(state is MenuSelectedState) {
      final toppings = state.selectedToppings;
      toppings.toggle(topping);
      Order order = Order(menu: state.menu,variant: state.selectedVariant,toppingList: toppings,quantity: state.quantity);
      double price = OrderPricingController(order).getOrderBasePrice();
      final newState = MenuSelectedState(state.menu,state.selectedVariant,toppings,price,state.quantity);
      emit(newState);
    }

  }


}