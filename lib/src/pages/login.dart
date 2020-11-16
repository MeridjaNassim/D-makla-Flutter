import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/config/app_config.dart' as config;
import 'package:restaurant_rlutter_ui/src/elements/BlockButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/features/Auth/login/bloc/login_bloc.dart';
import 'package:restaurant_rlutter_ui/src/features/Auth/login/bloc/login_event.dart';
import 'package:restaurant_rlutter_ui/src/features/Auth/login/bloc/login_state.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool showPassword;
  TextEditingController _phoneController;
  TextEditingController _passwordController;
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

  void _clearFields() {
    _phoneController.clear();
    _passwordController.clear();
  }

  void _resetValues() {
    _password = '';
    _phoneNumber = '';
  }

  void _dispatchLogin(BuildContext context) {

    BlocProvider.of<LoginBloc>(context)
        .add(StartLoginEvent(phoneNumber: _phoneNumber, password: _password));

    /// send login
    _clearFields();
    this.setState(_resetValues);
  }

  void _togglePassword() {
    this.setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
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
                Positioned(
                  top: config.App(context).appHeight(37) - 50,
                  child: Container(
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
                    child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                      if (state is LoggingInState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'logging in',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .merge(TextStyle(
                                        color: Theme.of(context).accentColor)),
                              ),
                            ),
                          ],
                        );
                      }
                      if (state is IdleState) {
                        return Column(
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
                                    .merge(TextStyle(
                                        color: Theme.of(context).accentColor)),
                              ),
                            ),
                            TextField(
                              onChanged: (value){
                                _phoneNumber = value;
                              },
                              keyboardType: TextInputType.phone,
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: "Mobile No.",
                                labelStyle: TextStyle(
                                    color: Theme.of(context).accentColor),
                                contentPadding: EdgeInsets.all(12),
                                hintText: '+213123456789',
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7)),
                                prefixIcon: Icon(Icons.phone,
                                    color: Theme.of(context).accentColor),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
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
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    color: Theme.of(context).accentColor),
                                contentPadding: EdgeInsets.all(12),
                                hintText: '••••••••••••',
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.7)),
                                prefixIcon: Icon(Icons.lock_outline,
                                    color: Theme.of(context).accentColor),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye,
                                      color: Theme.of(context).focusColor),
                                  onPressed: _togglePassword,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.2))),
                              ),
                            ),
                            SizedBox(height: 30),
                            BlockButtonWidget(
                              text: Text(
                                'Login',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              color: Theme.of(context).accentColor,
                              onPressed:() {
                                _dispatchLogin(context);
                              },
                            ),
                            SizedBox(height: 25),
                          ],
                        );
                      }
                      return SizedBox();
                    }),
                  ),
                ),
                BlocListener<LoginBloc,LoginState>(
                    listener: (context,state){
                    if(state is LoggedInState){
                      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                        Navigator.of(context).pushNamed('/Pages', arguments:  2);
                      });
                      return Container(height: 0, width: 0,);
                    }
                  },
                  child: Container(height: 0,width: 0,),
                ),
                Positioned(
                  bottom: 10,
                  child: Column(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/SignUp');
                        },
                        textColor: Theme.of(context).hintColor,
                        child: Text('I don\'t have an account?'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
