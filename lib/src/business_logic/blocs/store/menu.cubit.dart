import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/menu.dart';

abstract class MenuState extends Equatable {

}

class InitialMenuState extends MenuState {

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class MenuSelectedState extends MenuState {

  final Menu menu;

  MenuSelectedState(this.menu);

  @override
  // TODO: implement props
  List<Object> get props => [menu];
}
class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(InitialMenuState());

  void setCurrentMenu(Menu menu) {
    emit(MenuSelectedState(menu));
  }


}