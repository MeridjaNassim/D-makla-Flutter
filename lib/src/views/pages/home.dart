import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dmakla_flutter/src/business_logic/blocs/store/store.cubit.dart';
import 'package:dmakla_flutter/src/views/elements/CardsCarouselWidget.dart';
import 'package:dmakla_flutter/src/views/elements/CategoriesGridWidget.dart';
import 'package:dmakla_flutter/src/views/elements/FoodsCarouselWidget.dart';
import 'package:dmakla_flutter/src/views/elements/SearchBarWidget.dart';
import 'package:dmakla_flutter/src/views/elements/common/loading.dart';
import '../../business_logic/models/common/image.dart' as BusinessImage;

// /// Get all data of HomeScreen
// Future<Map<String,dynamic>> getHomeData({String userId, String cityId}) async {
//   final String repository_url = "https://www.d-makla.com/nassim_api/AppAndroid_all_apiBis.php?app_home_list";
//   final formData = {
//     "user_id" : userId,
//     "city_id"  : cityId
//   };
//
//   final http.Response response = await http.post(repository_url,body: formData);
//   final jsonData = json.decode(response.body);
//   final Map<String,dynamic> data = {
//     "Search" : jsonData["Search"],
//     "Trending" : jsonData["Trending"],
//     "Restaurant" : jsonData["Restaurant"],
//     "Category" : jsonData["Category"],
//   };
//   return data;
// }
//
// Category convertCategoryItemFromData(dynamic data){
//   final String id = data["id"];
//   final String name = data["category_name"];
//   final String image = data["image"];
//   return Category(id: id,name: name ,image:  BusinessImage.NetworkImage(url: image));
// }
// Restaurant convertRestaurantItemFromData(dynamic data){
//   final String id = data["id"];
//   final String name = data["restaurant_title"];
//   final String image = data["image"];
//   return Restaurant(id: id,name: name ,image: BusinessImage.NetworkImage(url: image));
// }
//
// List<Restaurant> convertRestaurantListFromData(List<dynamic> data) {
//   final List<Restaurant> restaurants = data.map((e) => convertRestaurantItemFromData(e)).toList();
//   return restaurants;
// }
//
//
// List<Category> convertCategoryListFromData (List<dynamic> data) {
//     final List<Category> categories = data.map((e) => convertCategoryItemFromData(e)).toList();
//     return categories;
// }
//
// List<Category> getCategoriesFromData(Map<String,dynamic> data) {
//   final categoriesData = data["Category"];
//   if(categoriesData == null)
//     {
//       print("null categories data");
//       return null;
//     }
//   final List<dynamic> categoriesList = categoriesData["list"];
//   final categories = convertCategoryListFromData(categoriesList);
//   if(categories == null)
//     print("null categories");
//   return categories;
// }
//
// List<Restaurant> getRestaurantsFromData(Map<String,dynamic> data) {
//   final restaurantData = data["Restaurant"];
//   if(restaurantData == null)
//   {
//     print("null categories data");
//     return null;
//   }
//   final List<dynamic> restaurantList = restaurantData["list"];
//   final restaurants = convertRestaurantListFromData(restaurantList);
//   if(restaurants == null)
//     print("null categories");
//   return restaurants;
// }

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshPage() async {
    print("refreshing");
    return BlocProvider.of<StoreCubit>(context).loadStore();
  }

  Widget _buildHomePage(StoreState state) {
    return RefreshIndicator(
      onRefresh: _refreshPage,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: SearchBarWidget(title: "Rechercher votre plat préférer"),
            // ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              leading: Icon(
                Icons.trending_up,
                color: Theme.of(context).hintColor,
              ),
              title: Text(
                "Menu tendence",
                style: Theme.of(context).textTheme.display1,
              ),
              subtitle: null,
            ),
            BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
              if (state is StoreLoadedState) {
                return FoodsCarouselWidget(menus: state.store.trendingMenus);
              }
              return LoadingIndicator(loadingText: "loading trending");
            }),
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
                  "Choisir par restaurant",
                  style: Theme.of(context).textTheme.display1,
                ),
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
                  "Choisir par catégorie",
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
            ),
            CategoriesGridWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(String message) {
    return Container(
        height: MediaQuery.of(context).size.height -
            Scaffold.of(context).appBarMaxHeight,
        width: MediaQuery.of(context).size.width,
        child: Center(child: LoadingIndicator(loadingText: message)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<StoreCubit, StoreState>(builder: (context, state) {
      if (state is StoreLoadedState) return _buildHomePage(state);
      if (state is StoreLoadingState) return _buildLoading(state.message);
      return _buildLoading("loading");
    });
  }
}
