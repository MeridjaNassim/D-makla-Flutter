
import 'package:equatable/equatable.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/datasources/category_datasource.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/datasources/menu_datasource.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/datasources/restaurant_datasource.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/category_repository.dart';


Future<void> main() async {
  EquatableConfig.stringify = true;
  final menusource = RemoteMenuDataSourceImpl();
  final data = await menusource.getTrendingMenus("15");
  print(data);
}


