import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/orders/orders.cubit.dart';
import 'package:dmakla_flutter/src/views/blocs/tabNavigation.cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla_flutter/config/app_config.dart' as config;
import 'package:dmakla_flutter/route_generator.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/delivery/delivery.cubit.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/store/menu.cubit.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/store/order.cubit.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/store/restaurant.cubit.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/store/store.cubit.dart';
import 'package:dmakla_flutter/src/business_logic/datasources/category_datasource.dart';
import 'package:dmakla_flutter/src/business_logic/datasources/delivery_datasource.dart';
import 'package:dmakla_flutter/src/business_logic/datasources/menu_datasource.dart';
import 'package:dmakla_flutter/src/business_logic/datasources/order_datasource.dart';
import 'package:dmakla_flutter/src/business_logic/datasources/restaurant_datasource.dart';
import 'package:dmakla_flutter/src/business_logic/repositories/category_repository.dart';
import 'package:dmakla_flutter/src/business_logic/repositories/delivery_repository.dart';
import 'package:dmakla_flutter/src/business_logic/repositories/menu_repository.dart';
import 'package:dmakla_flutter/src/business_logic/repositories/order_repository.dart';
import 'package:dmakla_flutter/src/business_logic/repositories/restaurant_repository.dart';
import 'package:dmakla_flutter/src/business_logic/services/auth.service.dart';
import 'package:dmakla_flutter/src/business_logic/services/geolocalisation.service.dart';

const String ENV_FILE = ".env";

Future<void> setUpEnvironnement() async {
  await DotEnv().load(ENV_FILE);
  EquatableConfig.stringify = true;
}

DmaklaApp createApp() {
  final env = DotEnv().env;
  final RemoteCategoryDataSource remoteCategoryDataSource =
      RemoteCategoryDataSource(
    all_category_endpoint: env["ALL_CATEGORY_ENDPOINT"],
    restaurant_category_endpoint: env["RESTAURANT_CATEGORY_ENDPOINT"],
  );
  final RemoteRestaurantDataSource remoteRestaurantDataSource =
      RemoteRestaurantDataSource(
          restaurant_endpoint: env["ALL_RESTAURANT_ENDPOINT"]);
  final RemoteDeliveryDataSource remoteDeliveryDataSource =
      RemoteDeliveryDataSource(
          zones_endpoint: env["CITY_AREA_LIST_ENDPOINT"],
          delivery_fees_endpoint: env["DELIVERY_FEES_ENDPOINT"]);
  final RemoteOrderDataSource remoteOrderDataSource = RemoteOrderDataSource(
      create_order_endpoint: env["CREATE_NEW_ORDER_ENDPOINT"],
      history_orders: env["ORDER_HISTORY_ENDPOINT"]);
  final MenuDataSource menuDataSource = RemoteMenuDataSourceImpl(
      trending_endpoint: env["TRENDING_MENUS_ENDPOINT"],
      all_menus_restaurant_endpoint: env["ALL_RESTAURANT_MENUS_ENDPOINT"],
      all_menus_category_endpoint: env["ALL_CATEGORY_MENUS_ENDPOINT"],
      toppingImageUrl: env["TOPPING_IMAGE"]);

  final OrderRepository orderRepository =
      OrderRepositoryImpl(remoteOrderDataSource);
  final restaurantRepository = RestaurantRepositoryImpl(
      remoteRestaurantDataSource: remoteRestaurantDataSource);
  final categoryRepository = CategoryRespositoryImpl(
      remoteCategoryDataSource: remoteCategoryDataSource);
  final deliveryRepository = DeliveryRepositoryImpl(
      remoteDeliveryDataSource: remoteDeliveryDataSource);
  final menuRepository = MenuRepositoryImpl(menuDataSource);

  return DmaklaApp(
    categoryRepository: categoryRepository,
    menuRepository: menuRepository,
    deliveryRepository: deliveryRepository,
    orderRepository: orderRepository,
    restaurantRepository: restaurantRepository,
  );
}

Future<void> main() async {
  await setUpEnvironnement();
  final app = createApp();
  runApp(app);
}

