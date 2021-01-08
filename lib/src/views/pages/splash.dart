import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dmakla/src/views/elements/common/loading.dart';
import 'package:dmakla/src/views/utils/connectivity_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.event.dart';
import 'package:dmakla/src/business_logic/blocs/auth/auth.state.dart';

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
    bool canUse = await tryUseApplication();
    if (!canUse) {
      _showNoInternetDialog();
    }
  }

  Future<bool> tryUseApplication() async {
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      BlocProvider.of<AuthenticationBloc>(context).add(AppLoaded());
      return true;
    } else {
      return false;
    }
  }

  void _showNoInternetDialog() {
    // dialog implementation
    showConnectivityWidget(context, () {
      Navigator.of(context).pop();
      start();
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
