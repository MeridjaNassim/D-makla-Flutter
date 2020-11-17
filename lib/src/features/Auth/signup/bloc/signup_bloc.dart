import 'package:bloc/bloc.dart';
import 'package:d_makla/core/errors/exceptions.dart';
import 'package:d_makla/core/utils/validation.dart';
import 'package:d_makla/features/signup/domain/usecases/signup_with_phone_usecase.dart';
import 'package:d_makla/features/signup/presentation/bloc/signup_event.dart';
import 'package:d_makla/features/signup/presentation/bloc/signup_state.dart';

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
        var value = await (SignUpWithPhoneUseCase())(SignupParams(
            phoneNumber: event.phoneNumber,
            password: event.password,
            countryCode: event.countryCode,
            wilaya: event.wilaya,
            fullName: event.fullName));
        if (value.isLeft()) {
          print('error in signup');
          throw ServerException();
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
