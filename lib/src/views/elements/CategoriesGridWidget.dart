import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/store.cubit.dart';
import 'CategoriesGridtemWidget.dart';
import 'common/loading.dart';
import 'package:restaurant_rlutter_ui/src/features/Menu/categories/bloc/categories_cubit.dart';
import 'package:restaurant_rlutter_ui/src/models/category.dart';

class CategoriesGridWidget extends StatelessWidget {
  CategoriesList _categoriesList = new CategoriesList();

  CategoriesGridWidget({
    Key key,
  }) : super(key: key);

  List<Widget> _buildCategories() {
    return _categoriesList.categoriesList
        .map((category) => CategoriesGridItemWidget(
              category: category,
            ))
        .toList();
  }

  Widget _buildCategoriesGrid(StoreState state) {
    if (state is StoreLoadingState) {
      return LoadingIndicator(loadingText: "loading categories");
    }
    if (state is StoreLoadedState) {
      _categoriesList.categoriesList = state.store.categories;
      return GridView.builder(
        physics: ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
        ),
        itemCount: _categoriesList.categoriesList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          double _marginLeft = 0;
          (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
          return new CategoriesGridItemWidget(
            category: _categoriesList.categoriesList.elementAt(index),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {
          print(state);
          if (state is StoreLoadedState) {
            print(state.store.categories);
          }
        },
        builder: (context, state) => Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: _buildCategoriesGrid(state),
            ));
  }
}
