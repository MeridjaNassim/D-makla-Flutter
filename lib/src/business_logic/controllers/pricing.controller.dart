import 'package:restaurant_rlutter_ui/src/business_logic/models/cart.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/order.dart';

class OrderPricingController {
  final Order order;
  OrderPricingController(this.order);

  double getOrderBasePrice() {
    final variant = order.variant;
    final menuVariantPrice = order.menu.pricings.getPriceOfVariant(variant);
    final toppingsPrice = getOrderToppingsPrice();
    final quantity = order.quantity;
    return quantity * (menuVariantPrice + toppingsPrice);
  }
  double getOrderToppingsPrice() {
    return order.toppingList.getListPrice();
  }
}

class CartPricingController {
  final Cart cart;
  CartPricingController(this.cart);

  double getCartBasePrice() {
    final orders = this.cart.orderList.items().toList();
    final prices = orders.map((order) {
      final orderPricingController = OrderPricingController(order);
      return orderPricingController.getOrderBasePrice();
    }).toList();
    if(prices.isEmpty) return 0;
    return prices.reduce((value, element) => value + element);
  }
}