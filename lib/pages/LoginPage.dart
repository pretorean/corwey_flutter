import 'package:corwey_flutter/UserRepository.dart';
import 'package:corwey_flutter/bloc/LoginBloc.dart';
import 'package:corwey_flutter/pages/LoginForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _loginBloc = LoginBloc(userRepository: _userRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: LoginForm(
      loginBloc: _loginBloc,
    )));
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
