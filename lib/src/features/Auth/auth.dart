import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends Equatable{
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String gender;
  final double wallet;
  final String latitude;
  final String longitude;
  final String city_id;
  final String address;
  final String location;
  final String zipcode;

  User({this.id,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.gender,
      this.wallet,
      this.latitude,
      this.longitude,
      this.city_id,
      this.address,
      this.location,
      this.zipcode});
  factory User.fromJsonString(String userJson) {
    Map<String,dynamic>  values = json.decode(userJson);
    return User(id: values["id"],fullName: values["fullName"],phoneNumber: values["phoneNumber"] ,email: values["email"],gender: values["gender"] , city_id: values["city_id"]);
  }

  String toJsonString() {
    Map<String,String> mapValues = {
      "id" : id,
      "fullName" :fullName,
      "phoneNumber" : phoneNumber,
      "email" : email,
      "gender" : gender,
      "city_id" : city_id
    };
    String jsonString = json.encode(mapValues);
    print(jsonString);
    return jsonString;
  }

  @override
  List<Object> get props {
    return [id,fullName,phoneNumber];
  }
}

class AuthManager {

  SharedPreferences sharedPreferences;

  AuthManager();
  //TODO: sets the current user of the session in local storage
  Future<bool> setCurrentUser(User user) async {
    if(sharedPreferences == null) sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool("didLogInOnce", true);
    String userAsString = user.toJsonString();
    bool added = await sharedPreferences.setString("user", userAsString );
    if(added)
        print("added user to local storage");
    else
      print("not added user to local storage");
    return added;
  }

  ///TODO: get user from local storage, returns null if no user
  Future<User> getCurrentLoggedUser() async {
    if(sharedPreferences == null)  sharedPreferences = await SharedPreferences.getInstance();
    try{
      String userString = sharedPreferences.getString("user");
      print(userString);
      User user = User.fromJsonString(userString);
      print(user);
      return user;
    } catch (e){
      print(e);
      return null;
    }
  }
  Future<bool> removeCurrentUser() async {
    if(sharedPreferences == null) await SharedPreferences.getInstance();
    try{
      sharedPreferences.remove("user");
      return true;
    }catch(e) {
      return false;
    }

  }
}