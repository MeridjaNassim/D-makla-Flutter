import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'CategoriesCarouselItemWidget.dart';
import 'common/loading.dart';
import 'package:restaurant_rlutter_ui/src/features/Menu/categories/bloc/categories_cubit.dart';
import 'package:restaurant_rlutter_ui/src/models/category.dart';

class CategoriesCarouselWidget extends StatelessWidget {
  CategoriesList _categoriesList = new CategoriesList();

  CategoriesCarouselWidget({
    Key key,
  }) : super(key: key);

  Widget BuildListCategories(CategoryState state) {
    if(state is CategoryLoading) {
      return LoadingIndicator(loadingText: "loading categories");
    }
    if (state is CategoryLoaded) {
      _categoriesList.categoriesList = state.categories;
      return ListView.builder(
        itemCount: _categoriesList.categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          double _marginLeft = 0;
          (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
          return new CategoriesCarouselItemWidget(
            marginLeft: _marginLeft,
            category: _categoriesList.categoriesList.elementAt(index),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoryState>(
        listener: (context, state) {
          print(state.name);
          if (state is CategoryLoaded) {
            print(state.categories);
          }
        },
        builder: (context, state) => Container(
              height: 150,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: BuildListCategories(state),
            ));
  }
}
