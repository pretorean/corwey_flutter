import 'dart:async';

import 'package:corwey_flutter/UserRepository.dart';
import 'package:corwey_flutter/bloc/AuthenticationBloc.dart';
import 'package:corwey_flutter/events/AuthenticationEvents.dart';
import 'package:corwey_flutter/events/LoginEvents.dart';
import 'package:corwey_flutter/states/LoginStates.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginGetPhoneNumber();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {



    if (event is LoginPhoneNumberEntered) {
      yield LoginLoading();
      try {
        final code =
            await userRepository.sendVerificationSMS(phone: event.phone);
        yield LoginGetVerifyCode(phone: event.phone, code: code);
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    if (event is LoginVerifyCodeEntered) {
      yield LoginLoading();
      try {
        final token = await userRepository.authenticate(
          phone: event.phone,
        );
        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginLoading();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
