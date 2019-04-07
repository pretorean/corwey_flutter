import 'dart:async';

import 'package:corwey_flutter/UserRepository.dart';
import 'package:corwey_flutter/events/LoginEvents.dart';
import 'package:corwey_flutter/states/LoginStates.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc({
    @required this.userRepository,
  }) : assert(userRepository != null);

  @override
  LoginState get initialState => LoginSplash();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // запуск приложения
    if (event is AppStarted) {
      yield LoginSplash();
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        yield LoginAuthenticated();
      } else {
        yield LoginGetPhoneNumber();
      }
    }

    // введен номер телефона
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

    // введен проверочный код
    if (event is LoginVerifyCodeEntered) {
      // TODO hasUserRole
      yield LoginSelectRole(phone: event.phone);
    }

    // выбрана роль
    if (event is LoginRoleSelected) {
      yield LoginLoading();
      try {
        final token = await userRepository.authenticate(
          phone: event.phone,
        );
        await userRepository.persistUserRole(
          userRole: event.userRole,
        );
        this.dispatch(LoggedIn(token: token));
        yield LoginLoading();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    // выполнен вход
    if (event is LoggedIn) {
      yield LoginLoading();
      await userRepository.persistToken(event.token);
      yield LoginAuthenticated();
    }

    // выполнен выход
    if (event is LoggedOut) {
      yield LoginLoading();
      await userRepository.deleteToken();
      yield LoginGetPhoneNumber();
    }
  }
}
