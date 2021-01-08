import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla/src/business_logic/blocs/store/menu.cubit.dart';
import 'package:dmakla/src/business_logic/blocs/store/store.cubit.dart';
import 'CategoriesGridtemWidget.dart';
import 'common/loading.dart';
import 'package:dmakla/src/models/category.dart';

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
      final categories= state.store.categories;
      return GridView.builder(
        physics: ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
        ),
        itemCount: categories.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          double _marginLeft = 0;
          (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
          final category = categories[index];
          return InkWell(
            splashColor: Theme.of(context).accentColor.withOpacity(0.08),
            highlightColor: Colors.transparent,
            onTap: () {
              BlocProvider.of<MenuCubit>(context).setMenusByCategory(category);
              Navigator.of(context).pushNamed('/Menu');
            },
            child: new CategoriesGridItemWidget(
              category: category,
            ),
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
