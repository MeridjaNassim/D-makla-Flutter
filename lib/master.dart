import 'package:http/http.dart' as http;
import 'dart:convert';
Future<void> main() async{
    print("searching");
    final data = await getHomeData(userId: "47",cityId: "15");
    print(data);
}



/// Get all data of HomeScreen
Future<Map<String,dynamic>> getHomeData({String userId, String cityId}) async {
  final String repository_url = "https://www.d-makla.com/nassim_api/AppAndroid_all_apiBis.php?app_home_list";
  final formData = {
    "user_id" : userId,
    "city_id"  : cityId
  };

  final http.Response response = await http.post(repository_url,body: formData);
  final jsonData = json.decode(response.body)["APP_HOME_LIST"];
  final Map<String,dynamic> data = {
    "Search" : jsonData[0],
    "Trending" : jsonData[1],
    "Restaurant" : jsonData[2],
    "Category" : jsonData[3],
  };
  return data;
}
