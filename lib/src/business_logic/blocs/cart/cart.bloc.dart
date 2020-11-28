import 'package:bloc/bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/controllers/pricing.controller.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/menu_repository.dart';

class CartBloc extends Bloc<CartEvent,CartState> {
  final AuthenticationBloc _authenticationBloc;
  CartBloc(this._authenticationBloc) :
        assert (_authenticationBloc != null),
        super(LoadingCartState()) {
    initCart();
  }
  @override
  Stream<CartState> mapEventToState(CartEvent event) async*{
    if(event is CartInitialized) {
      print(event.cart);
      yield LoadedCartState(cart : event.cart,currentCartPrice: CartPricingController(event.cart).getCartBasePrice());
    }
    final state = this.state;
    if(state is LoadedCartState) {
      Cart cart = state.cart;
      if(event is OrderAdded){
        yield* _mapOrderAddedEvent(event,cart);
      }
      if(event is OrderRemoved){
        yield* _mapOrderRemovedEvent(event,cart);
      }
      if(event is OrderQuantityInceremented){
        yield* _mapOrderIncrementedEvent(event,cart);
      }
      if(event is OrderQuantityDeceremented){
        yield* _mapOrderDecrementedEvent(event,cart);
      }
      if(event is CartCleared){
        yield* _mapCartClearedEvent(event,cart);
      }
      if(event is CartCheckedOut){
        yield* _mapCartCheckoutEvent(event,cart);
      }
      double currentPrice = CartPricingController(cart).getCartBasePrice();
      yield LoadedCartState(cart: cart,currentCartPrice: currentPrice);
    }

  }

  Stream<CartState> _mapOrderAddedEvent(OrderAdded event,Cart cart)  async *{
      cart.addOrderToCart(event.order);
  }
  Stream<CartState> _mapOrderRemovedEvent(OrderRemoved event,Cart cart)  async *{
      cart.removeOrderFromCart(event.order);
  }
  Stream<CartState> _mapOrderIncrementedEvent(OrderQuantityInceremented event,Cart cart)  async *{
      print("incrementing");
      print(cart.orderList);
      print(event.order);
      print(event.value);
      cart.increment(event.order, event.value);
  }
  Stream<CartState> _mapOrderDecrementedEvent(OrderQuantityDeceremented event,Cart cart)  async *{
    print("decrementing");
    print(cart.orderList);
    print(event.order);
    print(event.value);
    cart.decrement(event.order, event.value);
  }
  Stream<CartState> _mapCartClearedEvent(CartCleared state ,Cart cart)  async *{
      cart.clearCart();
  }
  Stream<CartState> _mapCartCheckoutEvent(CartCheckedOut event,Cart cart)  async *{
      cart.clearCart();
  }

  void initCart() async{
    ///TODO implement logic to initialize cart
    print("init cart ... ");
    Future.delayed(Duration(seconds:  2),(){
      print("cart initialized");
      Order order1 = Order(menu: MockMenuRepository.mockData[0], variant: MockMenuRepository.mockData[0].variants.getVariantByIndex(0), toppingList: ToppingListImpl([]) );
      Order order2 = Order(menu: MockMenuRepository.mockData[1], variant: MockMenuRepository.mockData[1].variants.getVariantByIndex(0), toppingList: ToppingListImpl([]) );
      Order order3 = Order(menu: MockMenuRepository.mockData[1], variant: MockMenuRepository.mockData[1].variants.getVariantByIndex(1), toppingList: ToppingListImpl([]) );
      Cart cart = Cart(OrderListImpl([order1,order2,order3]));
      add(CartInitialized(cart));
    });
  }
}