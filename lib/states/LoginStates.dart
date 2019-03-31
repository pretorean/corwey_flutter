import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

// ввод номера телефона
class LoginGetPhoneNumber extends LoginState {
  @override
  String toString() => 'LoginGetPhoneNumber';
}

// ввод проверочного кода
class LoginGetVerifyCode extends LoginState {
  final String code;

  LoginGetVerifyCode({@required this.code}) : super([code]);

  @override
  String toString() => 'LoginGetVerifyCode { verify code: $code }';
}

class delete_LoginInitial extends LoginState {
  @override
  String toString() => 'LoginInitial';
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
