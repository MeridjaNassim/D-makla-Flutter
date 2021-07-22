import 'package:equatable/equatable.dart';

abstract class Validation extends Equatable{
  bool hasError();
}
abstract class LoginValidation extends Validation{

}
abstract class SignUpValidation extends Validation {

}
class LoginWithPhoneNumberValidation extends LoginValidation {
  final String phoneNumberError;
  final String passwordError;

  LoginWithPhoneNumberValidation({this.phoneNumberError, this.passwordError});

  @override
  List<Object> get props {
    return [phoneNumberError,passwordError];
  }
  bool hasError(){
    return phoneNumberError != null || passwordError != null;
  }
}
class SignUpWithPhoneNumberValidation extends LoginValidation {
  final String phoneNumberError;
  final String passwordError;
  final String fullNameError;
  SignUpWithPhoneNumberValidation({this.phoneNumberError, this.passwordError,this.fullNameError});

  @override
  List<Object> get props {
    return [phoneNumberError,passwordError,fullNameError];
  }
  @override
  bool hasError() {

      return phoneNumberError != null || passwordError != null || fullNameError != null;

  }
}


LoginWithPhoneNumberValidation validateLoginWithPhoneCredentials({String phoneNumber,String password}) {
  String phoneNumberError;
  String passwordError;
  if (phoneNumber.isEmpty) phoneNumberError = 'phone number must not be empty';
  if (password.isEmpty) passwordError = 'password must not be empty';

  return LoginWithPhoneNumberValidation(
      phoneNumberError: phoneNumberError, passwordError: passwordError);
}

SignUpWithPhoneNumberValidation validateSignupWithPhone({String phoneNumber,String password,String fullName}) {
  String phoneNumberError;
  String passwordError;
  String fullNameError;
  if (phoneNumber.isEmpty)
    phoneNumberError = 'phone number must not be empty';
  else {
    bool valideAlgerianMobile = validateMobile(phoneNumber);
    if(!valideAlgerianMobile)
      phoneNumberError = 'phone number must be Algerian(+213)';
  }
  if (password.isEmpty) passwordError = 'password must not be empty';
  if (fullName.isEmpty) fullNameError = 'full name must not be empty';

  return SignUpWithPhoneNumberValidation(
      phoneNumberError: phoneNumberError, passwordError: passwordError,fullNameError: fullNameError);
}

bool validateMobile(String value) {
  String pattern = r'^(?:[+0]213)?[0-9]{8,12}$';
  RegExp regExp = new RegExp(pattern);

  return regExp.hasMatch(value);
}