import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/config/app_config.dart' as config;
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/login/bloc/login_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/login/bloc/login_event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/login/bloc/login_state.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/BlockButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/common/loading.dart';

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _phoneNumber;
  String _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPassword = false;
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _resetValues();
  }

  void _resetValues() {
    _password = '';
    _phoneNumber = '';
  }


  bool showPassword;
  TextEditingController _phoneController;
  TextEditingController _passwordController;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  void _togglePassword() {
    this.setState(() {
      showPassword = !showPassword;
    });
  }

  void _clearFields() {
    _phoneController.clear();
    _passwordController.clear();
  }
  void _dispatchLogin() {
    print('phone: '+_phoneNumber);
    print('password: '+_password);
    BlocProvider.of<LoginBloc>(context)
        .add(StartLoginEvent(phoneNumber: _phoneNumber, password: _password));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(
      builder:(context,state)=> Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                blurRadius: 50,
                color: Theme.of(context).hintColor.withOpacity(0.2),
              )
            ]),
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
        width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Text(
                'Login to D-makla!',
                style: Theme.of(context)
                    .textTheme
                    .display3
                    .merge(TextStyle(color: Theme.of(context).accentColor)),
              ),
            ),
            TextField(
              onChanged: (value) {
                _phoneNumber = value;
              },
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Mobile No.",
                errorText: state is LoginInputValidationErrorState? state.phoneNumberError :null,
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: '0123456789',
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon:
                    Icon(Icons.phone, color: Theme.of(context).accentColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              onChanged: (value){
                _password = value;
              },
              keyboardType: TextInputType.text,
              obscureText: !showPassword,
              controller: _passwordController,
              decoration: InputDecoration(
                errorText: state is LoginInputValidationErrorState? state.passwordError :null,
                labelText: "Password",
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                contentPadding: EdgeInsets.all(12),
                hintText: '••••••••••••',
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon: Icon(Icons.lock_outline,
                    color: Theme.of(context).accentColor),
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye,
                      color: Theme.of(context).focusColor),
                  onPressed: _togglePassword,
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            BlockButtonWidget(
              text: Text(
                'Login',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              color: Theme.of(context).accentColor,
              onPressed: _dispatchLogin,
            ),
            SizedBox(height: 25),
            BlocListener<LoginBloc,LoginState>(
                listener: (context,state){
              if(state is LoggedInState){
                _clearFields();
              }
            },
            child: Container()
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/SignUp');
              },
              textColor: Theme.of(context).hintColor,
              child: Text('I don\'t have an account?'),
            ),
          ],
        ),
      ),
    );
  }
}

class InputError extends StatelessWidget {
  final String errorMessage;

  InputError({@required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.errorMessage,
      style: TextStyle(
          color: Theme.of(context).accentColor, fontWeight: FontWeight.w600),
    );
  }
}





class LoginWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc,AuthenticationState>(
      listener: (context,state){
        if(state is AuthenticationAuthenticated) {
          print("authenticated");
          Navigator.of(context).pushReplacementNamed("/Pages",arguments: 2);
        }
      },
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(BlocProvider.of<AuthenticationBloc>(context)),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    child: Container(
                      width: config.App(context).appWidth(100),
                      height: config.App(context).appHeight(37),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('img/food2.jpg'),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                    if (state is LoggingInState) {
                      return Center(
                        child: LoadingIndicator(
                          loadingText: 'logging in ...',
                        ),
                      );
                    }
                    if(state is LoginServerErrorState)
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message ?? "Could not login",
                              style: Theme.of(context).textTheme.bodyText1.merge(
                                  TextStyle(color: Theme.of(context).accentColor)),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: BlockButtonWidget(
                                text: Text(
                                  'Try again',
                                  style: TextStyle(color: Theme.of(context).primaryColor),
                                ),
                                color: Theme.of(context).accentColor,
                                onPressed: (){
                                  BlocProvider.of<LoginBloc>(context).add(RetryEvent());
                                },
                              ),
                            ),

                          ],
                        ),
                      );
                    if (state is LoggedInState) {
                      return Center(
                        child: Text(
                          'Welcome to D-makla ${state.user.fullName}',
                          style: Theme.of(context).textTheme.bodyText1.merge(
                              TextStyle(color: Theme.of(context).accentColor)),
                        ),
                      );
                    }
                    return Positioned(
                        top: config.App(context).appHeight(37) - 50,
                        child: LoginForm());
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
