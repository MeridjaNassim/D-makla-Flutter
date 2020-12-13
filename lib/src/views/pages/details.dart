import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/menu.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/restaurant.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/store/store.cubit.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/models/order.dart';
import 'package:restaurant_rlutter_ui/src/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/models/route_argument.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/CategoriesGridtemWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/GalleryCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/OrderItemWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/ReviewsListWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/ShoppingCartFloatButtonWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/common/loading.dart';
import 'package:restaurant_rlutter_ui/src/views/utils/image_handling.dart';

class DetailsWidget extends StatefulWidget {
  DetailsWidget({Key key}) : super(key: key);

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends State<DetailsWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          /// Getting the current restaurant
          final state = BlocProvider.of<RestaurantCubit>(context).state;
          final restaurant = (state as RestaurantSelectedState).restaurant;
          BlocProvider.of<MenuCubit>(context).setMenusByRestaurant(restaurant);
          Navigator.of(context).pushNamed('/Menu');
        },
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        icon: Icon(Icons.restaurant),
        label: Text('All Menu'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor:
                Theme.of(context).primaryColor,
                expandedHeight: 300,
                elevation: 0,
                iconTheme:
                IconThemeData(color: Theme.of(context).primaryColor),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: BlocBuilder<RestaurantCubit, RestaurantState>(
                      builder: (context, state) {
                        final _restaurant =
                            state.restaurant;
                        return Hero(
                          tag: "restaurant"+_restaurant.id,
                          child: _restaurant.image == null
                              ? null
                              : Image(
                            image: getImageProvider(_restaurant.image),
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),
              ),
              SliverToBoxAdapter(
                child: Wrap(
//              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child:
                            BlocBuilder<RestaurantCubit, RestaurantState>(
                              builder: (context, state) => Text(
                                state
                                    .restaurant
                                    .name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.display2,
                              ),
                            ),
                          ),
                          BlocBuilder<RestaurantCubit, RestaurantState>(
                              builder: (context, state) {
                                final rating = state
                                    .restaurant
                                    .rating;
                                if (rating == null) return SizedBox();
                                return SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(rating.score.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .body2
                                                .merge(TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor))),
                                        Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColor,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.9),
                                    shape: StadiumBorder(),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: BlocBuilder<RestaurantCubit, RestaurantState>(
                          builder: (context, state) {
                            if (state is RestaurantSelectedState) {
                              return Text(state.restaurant?.description ??
                                  "no description");
                            }
                            return Text("Description du restaurant");
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.stars,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Choisir par Catégorie',
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      child: BlocBuilder<RestaurantCubit, RestaurantState>(
                          builder: (context, state) {
                            if (state is RestaurantSelectedState) {
                              final categories = state.categories;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  double _marginLeft = 20;
                                  final category = categories[index];
                                  return Container(
                                      margin: EdgeInsets.only(
                                          left: _marginLeft, right: 20),
                                      child: _buildCategoryItem(category));
                                },
                              );
                            }
                            return Center(
                              child: LoadingIndicator(
                                loadingText: "loading categories",
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.stars,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'Information',
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "address",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          SizedBox(width: 10),
                          BlocBuilder<RestaurantCubit, RestaurantState>(
                              builder: (context, state) {
                                if (state is RestaurantSelectedState)
                                  return Expanded(
                                    flex: 3,
                                    child: Text(
                                      state.restaurant.address ?? "no address",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.body2,
                                    ),
                                  );
                                return Expanded(
                                    flex: 3, child: Text("no address"));
                              }),
                          SizedBox(
                            width: 42,
                            height: 42,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
                              child: Icon(
                                Icons.directions,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.9),
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text(
                              '${"phone"} \n${"mobile"}',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          BlocBuilder<RestaurantCubit, RestaurantState>(
                              builder: (context, state) {
                                if (state is RestaurantSelectedState)
                                  return Expanded(
                                    flex: 3,
                                    child: Text(
                                      state.restaurant.phoneNumber ??
                                          "no phone number",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.body2,
                                    ),
                                  );
                                return Expanded(
                                    flex: 3, child: Text("no phone number"));
                              }),
                          SizedBox(
                            width: 42,
                            height: 42,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
                              child: Icon(
                                Icons.call,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.9),
                              shape: StadiumBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                    )
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       vertical: 10, horizontal: 20),
                    //   child: ListTile(
                    //     dense: true,
                    //     contentPadding: EdgeInsets.symmetric(vertical: 0),
                    //     leading: Icon(
                    //       Icons.recent_actors,
                    //       color: Theme.of(context).hintColor,
                    //     ),
                    //     title: Text(
                    //       'What They Say ?',
                    //       style: Theme.of(context).textTheme.display1,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 20, vertical: 10),
                    //   child: ReviewsListWidget(),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: ListTile(
                    //     dense: true,
                    //     contentPadding: EdgeInsets.symmetric(vertical: 0),
                    //     leading: Icon(
                    //       Icons.restaurant,
                    //       color: Theme.of(context).hintColor,
                    //     ),
                    //     title: Text(
                    //       'Featured Foods',
                    //       style: Theme.of(context).textTheme.display1,
                    //     ),
                    //   ),
                    // ),
                    // ListView.separated(
                    //   padding: EdgeInsets.symmetric(vertical: 10),
                    //   scrollDirection: Axis.vertical,
                    //   shrinkWrap: true,
                    //   primary: false,
                    //   itemCount: _ordersList.recentOrderedList.length,
                    //   separatorBuilder: (context, index) {
                    //     return SizedBox(height: 10);
                    //   },
                    //   itemBuilder: (context, index) {
                    //     return OrderItemWidget(
                    //       heroTag: 'details_featured_food',
                    //       order: _ordersList.recentOrderedList.elementAt(index),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 32,
            right: 20,
            child: ShoppingCartFloatButtonWidget(
              iconColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).hintColor,
            ),
          ),
        ],
      )
    );
  }

  Widget _buildCategoryItem(Category category) {
    final restaurantState = BlocProvider.of<RestaurantCubit>(context).state;
    final restaurant = (restaurantState as RestaurantSelectedState).restaurant;
    return InkWell(
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      highlightColor: Colors.transparent,
      onTap: () {
        BlocProvider.of<MenuCubit>(context)
            .setMenusByRestaurantCategory(restaurant, category);
        Navigator.of(context).pushNamed('/Menu');
      },
      child: new CategoriesGridItemWidget(
        category: category,
      ),
    );
  }
}
