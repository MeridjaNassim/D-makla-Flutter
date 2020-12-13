import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/controllers/pricing.controller.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';

abstract class OrderState extends Equatable {

}

class InitialOrderState extends OrderState {

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class OrderSelectedState extends OrderState {

  final Menu menu;
  final Variant selectedVariant;
  final ToppingList selectedToppings;
  final double currentOrderPrice;
  final int quantity;
  OrderSelectedState(this.menu,this.selectedVariant,this.selectedToppings,this.currentOrderPrice,this.quantity);

  @override
  // TODO: implement props
  List<Object> get props => [menu,selectedVariant,quantity,selectedToppings];
}
class OrderCubit extends Cubit<OrderState> {
  final CartBloc _cartBloc;
  OrderCubit(CartBloc cartBloc) :
        assert(cartBloc != null),
        this._cartBloc = cartBloc,
        super(InitialOrderState());

  void setCurrentMenu(Menu menu,{Variant selectedVariant,ToppingList selectedToppings,int quantity}) {
    Variant variant = selectedVariant ?? menu.variants.getVariantByIndex(0);
    ToppingList toppings = selectedToppings ?? ToppingListImpl([]);
    Order order = Order(menu: menu,variant: variant,toppingList: toppings ,quantity: quantity ?? 1);
    double price = order.getFullPrice();
    emit(OrderSelectedState(menu,variant,toppings,price,quantity ?? 1));
  }
  Future<void> addCurrentMenuToCart({String note}) async{
    final state = this.state;
    if(state is OrderSelectedState) {
      _cartBloc.add(OrderAdded(
          menu: state.menu,
          variant: state.selectedVariant,
          quantity: state.quantity,
          note : note,
          toppingList:state.selectedToppings ));
    }
  }
  void setSelectedVariant(Variant variant) {
    final state = this.state;
    print("Variant : " + variant.toString());
    if(state is OrderSelectedState) {
      Order order = Order(menu: state.menu,variant: variant,toppingList: state.selectedToppings,quantity: state.quantity);
      double price = order.getFullPrice();
      final newState = OrderSelectedState(state.menu,variant,state.selectedToppings,price,state.quantity);
      emit(newState);
    }
  }
  void incrementQuantity() {
    print("Incrementing...");
    final state = this.state;
    if(state is OrderSelectedState) {
      int quantity= state.quantity;
      quantity +=1;
      if(quantity>99) quantity = 99;
      Order order = Order(menu: state.menu,variant: state.selectedVariant,toppingList: state.selectedToppings,quantity: quantity);
      double price = order.getFullPrice();
      final newState = OrderSelectedState(state.menu,state.selectedVariant,state.selectedToppings,price,quantity);
      emit(newState);
    }
  }
  void decrementQuantity() {
    print("Decrementing...");
    final state = this.state;
    if(state is OrderSelectedState) {
      int quantity= state.quantity;
      quantity -=1;
      if(quantity<1) quantity = 1;
      Order order = Order(menu: state.menu,variant: state.selectedVariant,toppingList: state.selectedToppings,quantity: quantity);
      double price = order.getFullPrice();
      final newState = OrderSelectedState(state.menu,state.selectedVariant,state.selectedToppings,price,quantity);
      emit(newState);
    }
  }
  void toggleTopping(Topping topping) {
    print("Topping toggle : " + topping.toString());
    final state = this.state;
    if(state is OrderSelectedState) {
      final toppings = state.selectedToppings;
      final list = toppings.getItemsList();
      ToppingList newToppings = ToppingListImpl([]);
      bool shouldAdd = true;
      list.forEach((element) {
        print("item topping is : " + element.toString());
        if(element != topping) newToppings.addTopping(element);
        else shouldAdd = false;
      });
      if(shouldAdd) newToppings.addTopping(topping);
      Order order = Order(menu: state.menu,variant: state.selectedVariant,toppingList: newToppings,quantity: state.quantity);
      double price = order.getFullPrice();
      final newState = OrderSelectedState(state.menu,state.selectedVariant,newToppings,price,state.quantity);
      print("state is same: " + (newState == state).toString());
      emit(newState);
    }

  }


}