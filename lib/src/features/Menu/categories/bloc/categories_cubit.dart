import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';

class CategoriesCubit extends Cubit<CategoryState> {


  CategoriesCubit() : super(CategoryInitial());


  /// loads all categories from the api
  void loadCategories() {
    emit(CategoryLoading());
    ///TODO do the loading of the categories
    emit(CategoryLoaded([]));
  }
  /// sets the current categories
  void setCategories(List<Category> categories) {
    emit(CategoryLoading());
    print("setting cubit data");
    emit(CategoryLoaded(categories));
  }
  void unsetCategories() {
    emit(CategoryLoading());
    emit(CategoryLoaded([]));
  }
}


abstract class CategoryState extends Equatable{
  final String name;

  CategoryState(this.name);
}

class CategoryInitial extends CategoryState{
  CategoryInitial() : super("initial");
  @override
  // TODO: implement props
  List<Object> get props => [super.name];


}
class CategoryLoading extends CategoryState{
  CategoryLoading() : super("loading");
  @override
  // TODO: implement props
  List<Object> get props => [super.name];

}
class CategoryLoaded extends CategoryState{

  final List<Category> categories;

  CategoryLoaded(this.categories) : super("loaded");

  @override
  // TODO: implement props
  List<Object> get props => [categories,super.name];

}