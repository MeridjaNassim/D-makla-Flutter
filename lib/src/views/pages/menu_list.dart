import 'package:dmakla_flutter/src/views/elements/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_refresh_indicator/lazy_load_refresh_indicator.dart';

import 'package:dmakla_flutter/src/business_logic/blocs/store/menu.cubit.dart';
import 'package:dmakla_flutter/src/business_logic/models/menu.dart';

import 'package:dmakla_flutter/src/views/elements/DrawerWidget.dart';
import 'package:dmakla_flutter/src/views/elements/FoodsCarouselWidget.dart';
import 'package:dmakla_flutter/src/views/elements/MenuItemWidget.dart';
import 'package:octo_image/octo_image.dart';
import 'package:dmakla_flutter/src/views/elements/ShoppingCartButtonWidget.dart';
import 'package:dmakla_flutter/src/views/elements/common/loading.dart';
// class MenuListWidget extends StatefulWidget {
//   final List<Menu> menus;
//
//   MenuListWidget(this.menus);
//
//   @override
//   _MenuListWidgetState createState() => _MenuListWidgetState();
// }
//
// class _MenuListWidgetState extends State<MenuListWidget> {
//   int displayCount = 10;
//   bool isLoading = false;
//   ScrollController _controller = new ScrollController();
//   @override
//   void initState() {
//     super.initState();
//     displayCount = min(displayCount, widget.menus.length);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//
//   Future<bool> _onRefresh() async{
//     print("refreshing");
//     setState(() {
//       isLoading = false;
//     });
//     return true;
//   }
//   Future<void> _onEndOfPage() async{
//     print("showing more items");
//     setState(()=> isLoading = true);
//
//     await Future.delayed(Duration(seconds: 2),(){});
//     setState((){
//       isLoading = false;
//       displayCount = min(displayCount+10, widget.menus.length);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return LazyLoadRefreshIndicator(
//       isLoading: isLoading,
//       onEndOfPage: _onEndOfPage,
//       onRefresh: _onRefresh,
//       child: ListView.separated(
//         shrinkWrap: true,
//         physics: ClampingScrollPhysics(),
//         scrollDirection: Axis.vertical,
//         itemCount: displayCount,
//         separatorBuilder: (context,index) => SizedBox(height: 5,),
//         itemBuilder: (context, index) {
//           return MenuItemWidget(
//             heroTag: 'menu_list',
//             menu: widget.menus[index],
//           );
//         },
//       ),
//     );
//   }
// }

class MenuWidget extends StatelessWidget {
  String _getTitleText(MenuState state) {
    if (state is MenuStateLoading) return "loading";
    if (state is MenuByCategoryStateReady)
      return "Categorie: " + state.category.name;
    if (state is MenuByRestaurantStateReady)
      return "Restaurant: " + state.restaurant.name;
    if (state is MenuByRestaurantCategoryState)
      return state.category.name + " by " + state.restaurant.name;
    return "menu";
  }

  Widget _buildAllMenus(BuildContext context, MenuState state) {
    if (!(state is MenuReadyState)) return Container();
    final _state = state as MenuReadyState;
    if (_state.allMenus.isNotEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: Icon(
              Icons.fastfood_rounded,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Tous les Menus',
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
    } else {
      return Container(
        height: MediaQuery.of(context).size.height -
            Scaffold.of(context).appBarMaxHeight -
            160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 160,
                width: 160,
                child: OctoImage(
                    fit: BoxFit.cover, image: FAILED_TO_LOAD_FOOD_IMAGE)),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'Pas de menus disponible pour le moment',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.body2,
            ))
          ],
        ),
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
      if (state is MenuReadyState) {
        final trending = state.trendingMenus;
        if (trending.isEmpty) return Container();
        return Column(
          children: [
            ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

    return RefreshIndicator(
      onRefresh: () {
        return _refreshList(context, state);
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       contentPadding: EdgeInsets.all(12),
            //       hintText: 'Search',
            //       hintStyle: TextStyle(
            //           color: Theme.of(context).focusColor.withOpacity(0.7)),
            //       prefixIcon:
            //           Icon(Icons.search, color: Theme.of(context).accentColor),
            //       suffixIcon: Icon(Icons.mic_none,
            //           color: Theme.of(context).focusColor.withOpacity(0.7)),
            //       border: OutlineInputBorder(
            //           borderSide: BorderSide(
            //               color: Theme.of(context).focusColor.withOpacity(0.2))),
            //       focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(
            //               color: Theme.of(context).focusColor.withOpacity(0.5))),
            //       enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(
            //               color: Theme.of(context).focusColor.withOpacity(0.2))),
            //     ),
            //   ),
            // ),
            _buildTendences(state),
            _buildAllMenus(context, state),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }

  Future<void> _refreshList(BuildContext context, MenuReadyState state) {
    print("refreshing menus ... ");
    if (state is MenuByRestaurantStateReady)
      return BlocProvider.of<MenuCubit>(context)
          .setMenusByRestaurant(state.restaurant);
    if (state is MenuByRestaurantCategoryState)
      return BlocProvider.of<MenuCubit>(context)
          .setMenusByRestaurantCategory(state.restaurant, state.category);
    if (state is MenuByCategoryStateReady)
      return BlocProvider.of<MenuCubit>(context)
          .setMenusByCategory(state.category);
  }
}
