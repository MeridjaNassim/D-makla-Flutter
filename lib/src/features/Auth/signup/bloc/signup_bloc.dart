import 'package:bloc/bloc.dart';
import 'package:restaurant_rlutter_ui/src/features/Auth/signup/bloc/signup_event.dart';
import 'package:restaurant_rlutter_ui/src/features/Auth/signup/bloc/signup_state.dart';
import 'package:restaurant_rlutter_ui/src/features/Auth/signup/domain/signup.dart';
import 'package:restaurant_rlutter_ui/src/utils/validation.dart';

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
        bool value = await (SignUpManager()).signUpUserWithPhoneNumber(
          phoneNumber: event.phoneNumber,
          password: event.password,
          fullName: event.fullName,
          countryCode: event.countryCode,
          wilaya: event.wilaya
        );
        if (!value) {
          print('error in signup');
          throw Exception('Could not SignUp');
        }
        print('signed in');
        yield SignedUpState();
        return;
      } catch (e) {
        yield SignUpServerErrorState(message: 'Could not sign you up');
        return;
      }
    }
    if (event is RetryEvent) {
      yield IdleState();
    }
  }
}
