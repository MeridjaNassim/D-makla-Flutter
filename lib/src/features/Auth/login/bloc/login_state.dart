import 'package:equatable/equatable.dart';

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

