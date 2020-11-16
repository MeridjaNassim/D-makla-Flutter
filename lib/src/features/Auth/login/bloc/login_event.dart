import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{

}

class StartLoginEvent extends LoginEvent{
  final String phoneNumber;
  final String password;


  StartLoginEvent({this.phoneNumber, this.password});

  @override
  List<Object> get props {
    return [phoneNumber,password];
  }
}
class RetryEvent extends LoginEvent{


  RetryEvent();

  @override
  List<Object> get props {
    return null;
  }
}

