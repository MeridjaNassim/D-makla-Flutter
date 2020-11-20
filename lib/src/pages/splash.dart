import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:restaurant_rlutter_ui/src/features/Auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User user;
  bool loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = null;
    loading = true;
    start();
  }

  Future<void> start() async {
    bool didLoginOnce = await didLoginAtleastOnce();
    if(!didLoginOnce){
      return Navigator.of(context).pushNamed("/");
    }

    /// user already logged in once
    await getCurrentConnectedUser();

    /// if user is available take him to main page
    Timer(Duration(seconds: 3), (){
      print(user);
      if(user!= null) {
        return Navigator.of(context).pushNamed("/Pages", arguments: 2);
      }
      /// if no user and loading finished take him to loginelse if(loading == false) {
      Navigator.of(context).pushNamed("/Login");
    }
  );

}
Future<bool> didLoginAtleastOnce() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool didLoginOnce = sharedPreferences.getBool("didLogInOnce") ?? false;
  return didLoginOnce;
}
Future<void> getCurrentConnectedUser() async {
  User _user = await AuthManager().getCurrentLoggedUser();
  setState(() {
    user = _user;
    loading = false;
  });
}

@override
Widget build(BuildContext context) {
  /// displaying splash screen by default
  return Container(
    width: MediaQuery
        .of(context)
        .size
        .width,
    height: MediaQuery
        .of(context)
        .size
        .height,
    decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                "https://images.unsplash.com/photo-1482049016688-2d3e1b311543?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=653&q=80"),
            fit: BoxFit.cover
        )
    ),
    child: Image(image: NetworkImage(
        "https://img.apksum.com/3f/se.onlinepizza/5.19.1/icon.png"),)
    ,
  );
}}
