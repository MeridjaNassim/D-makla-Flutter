import 'package:dmakla/src/business_logic/models/common/wilaya.dart';
import 'package:dmakla/src/business_logic/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String signup_url_dev =
    "https://www.d-makla.com/nassim_api/AppAndroid_all_apiBis.php?signup";
const String signup_url_dev2 =
    "https://www.d-makla.com/nassim_api/AppFlutter_all_api.php?signup";
const String RES_ATR = "USER_REGISTRATION";

class SignUpManager {
  SignUpManager();

  Future<User> signUpUserWithPhoneNumber(
      {String phoneNumber,
      String password,
      String fullName,
      String countryCode,
      String wilayaCode}) async {
    Map<String, String> formData = {
      "name": fullName,
      "password": password,
      "mobile": phoneNumber,
      "city_id": wilayaCode
    };

    final http.Response response =
        await http.post(signup_url_dev2, body: formData);
    if (response.body.isEmpty) return null;
    final Map<String, dynamic> decodedBody = json.decode(response.body);
    Map<String, dynamic> data = decodedBody[RES_ATR];
    if (data == null) return null;
    if (data["error"] == "true")
       {
         throw Exception(data["message"]);
       }

    ///TODO : add other fields to user object
    User user = User(
        id: data["id"],
        fullName: data["name"],
        phoneNumber: data["mobile"],
        email: data["email"],
        wilaya: Wilaya(code: data["city_id"])
    );
    return user;
  }
}
