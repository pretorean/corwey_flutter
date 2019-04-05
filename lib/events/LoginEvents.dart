import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

// событие запуска приложения
class AppStarted extends LoginEvent {
  @override
  String toString() => 'AppStarted';
}

// событие ввода телефонного номера
class LoginPhoneNumberEntered extends LoginEvent {
  final String phone;

  LoginPhoneNumberEntered({@required this.phone}) : super([phone]);

  @override
  String toString() => 'LoginPhoneNumberEntered { phone: $phone }';
}

// событие ввода проверочного кода
class LoginVerifyCodeEntered extends LoginEvent {
  final String phone;

  LoginVerifyCodeEntered({@required this.phone}) : super([phone]);

  @override
  String toString() {
    return 'LoginVerifyCodeEntered{phone: $phone}';
  }
}

// событие входа в систему
class LoggedIn extends LoginEvent {
  final String token;

  LoggedIn({@required this.token}) : super([token]);

  @override
  String toString() => 'LoggedIn { token: $token }';
}

// событие выхода из системы
class LoggedOut extends LoginEvent {
  @override
  String toString() => 'LoggedOut';
}
