import 'package:http/http.dart' as http;
import 'package:dmakla/src/business_logic/models/common/wilaya.dart' ;
import 'dart:convert';

import 'package:dmakla/src/business_logic/models/user.dart';
const String login_url_dev = "https://www.d-makla.com/nassim_api/AppAndroid_all_apiBis.php?login";
const String login_url_dev2 =
    "https://www.d-makla.com/nassim_api/AppFlutter_all_api.php?login";
const String RES_ATR = "LOGGED_IN_USER";
class LoginManager {

  LoginManager();

  Future<User> loginUserWithPhoneNumber(String phoneNumber, String password) async{
    Map<String, String> formData = {
      "mobile" : phoneNumber,
      "password" : password
    };

    final http.Response response = await http.post(login_url_dev2,body: formData);
    if(response.body.isEmpty)
      return null;
    final Map<String,dynamic> decodedBody = json.decode(response.body);
    Map<String,dynamic> data = decodedBody[RES_ATR];
    if(data == null)
      return null;
    if(data["error"] == "true")
      throw Exception(data["msg"]);
    ///TODO : add other fields to user object add wilaya especially

    User user = User(wilaya:Wilaya(code: data["city_id"]), id: data["id"], fullName: data["name"], phoneNumber: data["mobile"],email: data["email"]);
    return user;
  }


}