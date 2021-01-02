import 'package:bloc/bloc.dart';
import 'package:dmakla_flutter/src/views/constants/navigation.dart';
import 'package:equatable/equatable.dart';

class TabNavigationState extends Equatable{
  final int tabIndex;

  TabNavigationState(this.tabIndex);

  @override
  // TODO: implement props
  List<Object> get props => [tabIndex];
  
}

class TabNavigationCubit extends Cubit<TabNavigationState> {
  TabNavigationCubit() : super(TabNavigationState(HOME_TAB_INDEX));

  void setTabIndex(int index) {
    if(index == PROFILE_TAB_INDEX ) emit(TabNavigationState(PROFILE_TAB_INDEX));
    if(index == HOME_TAB_INDEX ) emit(TabNavigationState(HOME_TAB_INDEX));
    if(index == ORDERS_TAB_INDEX ) emit(TabNavigationState(ORDERS_TAB_INDEX));
  }
}

