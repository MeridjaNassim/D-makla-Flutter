import 'package:bloc/bloc.dart';
import 'package:restaurant_rlutter_ui/src/business_logic/services/auth.service.dart';

import 'auth.event.dart';
import 'auth.state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppLoaded) {
      print("app loaded");
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
      final currentUser = await _authenticationService.getCurrentUser();
      print(currentUser);
      if (currentUser != null) {
        yield AuthenticationAuthenticated(user: currentUser);
      } else {
        yield AuthenticationNotAuthenticated();
      }
    } catch (e) {
      yield AuthenticationFailure(message: e.message ?? 'An unknown error occurred');
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    print("user logged in " + event.user.toString());
    yield AuthenticationAuthenticated(user: event.user);
    await _authenticationService.setUser(event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
    await _authenticationService.signOut();
    yield AuthenticationNotAuthenticated();
  }

  Future<bool> isFirstLogin() async{
      return !await this._authenticationService.didFirstLogin();
  }
}
