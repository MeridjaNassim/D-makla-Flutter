import 'package:bloc/bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/signup/bloc/signup_event.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/signup/bloc/signup_state.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/blocs/signup/domain/signup.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/models/user.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/utils/conversion.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/utils/validation.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(IdleState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is StartSignUpEvent) {
      SignUpWithPhoneNumberValidation validation =
      validateSignupWithPhone(
              phoneNumber: event.phoneNumber, password: event.password,fullName: event.fullName);
      if (validation.hasError()) {
        print("validation error? ");
        yield SignUpInputValidationErrorState(
            fullNameError: validation.fullNameError,
            phoneNumberError: validation.phoneNumberError,
            passwordError: validation.passwordError);
        return;
      }
      yield SigningUpState();

      try {
        String wilayaCode = convertWilayaStringToCode(event.wilaya);
        String formatedPhoneNumber = formatPhoneNumberToLocal(event.phoneNumber);
        User user = await (SignUpManager()).signUpUserWithPhoneNumber(
          phoneNumber: formatedPhoneNumber,
          password: event.password,
          fullName: event.fullName,
          countryCode: event.countryCode,
          wilayaCode: wilayaCode
        );
        if (user == null) {
          print('error in signup');
          throw Exception('Could not sign you up... try again');
        }
        print('signed in');
        //TODO: store user data in the local storage
        //await AuthManager().setCurrentUser(user);

        yield SignedUpState(user: user);
        return;
      } catch(e) {
        print("error : " + e.message);
        yield SignUpServerErrorState(message: e.message);
        return;
      }
    }
    if (event is RetryEvent) {
      yield IdleState();
    }
  }
}
