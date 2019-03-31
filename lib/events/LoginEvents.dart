import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginPhoneNumberEntered extends LoginEvent {
  final String phone;

  LoginPhoneNumberEntered({@required this.phone}) : super([phone]);

  @override
  String toString() =>
      'LoginPhoneNumberEntered { phone: $phone }';
}

class delete_LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  delete_LoginButtonPressed({
    @required this.username,
    @required this.password,
  }) : super([username, password]);

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}
