import 'package:equatable/equatable.dart';
import 'package:dmakla/src/business_logic/models/cart.dart';
import 'package:dmakla/src/business_logic/models/common/localisation.dart';
import 'package:dmakla/src/business_logic/models/common/wilaya.dart';
import 'package:shortid/shortid.dart';

enum Gender { MALE, FEMALE }

class UserWallet {
  final double currentBalance;

  UserWallet(this.currentBalance);
}

class User extends Equatable {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final Gender gender;
  final UserWallet wallet;
  final Cart cart;
  Wilaya wilaya;
  final Coordinates coordinates;
  final String address;
  final String zipcode;

  User(
      {this.id,
      this.cart,
      this.fullName,
      this.phoneNumber,
      this.email,
      this.gender,
      this.wilaya,
      this.wallet,
      this.coordinates,
      this.address,
      this.zipcode});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        wilaya: Wilaya(code: json["city_id"]));
  }

  Map<String, String> toJson() {
    Map<String, String> mapValues = {
      "id": id,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "email": email,
      "gender": gender.toString(),
      "city_id": wilaya.code
    };
    return mapValues;
  }

  @override
  List<Object> get props {
    return [id, fullName, phoneNumber];
  }
}

const String defaultWilaya = "15";
const String defaultGuestPrefix = "guest";
const String allowedChars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
class GuestUser extends User {
  static bool charsSet = false;
  factory GuestUser.create() {
    if(!charsSet){

      shortid.characters(allowedChars);
      charsSet = true;
    }
    return GuestUser(shortid.generate(), defaultGuestPrefix, defaultWilaya);
  }
  factory GuestUser.fromUser(User user) {
    return GuestUser(user.id, defaultGuestPrefix, user.wilaya.code);
  }

  GuestUser(String id, String namePrefix, String wilayaCode)
      : super(
            id: id,
            fullName: namePrefix + "-" + id,
            wilaya: Wilaya(code: wilayaCode),
            phoneNumber: "N/A",
            email: "N/A",
            wallet: UserWallet(0));
}
