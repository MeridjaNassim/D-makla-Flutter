import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    start();
  }

  Future<void> start() async {
    print("starting app");
    Timer(Duration(seconds: 2),(){
      BlocProvider.of<AuthenticationBloc>(context).add(AppLoaded());
    });
  }

  @override
  Widget build(BuildContext context) {
    /// displaying splash screen by default
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          print("auth from splash");
          return Navigator.of(context).pushReplacementNamed("/Pages", arguments: 2);
        }
        if(state is AuthenticationNotAuthenticated) {
          print("no auth splash go to login");
          return Navigator.of(context).pushReplacementNamed("/Login");
        }
      },
      builder: (context, state) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=653&q=80"),
                fit: BoxFit.cover)),
        child: Image(
          image: NetworkImage(
              "https://img.apksum.com/3f/se.onlinepizza/5.19.1/icon.png"),
        ),
      ),
    );
  }
}
