
import 'package:flutter/material.dart';
import 'package:restaurant_rlutter_ui/src/features/Auth/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const String login_url_dev = "https://www.d-makla.com/nassim_api/AppAndroid_all_apiBis.php?login";
const String RES_ATR = "LOGGED_IN_USER";
class LoginManager {

  LoginManager();

  Future<User> loginUserWithPhoneNumber(String phoneNumber, String password) async{
    Map<String, String> formData = {
      "mobile" : phoneNumber,
      "password" : password
    };

    final http.Response response = await http.post(login_url_dev,body: formData);
    if(response.body.isEmpty)
      return null;
    final Map<String,dynamic> decodedBody = json.decode(response.body);
    Map<String,dynamic> data = decodedBody[RES_ATR];
    if(data == null)
      return null;
    if(data["error"] == "true")
      throw Exception(data["msg"]);
    ///TODO : add other fields to user object
    User user = User(id: data["id"], fullName: data["name"], phoneNumber: data["mobile"],email: data["email"]);
    return user;
  }


}