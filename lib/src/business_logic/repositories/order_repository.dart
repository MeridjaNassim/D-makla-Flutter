import 'package:dmakla_flutter/src/business_logic/blocs/delivery/delivery.cubit.dart';
import 'package:dmakla_flutter/src/business_logic/datasources/order_datasource.dart';
import 'package:dmakla_flutter/src/business_logic/models/cart.dart';
import 'package:dmakla_flutter/src/business_logic/models/delivery.dart';
import 'package:dmakla_flutter/src/business_logic/models/order.dart';
import 'package:dmakla_flutter/src/business_logic/models/user.dart';

abstract class OrderRepository {
  Future<List<ConfirmedOrder>> getOrders(User user);
  Future<Order> getOrderDetails(User user, Order order);
  Future<OrderConfirmation> createNewOrder(
      User user, Cart cart, DeliveryLocation location, DeliveryTime time,
      {AdditionalDataPayload additionalInfo});
}

class OrderRepositoryImpl extends OrderRepository {
  final OrderDataSource orderDataSource;

  OrderRepositoryImpl(this.orderDataSource);

  @override
  Future<OrderConfirmation> createNewOrder(
      User user, Cart cart, DeliveryLocation location, DeliveryTime time,
      {AdditionalDataPayload additionalInfo}) async {
    return this.orderDataSource.createNewOrder(user, cart, location, time,
        additionalInfo: additionalInfo);
  }

  @override
  Future<Order> getOrderDetails(User user, Order order) {
    // TODO: implement getOrderDetails
    throw UnimplementedError();
  }

  @override
  Future<List<ConfirmedOrder>> getOrders(User user) {
    return orderDataSource.getOrders(user.id);
  }
}

class MockOrderRepository extends OrderRepository {
  @override
  Future<OrderConfirmation> createNewOrder(
      User user, Cart cart, DeliveryLocation location, DeliveryTime time,
      {AdditionalDataPayload additionalInfo}) async {
    print("Ordering ... ");
    print("User : " + user.toString());
    print("Cart : " + cart.toString());
    print("Location : " + location.toString());
    print("Time : " + time.toString());
    return null;
  }

  @override
  Future<Order> getOrderDetails(User user, Order order) {
    // TODO: implement getOrderDetails
    throw UnimplementedError();
  }

  @override
  Future<List<ConfirmedOrder>> getOrders(User user) {
    return Future.delayed(Duration(seconds: 0), () {
      return [
        ConfirmedOrder(
            id: "FD-17",
            status: "completed",
            statusText: "Votre commande est terminée",
            imageUrl:
                "https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
            date: "22/12/2020",
            time: "15:00",
            totalPrice: 1000,
            deliveryLocation: "Mohammadia",
            deliveryPrice: 200,
            discount: null,
            webViewUrl: "https://pub.dev/",
            orderedMenus: [
              OrderedMenuData(
                  menuName: "Tacos1",
                  quantity: 2,
                  restaurantName: "Capri",
                  price: 300),
              OrderedMenuData(
                  menuName: "Tacos2",
                  quantity: 2,
                  restaurantName: "Papas",
                  price: 300),
            ]),
        ConfirmedOrder(
            id: "FD-18",
            status: "pending",
            webViewUrl: "https://flutter.dev/",
            statusText: "Votre commande est terminée",
            imageUrl:
                "https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
            date: "22/12/2020",
            time: "15:00",
            totalPrice: 1000,
            deliveryLocation: "Mohammadia",
            deliveryPrice: 200,
            discount: null,
            orderedMenus: [
              OrderedMenuData(
                  menuName: "Tacos1",
                  quantity: 2,
                  restaurantName: "Capri",
                  price: 300),
              OrderedMenuData(
                  menuName: "Tacos2",
                  quantity: 2,
                  restaurantName: "Papas",
                  price: 300),
            ]),
      ];
    });
  }
}
