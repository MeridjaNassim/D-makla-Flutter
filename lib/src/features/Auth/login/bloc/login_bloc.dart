import 'package:bloc/bloc.dart';
import 'package:restaurant_rlutter_ui/src/features/Auth/login/domain/login.dart';
import 'package:restaurant_rlutter_ui/src/utils/conversion.dart';
import 'package:restaurant_rlutter_ui/src/utils/validation.dart';

import '../../auth.dart';
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
        //TODO add better error handling
        
        User user = await (LoginManager()).loginUserWithPhoneNumber(formatPhoneNumberToLocal(event.phoneNumber),event.password);
        if(user == null) {
          print('error in loggin');
          throw Exception('Cannot log in... try later');
        }
        await AuthManager().setCurrentUser(user);
        User _user = await AuthManager().getCurrentLoggedUser();
        print("user persisted : " + _user.toString());
        yield LoggedInState(user: user);
        print('logged in');
        return;
      }catch(e){
        yield LoginServerErrorState(message: e.message);
        return;
      }
    }
    if(event is RetryEvent){
      yield IdleState();
    }
  }

}
