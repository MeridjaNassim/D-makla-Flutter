import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/controllers/pricing.controller.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';
void main(){
  Restaurant restaurant;
  Menu menu;
  Variant variant;
  PricingsPerVariant pricings;
  ToppingList toppingList;
  Order order1;
  Order order2;
  Cart cart;
  CartPricingController cartPricingController;
  OrderPricingController orderPricingController;
  setUp((){

    restaurant = Restaurant(id: "1" , name: "testResto");
    menu = Menu(id: "1",name: "testMenu",toppings: toppingList,pricings: pricings);
    variant = Variant(id: "1",name: "testVariant");
    pricings = PricingsPerVariantImpl()
              ..setPriceForVariant(variant, 100);
    toppingList = ToppingListImpl([Topping(id: "1",price: 10),Topping(id: "1",price: 20)]);
    menu = Menu(id: "1",name: "testMenu",toppings: toppingList,pricings: pricings);
    order1 = Order(restaurant: restaurant,menu:menu,variant: variant,quantity: 1,toppingList: toppingList );
    order2 = Order(restaurant: restaurant,menu:menu,variant: variant,quantity: 2,toppingList: toppingList);
    cart = Cart(OrderListImpl([order1,order2]));
  });

  test("should return correct price for toppings of one order", (){
    /// arrange
    orderPricingController = OrderPricingController(order1);
    /// act
    double toppingsPrice = orderPricingController.getOrderToppingsPrice();
    /// assert
    expect(toppingsPrice,30);
  });

  test("should return correct price for one order", (){
    /// arrange
    orderPricingController = OrderPricingController(order1);
    /// act
    double orderPrice = orderPricingController.getOrderBasePrice();
    /// assert
    expect(orderPrice,130);
  });
  test("should return correct price for cart", (){
    /// arrange
    cartPricingController = CartPricingController(cart);
    /// act
    double cartPrice = cartPricingController.getCartBasePrice();
    /// assert
    expect(cartPrice,390);
  });

}