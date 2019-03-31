import 'package:corwey_flutter/AuthenticationBloc.dart';
import 'package:corwey_flutter/AuthenticationEvents.dart';
import 'package:corwey_flutter/AuthenticationStates.dart';
import 'package:corwey_flutter/LoadingIndicator.dart';
import 'package:corwey_flutter/LoginPage.dart';
import 'package:corwey_flutter/MainPage.dart';
import 'package:corwey_flutter/SplashPage.dart';
import 'package:corwey_flutter/UserRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CorweyApp extends StatefulWidget {
  final UserRepository userRepository;

  CorweyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<CorweyApp> createState() => _CorweyAppState();
}

class _CorweyAppState extends State<CorweyApp> {
  UserRepository get _userRepository => widget.userRepository;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      bloc: _authenticationBloc,
      child: MaterialApp(
        title: "Corwey Application",
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            fontFamily: "Montserrat"),
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
            bloc: _authenticationBloc, builder: _builderFunction),
      ),
    );
  }

  Widget _builderFunction(BuildContext context, AuthenticationState state) {
    if (state is AuthenticationUninitialized) {
      return SplashPage();
    }
    if (state is AuthenticationAuthenticated) {
      return MainPage();
    }
    if (state is AuthenticationUnauthenticated) {
      return LoginPage(userRepository: _userRepository);
    }
    if (state is AuthenticationLoading) {
      return LoadingIndicator();
    }
    return null;
  }
}
