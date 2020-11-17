import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SignUpEvent extends Equatable{

}

class StartSignUpEvent extends SignUpEvent{
  final String fullName;
  final String phoneNumber;
  final String countryCode;
  final String wilaya;
  final String password;

  StartSignUpEvent( {@required this.fullName,
    @required this.phoneNumber,
    @required this.countryCode,
    @required this.wilaya,
    @required this.password});

  @override
  List<Object> get props {
    return [phoneNumber,password];
  }
}
class RetryEvent extends SignUpEvent{


  RetryEvent();

  @override
  List<Object> get props {
    return null;
  }
}

