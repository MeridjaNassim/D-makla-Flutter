class LoginManager {

  LoginManager();

  Future<bool> loginUserWithPhoneNumber(String phoneNumber, String password) async{
    return Future.delayed(Duration(seconds: 3), ()=>true);
  }


}