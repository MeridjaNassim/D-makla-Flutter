import 'package:flutter/material.dart';
import 'package:dmakla/src/models/route_argument.dart';
import 'package:dmakla/src/views/pages/cart.dart';
import 'package:dmakla/src/views/pages/checkout.dart';
import 'package:dmakla/src/views/pages/delivery.dart';
import 'package:dmakla/src/views/pages/details.dart';
import 'package:dmakla/src/views/pages/food.dart';
import 'package:dmakla/src/views/pages/login.dart';
import 'package:dmakla/src/views/pages/menu_list.dart';
import 'package:dmakla/src/views/pages/pages.dart';
import 'package:dmakla/src/views/pages/signup.dart';
import 'package:dmakla/src/views/pages/splash.dart';
import 'package:dmakla/src/views/pages/order_detail.dart';
import 'package:flutter/services.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesTestWidget());
      case '/Details':
        return MaterialPageRoute(builder: (_) => DetailsWidget());
      case '/Menu':
        return MaterialPageRoute(builder: (_) => MenuWidget());
      case '/Food':
        return MaterialPageRoute(
            builder: (_) => FoodWidget(
                  routeArgument: args as RouteArgument,
                ));
      case '/Cart':
        return MaterialPageRoute(builder: (_) => CartWidget());
      case '/Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutWidget());
      case '/Delivery':
        return MaterialPageRoute(
            builder: (_) => DeliveryScreen(
                  confirmation: args,
                ));
      case '/OrderDetail':
        return MaterialPageRoute(
            builder: (_) => OrderDetailWidget(arguments: args));
//      case '/second':
//      // Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
//        // If args is not of the correct type, return an error page.
//        // You can also throw an exception while in development.
//        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
