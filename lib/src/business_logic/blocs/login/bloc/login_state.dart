import 'package:equatable/equatable.dart';
import 'package:dmakla_flutter/src/business_logic/models/user.dart';


abstract class LoginState extends Equatable{

}

class IdleState extends LoginState{

  @override
  List<Object> get props {
    return null;
  }
}
class LoggingInState extends LoginState{

  @override
  List<Object> get props {
    return null;
  }
}
class LoggedInState extends LoginState{
  final User user;

  LoggedInState({this.user});

  @override
  List<Object> get props {
    return null;
  }
}

//region ErrorStates
abstract class LoginErrorState extends LoginState{
}
class LoginInputValidationErrorState extends LoginErrorState{
  final String phoneNumberError;
  final String passwordError;

  LoginInputValidationErrorState({this.phoneNumberError, this.passwordError});

  @override
  List<Object> get props {
    return [phoneNumberError,passwordError];
  }
}
class LoginServerErrorState extends LoginErrorState{
  final String message;

  LoginServerErrorState({this.message});

  @override
  List<Object> get props {
    return [message];
  }
}
//endregion