class DmaklaApp extends StatelessWidget {
  OrderRepository orderRepository;
  DeliveryRepository deliveryRepository;
  CategoryRepository categoryRepository;
  MenuRepository menuRepository;
  RestaurantRepository restaurantRepository;
  DmaklaApp(
      {@required this.categoryRepository,
      @required this.deliveryRepository,
      @required this.menuRepository,
      @required this.restaurantRepository,
      @required this.orderRepository})
      : assert(categoryRepository != null),
        assert(deliveryRepository != null),
        assert(restaurantRepository != null),
        assert(menuRepository != null),
        assert(orderRepository != null);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(AuthenticationServiceImpl()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => OrdersCubit(
                  BlocProvider.of<AuthenticationBloc>(context),
                  orderRepository)),
          BlocProvider(create: (context) => TabNavigationCubit()),
          BlocProvider<CartBloc>(
              create: (context) =>
                  CartBloc(BlocProvider.of<AuthenticationBloc>(context))),
          BlocProvider<DeliveryCubit>(
              create: (context) => DeliveryCubit(
                  BlocProvider.of<AuthenticationBloc>(context),
                  BlocProvider.of<CartBloc>(context),
                  deliveryRepository,
                  orderRepository,
                  GeoLocalisationImplGeolocator())),
          BlocProvider<RestaurantCubit>(
              create: (context) => RestaurantCubit(categoryRepository)),
          BlocProvider<MenuCubit>(
              create: (context) => MenuCubit(
                  BlocProvider.of<AuthenticationBloc>(context),
                  menuRepository)),
          BlocProvider<OrderCubit>(
              create: (context) =>
                  OrderCubit(BlocProvider.of<CartBloc>(context))),
          BlocProvider<StoreCubit>(
              create: (context) => StoreCubit(
                    BlocProvider.of<AuthenticationBloc>(context),
                    restaurantRepository: restaurantRepository,
                    menuRepository: menuRepository,
                    categoryRepository: categoryRepository,
                  )),
        ],
        child: MaterialApp(
          title: 'D-makla',
          initialRoute: "/",
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Color(0xFF252525),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xFF2C2C2C),
            accentColor: config.Colors().mainDarkColor(1),
            hintColor: config.Colors().secondDarkColor(1),
            focusColor: config.Colors().accentDarkColor(1),
            textTheme: TextTheme(
              headline: TextStyle(
                  fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
              display1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().secondDarkColor(1)),
              display2: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().secondDarkColor(1)),
              display3: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: config.Colors().mainDarkColor(1)),
              display4: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w300,
                  color: config.Colors().secondDarkColor(1)),
              subhead: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: config.Colors().secondDarkColor(1)),
              title: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().mainDarkColor(1)),
              body1: TextStyle(
                  fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
              body2: TextStyle(
                  fontSize: 14.0, color: config.Colors().secondDarkColor(1)),
              caption: TextStyle(
                  fontSize: 12.0, color: config.Colors().secondDarkColor(0.6)),
            ),
          ),
          theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Colors.white,
            brightness: Brightness.light,
            accentColor: config.Colors().mainColor(1),
            focusColor: config.Colors().accentColor(1),
            hintColor: config.Colors().secondColor(1),
            textTheme: TextTheme(
              headline: TextStyle(
                  fontSize: 20.0, color: config.Colors().secondColor(1)),
              display1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().secondColor(1)),
              display2: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().secondColor(1)),
              display3: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: config.Colors().mainColor(1)),
              display4: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w300,
                  color: config.Colors().secondColor(1)),
              subhead: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500,
                  color: config.Colors().secondColor(1)),
              title: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: config.Colors().mainColor(1)),
              body1: TextStyle(
                  fontSize: 12.0, color: config.Colors().secondColor(1)),
              body2: TextStyle(
                  fontSize: 14.0, color: config.Colors().secondColor(1)),
              caption: TextStyle(
                  fontSize: 12.0, color: config.Colors().accentColor(1)),
            ),
          ),
        ),
      ),
    );
  }
}
