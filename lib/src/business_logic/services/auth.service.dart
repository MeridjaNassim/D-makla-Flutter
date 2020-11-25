import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
abstract class AuthenticationService {

  Future<bool> signOut();
  Future<bool> setUser(User user);
  Future<User> getCurrentUser();
  Future<bool> didFirstLogin();
}


class AuthenticationServiceImpl extends AuthenticationService{
  SharedPreferences sharedPreferences;
  @override
  Future<User> getCurrentUser() async {
    if(sharedPreferences == null)  sharedPreferences = await SharedPreferences.getInstance();
    try{
      String userString = sharedPreferences.getString("user");
      print(userString);
      final jsonData = json.decode(userString);
      User user = User.fromJson(jsonData);
      print(user);
      return user;
    } catch (e){
      print(e);
      return null;
    }
  }

  Future<bool> didFirstLogin() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool didLoginOnce = sharedPreferences.getBool("didLogInOnce") ?? false;
    return didLoginOnce;
  }
  @override
  Future<bool> signOut() async {
    if(sharedPreferences == null) await SharedPreferences.getInstance();
    try{
      sharedPreferences.remove("user");
      return true;
    }catch(e) {
      return false;
    }
  }

  @override
  Future<bool> setUser(User user) async{
   if(sharedPreferences == null ) sharedPreferences = await SharedPreferences.getInstance();
   final userString = json.encode(user.toJson());
   final didFirstLogging = await sharedPreferences.get("didLogInOnce") ?? false;
   if(!didFirstLogging) await sharedPreferences.setBool("didLogInOnce", true);
   bool ok = await sharedPreferences.setString("user", userString);
   return ok;
  }


}