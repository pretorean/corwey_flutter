import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

// показ заставки
class LoginSplash extends LoginState {
  @override
  String toString() => 'LoginSplash';
}

// ввод номера телефона
class LoginGetPhoneNumber extends LoginState {
  @override
  String toString() => 'LoginGetPhoneNumber';
}

// ввод проверочного кода
class LoginGetVerifyCode extends LoginState {
  final String phone;
  final String code;

  LoginGetVerifyCode({@required this.phone, this.code}) : super([phone, code]);

  @override
  String toString() {
    return 'LoginGetVerifyCode{phone: $phone, code: $code}';
  }
}

// вход выполнен
class LoginAuthenticated extends LoginState {
  @override
  String toString() => 'LoginAuthenticated';
}

// состояние ожидания
class LoginLoading extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

// ошибка
class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() => 'LoginFailure { error: $error }';
}
