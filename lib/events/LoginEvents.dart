import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginPhoneNumberEntered extends LoginEvent {
  final String phone;

  LoginPhoneNumberEntered({@required this.phone}) : super([phone]);

  @override
  String toString() => 'LoginPhoneNumberEntered { phone: $phone }';
}

class LoginVerifyCodeEntered extends LoginEvent {
  final String phone;

  LoginVerifyCodeEntered({@required this.phone}) : super([phone]);

  @override
  String toString() {
    return 'LoginVerifyCodeEntered{phone: $phone}';
  }
}
