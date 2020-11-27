import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';

abstract class CategoryState extends Equatable {

}

class InitialCategoryState extends CategoryState {

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class CategorySelectedState extends InitialCategoryState {

  final Category category;

  CategorySelectedState(this.category);

  @override
  // TODO: implement props
  List<Object> get props => [category];
}
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(InitialCategoryState());

  void setCurrentCategory(Category category) {
    emit(CategorySelectedState(category));
  }


}