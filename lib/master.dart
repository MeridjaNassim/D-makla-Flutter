import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/controllers/pricing.controller.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/topping.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/variant.dart';

Future<void> main() async {
  EquatableConfig.stringify = true;

  Variant xxl = Variant(id: "1", name: "XXL");
  PricingsPerVariant princings1 = PricingsPerVariantImpl();
  PricingsPerVariant princings2 = PricingsPerVariantImpl();
  princings1.setPriceForVariant(xxl, 100);
  princings2.setPriceForVariant(xxl, 222);
  List<Topping> toppings = [
    Topping(id: "1", price: 10),
    Topping(id: "2", price: 20)
  ];

  Restaurant restaurant = Restaurant(id: "165");

  List<Order> orders = [
    Order(restaurant: restaurant,
        variant: xxl,
        menu: Menu(id: "44", pricings: princings1),
        toppingList: ToppingListImpl(toppings),quantity: 2),
    Order(
        restaurant: Restaurant(id: "165"),
        menu: Menu(id: "42", pricings: princings2),
        variant: xxl,
        toppingList: ToppingListImpl(toppings),quantity: 1)
  ];
  Cart cart = Cart( OrderListImpl(orders));
  User user = User(id: "1", fullName: "nassim", phoneNumber: "1616979",cart: cart);


  double basePrice = CartPricingController(cart).getCartBasePrice();

  print("price :"+ basePrice.toString() );
}


