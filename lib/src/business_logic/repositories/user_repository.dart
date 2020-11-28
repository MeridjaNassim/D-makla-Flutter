import 'package:restaurant_rlutter_ui/src/business_logic/models/common/wilaya.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';

abstract class UserRepository  {
  Future<User> loginWithPhoneNumber(String phoneNumber,String password);
  Future<User> getUserInformation(String user_id);
  Future<User> signUpWithPhoneNumber(String phoneNumber,String password,String fullName,Wilaya wilaya);
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<User> loginWithPhoneNumber(String phoneNumber, String password) {
    // TODO: implement loginWithPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<User> signUpWithPhoneNumber(String phoneNumber, String password, String fullName, Wilaya wilaya) {
    // TODO: implement signUpWithPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<User> getUserInformation(String user_id) {
    // TODO: implement getUserInformation
    throw UnimplementedError();
  }
  
}