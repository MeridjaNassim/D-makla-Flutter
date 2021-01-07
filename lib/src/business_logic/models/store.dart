import 'package:equatable/equatable.dart';
import 'package:dmakla_flutter/src/business_logic/models/category.dart';
import 'package:dmakla_flutter/src/business_logic/models/restaurant.dart';

import 'menu.dart';


/*
* Class used to hold all the data necessary of the application
* */
class Store extends Equatable{
  final List<Restaurant> restaurants;
  final List<Category> categories;
  final List<Menu> trendingMenus;
  Store({this.restaurants, this.categories,this.trendingMenus});

  @override
  // TODO: implement props
  List<Object> get props => null;
}