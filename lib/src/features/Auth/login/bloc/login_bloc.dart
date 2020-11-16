import 'package:bloc/bloc.dart';
import 'package:restaurant_rlutter_ui/src/features/Auth/login/domain/login.dart';
import 'package:restaurant_rlutter_ui/src/utils/validation.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  LoginBloc(): super(IdleState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if(event is StartLoginEvent){
      LoginWithPhoneNumberValidation validation = validateLoginWithPhoneCredentials(phoneNumber: event.phoneNumber,password: event.password);
      if(validation.hasError()) {
        print("validation error? ");
        yield LoginInputValidationErrorState(phoneNumberError: validation.phoneNumberError,passwordError: validation.passwordError);
        return;
      }
      yield LoggingInState();
      print('logging in ....');
      try{
        bool value = await (LoginManager()).loginUserWithPhoneNumber(event.phoneNumber,event.password);
        if(!value) {
          print('error in loggin');
          throw Exception('Cannot log in... try later');
        }
        //TODO: store user data in the shared prefs local storage
        /// TODO: pass user data to loggedin state
        yield LoggedInState();
        print('logged in');
        return;
      }catch(e){
        yield LoginServerErrorState(message: 'Could not log you in');
        return;
      }
    }
    if(event is RetryEvent){
      yield IdleState();
    }
  }

}
