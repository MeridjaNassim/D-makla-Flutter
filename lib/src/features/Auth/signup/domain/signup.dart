class SignUpManager {

  SignUpManager();

  Future<bool> signUpUserWithPhoneNumber({String phoneNumber, String password,String fullName,String countryCode,String wilaya}) async{
    ///TODO : POST api/signup to create a new user and get his data
    return Future.delayed(Duration(seconds: 3), ()=>true);
  }

}