import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/config/app_config.dart' as config;
import 'package:restaurant_rlutter_ui/route_generator.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/cart/cart.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/delivery/delivery.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/menu.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/order.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/restaurant.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/store.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/datasources/category_datasource.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/datasources/delivery_datasource.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/datasources/menu_datasource.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/datasources/restaurant_datasource.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/category_repository.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/delivery_repository.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/menu_repository.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/order_repository.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/restaurant_repository.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/services/auth.service.dart';

void main() {
  //TODO get boolean from shared prefs and check if its first
  EquatableConfig.stringify = true;
  runApp(DmaklaApp());
}

class DmaklaApp extends StatelessWidget {
  DmaklaApp();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  final RemoteCategoryDataSource remoteCategoryDataSource =
      RemoteCategoryDataSource();
  final RemoteRestaurantDataSource remoteRestaurantDataSource =
      RemoteRestaurantDataSource();
  final RemoteDeliveryDataSource remoteDeliveryDataSource =
      RemoteDeliveryDataSource();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final menuRepository = MenuRepositoryImpl(RemoteMenuDataSourceImpl());
    final mockCategoryRepository = MockCategoryRepository();
    final restaurantRepository = RestaurantRepositoryImpl(
        remoteRestaurantDataSource: remoteRestaurantDataSource);
    final categoryRepository = CategoryRespositoryImpl(
        remoteCategoryDataSource: remoteCategoryDataSource);
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(AuthenticationServiceImpl()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CartBloc>(
              create: (context) =>
                  CartBloc(BlocProvider.of<AuthenticationBloc>(context))),
          BlocProvider<DeliveryCubit>(
              create: (context) => DeliveryCubit(
                    BlocProvider.of<AuthenticationBloc>(context),
                    BlocProvider.of<CartBloc>(context),
                    DeliveryRepositoryImpl(remoteDeliveryDataSource: remoteDeliveryDataSource),
                    MockOrderRepository(),
                  )),
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
