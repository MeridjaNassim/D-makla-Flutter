import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/config/app_config.dart' as config;
import 'package:restaurant_rlutter_ui/route_generator.dart';
import 'package:restaurant_rlutter_ui/src/utils/navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigatorBloc>(
      create :(context) =>NavigatorBloc(navigatorKey: _navigatorKey),
      child: MaterialApp(
        title: 'Restaurant Flutter UI',
        initialRoute: '/',
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
            headline: TextStyle(fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
            display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
            display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondDarkColor(1)),
            display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainDarkColor(1)),
            display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondDarkColor(1)),
            subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondDarkColor(1)),
            title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainDarkColor(1)),
            body1: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
            body2: TextStyle(fontSize: 14.0, color: config.Colors().secondDarkColor(1)),
            caption: TextStyle(fontSize: 12.0, color: config.Colors().secondDarkColor(0.6)),
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
            headline: TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
            display1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
            display2: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: config.Colors().secondColor(1)),
            display3: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: config.Colors().mainColor(1)),
            display4: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: config.Colors().secondColor(1)),
            subhead: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: config.Colors().secondColor(1)),
            title: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: config.Colors().mainColor(1)),
            body1: TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
            body2: TextStyle(fontSize: 14.0, color: config.Colors().secondColor(1)),
            caption: TextStyle(fontSize: 12.0, color: config.Colors().accentColor(1)),
          ),
        ),
      ),
    );
  }
}
