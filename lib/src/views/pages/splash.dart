import 'dart:async';

import 'package:dmakla_flutter/src/views/elements/common/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.event.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.state.dart';

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
    Timer(Duration(seconds: 2), () {
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
          return Navigator.of(context)
              .pushReplacementNamed("/Pages", arguments: 2);
        }
        if (state is AuthenticationNotAuthenticated) {
          print("no auth splash go to login");
          return Navigator.of(context).pushReplacementNamed("/Login");
        }
      },
      builder: (context, state) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        child: LoadingIndicator(
          loadingText: "Authentification",
        ),
      ),
    );
  }
}
