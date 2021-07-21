import 'package:bloc/bloc.dart';
import 'package:dmakla/src/business_logic/models/user.dart';
import 'package:dmakla/src/business_logic/repositories/user_repository.dart';
import 'package:dmakla/src/business_logic/services/auth.service.dart';

import 'auth.event.dart';
import 'auth.state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  AuthenticationBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      ////print("app loaded");
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoaded event) async* {
    yield AuthenticationLoading();
    try {
      User currentUser = await _authenticationService.getCurrentUser();

      ////print(currentUser);
      if (currentUser != null) {
        if(currentUser.fullName.startsWith(defaultGuestPrefix)){
          currentUser  = GuestUser.fromUser(currentUser);
        }
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(
      UserLoggedIn event) async* {
    ////print("user logged in " + event.user.toString());
    yield AuthenticationAuthenticated(user: event.user);
    await _authenticationService.setUser(event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(
      UserLoggedOut event) async* {
    await _authenticationService.signOut();
    yield AuthenticationNotAuthenticated();
  }

  Future<bool> isFirstLogin() async {
    return !await this._authenticationService.didFirstLogin();
  }
  bool isGuest()  {
    AuthenticationState state = this.state;
    if(state is AuthenticationAuthenticated) {
      return (state.user  is  GuestUser);
    }
    return false;
  }
}
