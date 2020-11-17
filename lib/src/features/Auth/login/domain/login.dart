class LoginManager {

  LoginManager();

  Future<bool> loginUserWithPhoneNumber(String phoneNumber, String password) async{

    //TODO: POST api/login to get user data
    return Future.delayed(Duration(seconds: 3), ()=>true);
  }


}