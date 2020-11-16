import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NavigatorAction extends Equatable{

}
class NavigatorActionPop extends NavigatorAction{
  @override
  // TODO: implement props
  List<Object> get props => null;
}
class NavigatorActionPushNamed extends NavigatorAction{
  final String routeName;

  NavigatorActionPushNamed({this.routeName});
  @override
  // TODO: implement props
  List<Object> get props => [routeName];
}

class NavigatorBloc extends Bloc<NavigatorAction, dynamic>{

  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorBloc({this.navigatorKey}) : super(null);

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigatorAction event) async* {
    if(event is NavigatorActionPop){
      navigatorKey.currentState.pop();

    }else if(event is NavigatorActionPushNamed){
      print(event.routeName);
      navigatorKey.currentState.pushNamed(event.routeName);

    }
  }
}