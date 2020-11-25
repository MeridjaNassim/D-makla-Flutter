import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/category.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/restaurant.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';
import "dart:convert";
import 'package:restaurant_rlutter_ui/src/features/Menu/categories/bloc/categories_cubit.dart';
import 'package:restaurant_rlutter_ui/src/features/Menu/restaurants/bloc/restaurant_cubit.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/CardsCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/CaregoriesCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/FoodsCarouselWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/SearchBarWidget.dart';
import 'package:restaurant_rlutter_ui/src/views/elements/common/loading.dart';
import '../../business_logic/models/common/image.dart' as BusinessImage;
/// Get all data of HomeScreen
Future<Map<String,dynamic>> getHomeData({String userId, String cityId}) async {
  final String repository_url = "https://www.d-makla.com/nassim_api/AppAndroid_all_apiBis.php?app_home_list";
  final formData = {
    "user_id" : userId,
    "city_id"  : cityId
  };

  final http.Response response = await http.post(repository_url,body: formData);
  final jsonData = json.decode(response.body);
  final Map<String,dynamic> data = {
    "Search" : jsonData["Search"],
    "Trending" : jsonData["Trending"],
    "Restaurant" : jsonData["Restaurant"],
    "Category" : jsonData["Category"],
  };
  return data;
}

Category convertCategoryItemFromData(dynamic data){
  final String id = data["id"];
  final String name = data["category_name"];
  final String image = data["image"];
  return Category(id: id,name: name ,image:  BusinessImage.NetworkImage(url: image));
}
Restaurant convertRestaurantItemFromData(dynamic data){
  final String id = data["id"];
  final String name = data["restaurant_title"];
  final String image = data["image"];
  return Restaurant(id: id,name: name ,image: BusinessImage.NetworkImage(url: image));
}

List<Restaurant> convertRestaurantListFromData(List<dynamic> data) {
  final List<Restaurant> restaurants = data.map((e) => convertRestaurantItemFromData(e)).toList();
  return restaurants;
}


List<Category> convertCategoryListFromData (List<dynamic> data) {
    final List<Category> categories = data.map((e) => convertCategoryItemFromData(e)).toList();
    return categories;
}

List<Category> getCategoriesFromData(Map<String,dynamic> data) {
  final categoriesData = data["Category"];
  if(categoriesData == null)
    {
      print("null categories data");
      return null;
    }
  final List<dynamic> categoriesList = categoriesData["list"];
  final categories = convertCategoryListFromData(categoriesList);
  if(categories == null)
    print("null categories");
  return categories;
}

List<Restaurant> getRestaurantsFromData(Map<String,dynamic> data) {
  final restaurantData = data["Restaurant"];
  if(restaurantData == null)
  {
    print("null categories data");
    return null;
  }
  final List<dynamic> restaurantList = restaurantData["list"];
  final restaurants = convertRestaurantListFromData(restaurantList);
  if(restaurants == null)
    print("null categories");
  return restaurants;
}

class HomeWidget extends StatefulWidget {

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}



class _HomeWidgetState extends State<HomeWidget> {
  Map<String,dynamic> homeData;
  bool loadingData;
  @override
  void initState() {
    super.initState();
    loadingData = true;
    start();
  }

  void start() async{
    await getHomeDataAsync();
    /// sets the cubit of categories.
    final categories = getCategoriesFromData(homeData);
    final restaurants = getRestaurantsFromData(homeData);
    print(categories);
    BlocProvider.of<CategoriesCubit>(context).setCategories(categories);
    print(restaurants);
    BlocProvider.of<RestaurantCubit>(context).setRestaurants(restaurants);
  }
  Future<void> getHomeDataAsync() async {
    final authState = BlocProvider.of<AuthenticationBloc>(context).state;
    if(authState is AuthenticationAuthenticated) {
      User user = authState.user;
      print("user city id " + user.wilaya.code);
      final data = await getHomeData(userId: user.id,cityId: user.wilaya.code);
      setState(() {
        homeData = data;
        loadingData = false;
      });
      print(data);
    }


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return loadingData ? Container(
        height: MediaQuery.of(context).size.height -Scaffold.of(context).appBarMaxHeight ,
        width: MediaQuery.of(context).size.width,
        child: Center(child: LoadingIndicator(loadingText: "loading home page")))  :  SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBarWidget(title : homeData["Search"]["title"]),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            leading: Icon(
              Icons.trending_up,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              homeData["Trending"]["title"] ?? "Tendences",
              style: Theme.of(context).textTheme.display1,
            ),
            subtitle:homeData["Trending"]["subtitle"] != "" ?  Text(
                homeData["Trending"]["subtitle"] ,
              style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 11)),
            ) : null,
          ),
          FoodsCarouselWidget(),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                Icons.stars,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                homeData["Restaurant"]["title"],
                style: Theme.of(context).textTheme.display1,
              ),
              // subtitle: Text(
              //   'Ordered by Nearby first',
              //   style: Theme.of(context).textTheme.caption,
              // ),
            ),
          ),
          CardsCarouselWidget(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              leading: Icon(
                Icons.category,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                homeData["Category"]["title"] ,
                style: Theme.of(context).textTheme.display1,
              ),
            ),
          ),
          CategoriesCarouselWidget(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: ListTile(
          //     dense: true,
          //     contentPadding: EdgeInsets.symmetric(vertical: 0),
          //     leading: Icon(
          //       Icons.trending_up,
          //       color: Theme.of(context).hintColor,
          //     ),
          //     title: Text(
          //       'Most Popular',
          //       style: Theme.of(context).textTheme.display1,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: GridWidget(),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: ListTile(
          //     dense: true,
          //     contentPadding: EdgeInsets.symmetric(vertical: 20),
          //     leading: Icon(
          //       Icons.recent_actors,
          //       color: Theme.of(context).hintColor,
          //     ),
          //     title: Text(
          //       'Recent Reviews',
          //       style: Theme.of(context).textTheme.display1,
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: ReviewsListWidget(),
          // ),
        ],
      ),
    );
  }
}
