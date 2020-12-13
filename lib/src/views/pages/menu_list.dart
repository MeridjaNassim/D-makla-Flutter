import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/menu.cubit.dart';


import 'package:restaurant_rlutter_ui/src/views/elements/DrawerWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/FoodsCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/MenuItemWidget.dart';

import 'package:restaurant_rlutter_ui/src/views/elements/ShoppingCartButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/common/loading.dart';

class MenuWidget extends StatelessWidget {

  String _getTitleText(MenuState state) {
    if (state is MenuStateLoading) return "loading";
    if (state is MenuByCategoryStateReady) return "Categorie: "+ state.category.name;
    if (state is MenuByRestaurantStateReady) return "Restaurant: " + state.restaurant.name;
    if (state is MenuByRestaurantCategoryState) return state.category.name + " by " + state.restaurant.name;
    return "menu";
  }
  Widget _buildAllMenus(BuildContext context, MenuState state) {
    if(!(state is MenuReadyState)) return Container();
    final _state = state as MenuReadyState;
    if(_state.allMenus.isNotEmpty) {
      return Column(
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.list,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'All Menu',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            primary: false,
            itemCount: _state.allMenus.length,
            separatorBuilder: (context, index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              return MenuItemWidget(
                heroTag: 'menu_list',
                menu: _state.allMenus[index],
              );
            },
          ),
        ],
      );
    }else {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'No menus',
              style: Theme.of(context).textTheme.body2,
            ),
          ),
        ],
      );
    }
  }
  Widget _buildMenus(BuildContext context, MenuState state) {
    if (state is MenuStateLoading) {
      return Center(
        child: LoadingIndicator(
          loadingText: state.loadingMessage,
        ),
      );
    }
    Widget _buildTendences(MenuState state) {
      if(state is MenuReadyState) {
        final trending = state.trendingMenus;
        if(trending.isEmpty) return Container();
        return Column(
          children: [
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              leading: Icon(
                Icons.trending_up,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                'Menus tendence',
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            FoodsCarouselWidget(
              menus: trending,
            ),
          ],
        );
      }
      return Center(
        child: LoadingIndicator(
          loadingText: "loading trending",
        ),
      );
    }
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                hintText: 'Search',
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.7)),
                prefixIcon:
                    Icon(Icons.search, color: Theme.of(context).accentColor),
                suffixIcon: Icon(Icons.mic_none,
                    color: Theme.of(context).focusColor.withOpacity(0.7)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.2))),
              ),
            ),
          ),
          _buildTendences(state),
          _buildAllMenus(context,state),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: BlocBuilder<MenuCubit, MenuState>(builder: (context, state) {
          return Text(
            _getTitleText(state),
            style: Theme.of(context)
                .textTheme
                .title
                .merge(TextStyle(letterSpacing: 0)),
          );
        }),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor,
              labelColor: Theme.of(context).accentColor),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: BlocBuilder<MenuCubit, MenuState>(builder: _buildMenus),
    );
  }
}
