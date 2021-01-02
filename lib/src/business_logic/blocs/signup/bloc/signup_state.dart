import 'package:equatable/equatable.dart';
import 'package:dmakla_flutter/src/business_logic/models/user.dart';

abstract class SignUpState extends Equatable{

}

class IdleState extends SignUpState{

  @override
  List<Object> get props {
    return null;
  }
}
class SigningUpState extends SignUpState{

  @override
  List<Object> get props {
    return null;
  }
}
class SignedUpState extends SignUpState{
  final User user;

  SignedUpState({this.user});

  @override
  List<Object> get props {
    return null;
  }
}

//region ErrorStates
abstract class SignUpErrorState extends SignUpState{

}
class SignUpInputValidationErrorState extends SignUpErrorState{
  final String phoneNumberError;
  final String passwordError;
  final String fullNameError;
  SignUpInputValidationErrorState({this.phoneNumberError, this.passwordError, this.fullNameError});

  @override
  List<Object> get props {
    return [phoneNumberError,passwordError];
  }
}
class SignUpServerErrorState extends SignUpErrorState{
  final String message;

  SignUpServerErrorState({this.message});

  @override
  List<Object> get props {
    return [message];
  }
}
//endregion

