import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla_flutter/config/app_config.dart' as config;
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/auth/auth.state.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/signup/bloc/signup_bloc.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/signup/bloc/signup_event.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/signup/bloc/signup_state.dart';
import 'package:dmakla_flutter/src/business_logic/utils/constants/wilaya.dart';
import 'package:dmakla_flutter/src/views/elements/BlockButtonWidget.dart';
import 'package:dmakla_flutter/src/views/elements/common/loading.dart';

class SignUpWidget extends StatefulWidget {

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {




  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc,AuthenticationState>(
      listener: (context,state){
        if(state is AuthenticationAuthenticated) {
          print("authenticated from signup");
          Timer(Duration(seconds: 1),(){
            Navigator.of(context).pushReplacementNamed("/Pages",arguments: 2);
          });
        }
      },
      child: BlocProvider<SignUpBloc>(
        create: (context)=> SignUpBloc(BlocProvider.of<AuthenticationBloc>(context)),
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
                      height: config.App(context).appHeight(29.5),
                      decoration: BoxDecoration(image: DecorationImage(
                        image: AssetImage('img/food3.jpg'),
                        fit: BoxFit.cover
                      )),
                    ),
                  ),
                  BlocBuilder<SignUpBloc,SignUpState>(
                    builder: (context,state) {
                      if(state is SigningUpState) {
                        return Center(child: LoadingIndicator(loadingText: "Signing you up"));
                      }
                      if(state is SignUpServerErrorState)
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.message,
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
                                    BlocProvider.of<SignUpBloc>(context).add(RetryEvent());
                                  },
                                ),
                              ),

                            ],
                          ),
                        );
                      if (state is SignedUpState) {
                        return Center(
                          child: Text(
                            'Welcome to D-makla ${state.user.fullName}',
                            style: Theme.of(context).textTheme.bodyText1.merge(
                                TextStyle(color: Theme.of(context).accentColor)),
                          ),
                        );
                      }
                      return Positioned(
                          top: config.App(context).appHeight(29.5) - 80,
                          child: SignUpForm());
                    },
                  ),
                  // BlocListener<SignUpBloc,SignUpState>(
                  //   listener: (context,state) {
                  //     if(state is SignedUpState) {
                  //       SchedulerBinding.instance
                  //           .addPostFrameCallback((timeStamp) {
                  //         Future.delayed(Duration(seconds: 1),(){
                  //           Navigator.of(context).pushNamed('/Pages', arguments: 2);
                  //         });
                  //
                  //       });
                  //     }
                  //   },
                  //   child: Container(height: 0, width: 0,),
                  // ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool showPassword;
  String _selectedWilaya;
  String _userFullName;
  String _selectedCountryCode;
  String _mobileNumber;
  String _password;
  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _passwordController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showPassword = false;
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _resetValues();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }
  void _resetValues(){
    showPassword = false;
    _selectedWilaya =DEFAULT_WILAYA_DROPDOWN;
    _userFullName = '';
    _selectedCountryCode = '';
    _mobileNumber = '';
    _password = '';


  }
  void _clearFields(){
    _nameController.clear();
    _passwordController.clear();
    _phoneController.clear();
  }
  void dispatchSignup(){
    print(_userFullName);
    print(_mobileNumber);
    print(_password);
    BlocProvider.of<SignUpBloc>(context).add(StartSignUpEvent(fullName: _userFullName, phoneNumber: _mobileNumber, countryCode: _selectedCountryCode, wilaya: _selectedWilaya, password: _password));

  }
  void _togglePassword(){
    this.setState(() {
      showPassword = !showPassword;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: BlocBuilder<SignUpBloc,SignUpState>(
        builder:(context,state)=> Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              child: Text(
                'Signup to D-makla!',
                style: Theme.of(context).textTheme.display3.merge(TextStyle(color: Theme.of(context).accentColor)),
              ),
            ),
            TextField(
              controller: _nameController ,
              keyboardType: TextInputType.name,
              onChanged: (value){
                this.setState(() {
                  _userFullName = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Full Name",
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                errorText: (state is SignUpInputValidationErrorState) ? state.fullNameError : null,
                contentPadding: EdgeInsets.all(12),
                hintText: 'Miral Mia',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
                value: _selectedWilaya,
                isExpanded: true,
                iconSize: 24,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                ),
                elevation: 16,
                style: TextStyle(color: Theme.of(context).accentColor),
                onChanged: (String newValue) {
                  setState(() {
                    _selectedWilaya = newValue;
                  });
                },
                items: WILAYA_MAP.values.toList()
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700),),
                  );
                }).toList()),
            SizedBox(height: 30),
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 1,
            //       child: CountryCodePicker(
            //         textStyle: TextStyle(color: Theme.of(context).accentColor),
            //         onChanged: (code) {
            //           _selectedCountryCode = code.dialCode;
            //         },
            //         // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
            //         initialSelection: 'DZ',
            //         favorite: ['+213', 'DZ'],
            //         showFlagDialog: false,
            //         comparator: (a, b) => b.name.compareTo(a.name),
            //       ),
            //     ),
            //     Expanded(
            //       flex: 3,
            //       child: TextField(
            //         controller: _phoneController,
            //         keyboardType: TextInputType.phone,
            //         onChanged: (value){
            //           this.setState(() {
            //             _mobileNumber = value;
            //           });
            //         },
            //         decoration: InputDecoration(
            //           labelText: "Mobile No.",
            //           labelStyle: TextStyle(color: Theme.of(context).accentColor),
            //           errorText: (state is SignUpInputValidationErrorState) ? state.phoneNumberError : null,
            //           contentPadding: EdgeInsets.all(12),
            //           hintText: '123456789',
            //           hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
            //           prefixIcon: Icon(Icons.phone, color: Theme.of(context).accentColor),
            //           border: OutlineInputBorder(
            //               borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
            //           focusedBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
            //           enabledBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
            //         ),
            //       ),)
            //   ],
            // ),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              onChanged: (value){
                this.setState(() {
                  _mobileNumber = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Mobile No.",
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                errorText: (state is SignUpInputValidationErrorState) ? state.phoneNumberError : null,
                contentPadding: EdgeInsets.all(12),
                hintText: '0123456789',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon: Icon(Icons.phone, color: Theme.of(context).accentColor),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              keyboardType: TextInputType.text,
              controller: _passwordController,
              obscureText: !showPassword,
              onChanged: (value){
                this.setState(() {
                  _password = value;
                });
              },
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                errorText: (state is SignUpInputValidationErrorState) ? state.passwordError : null,
                contentPadding: EdgeInsets.all(12),
                hintText: '••••••••••••',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                suffixIcon: IconButton(icon: Icon(Icons.remove_red_eye, color: Theme.of(context).focusColor), onPressed: _togglePassword,),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
            SizedBox(height: 30),
            BlockButtonWidget(
              text: Text(
                'Sign up',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              color: Theme.of(context).accentColor,
              onPressed: dispatchSignup,
            ),
            SizedBox(height: 10),
            FlatButton(
              onPressed: () {
                if(Navigator.canPop(context)) Navigator.of(context).pop();
                else Navigator.of(context).pushNamed('/Login');
              },
              textColor: Theme.of(context).hintColor,
              child: Text('I have account? Back to login'),
            ),
          ],
        ),
      ),
    );
  }
}
