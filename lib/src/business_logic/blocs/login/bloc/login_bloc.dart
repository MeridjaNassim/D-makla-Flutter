import 'package:bloc/bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/auth/auth.event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/login/domain/login.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/repositories/user_repository.dart';
import 'file:///D:/Projects/flutter/d_makla2/d_makla/lib/src/business_logic/utils/conversion.dart';
import 'file:///D:/Projects/flutter/d_makla2/d_makla/lib/src/business_logic/utils/validation.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  final AuthenticationBloc _authenticationBloc;
  LoginBloc(AuthenticationBloc authBloc):
        assert (authBloc != null),
        _authenticationBloc = authBloc,
        super(IdleState());

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
        print(user);
        if(user == null) {
          print('error in loggin');
          throw Exception('Cannot log in... try later');
        }
        ///await AuthManager().setCurrentUser(user);
       // User _user = await AuthManager().getCurrentLoggedUser();
        _authenticationBloc.add(UserLoggedIn(user: user));
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
