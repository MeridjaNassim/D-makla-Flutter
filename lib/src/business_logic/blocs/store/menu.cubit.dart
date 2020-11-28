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
  final List<Topping> selectedToppings;
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

  void setCurrentMenu(Menu menu) {
    Variant firstVariant = menu.variants.getVariantByIndex(0);
    Order order = Order(menu: menu,variant: firstVariant,toppingList: ToppingListImpl([]),quantity: 1);
    double price = OrderPricingController(order).getOrderBasePrice();
    emit(MenuSelectedState(menu,firstVariant,[],price,1));
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
      Future.delayed(Duration(seconds: 1),(){
        setCurrentMenu(state.menu);
      });
    }
  }
  void setSelectedVariant(Variant variant) {
    final state = this.state;
    print("Variant : " + variant.toString());
    if(state is MenuSelectedState) {
      Order order = Order(menu: state.menu,variant: variant,toppingList: ToppingListImpl(state.selectedToppings),quantity: state.quantity);
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
      Order order = Order(menu: state.menu,variant: state.selectedVariant,toppingList: ToppingListImpl(state.selectedToppings),quantity: quantity);
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
      Order order = Order(menu: state.menu,variant: state.selectedVariant,toppingList: ToppingListImpl(state.selectedToppings),quantity: quantity);
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
      final _topping = toppings.firstWhere((element) => element == topping,orElse: ()=>null);
      if(_topping == null) {
        print("added topping"+ topping.toString());
        toppings.add(topping);

      }
      else{
        print("removed topping"+ topping.toString());
        toppings.remove(topping);
      }
      Order order = Order(menu: state.menu,variant: state.selectedVariant,toppingList: ToppingListImpl(toppings),quantity: state.quantity);
      double price = OrderPricingController(order).getOrderBasePrice();
      final newState = MenuSelectedState(state.menu,state.selectedVariant,toppings,price,state.quantity);
      emit(newState);
    }

  }


}