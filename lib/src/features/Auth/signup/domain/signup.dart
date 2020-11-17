class SignUpManager {

  SignUpManager();

  Future<bool> signUpUserWithPhoneNumber({String phoneNumber, String password,String fullName,String countryCode,String wilaya}) async{
    return Future.delayed(Duration(seconds: 3), ()=>true);
  }


}
