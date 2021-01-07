import 'package:bloc/bloc.dart';
import 'package:dmakla_flutter/src/views/constants/navigation.dart';
import 'package:equatable/equatable.dart';

class TabNavigationState extends Equatable{
  final int tabIndex;
  final bool inTabPage;
  TabNavigationState(this.tabIndex,this.inTabPage);

  @override
  // TODO: implement props
  List<Object> get props => [tabIndex,inTabPage];
  
}

class TabNavigationCubit extends Cubit<TabNavigationState> {
  TabNavigationCubit() : super(TabNavigationState(HOME_TAB_INDEX,true));

  void setTabIndex(int index,{bool inTabPage}) {
    if(index == PROFILE_TAB_INDEX ) emit(TabNavigationState(PROFILE_TAB_INDEX,inTabPage ?? state.inTabPage));
    if(index == HOME_TAB_INDEX ) emit(TabNavigationState(HOME_TAB_INDEX,inTabPage ?? state.inTabPage));
    if(index == ORDERS_TAB_INDEX ) emit(TabNavigationState(ORDERS_TAB_INDEX,inTabPage ?? state.inTabPage));
  }
  void setInTabPage(bool isInTab) {
    emit(TabNavigationState(state.tabIndex, isInTab));
  }
}

