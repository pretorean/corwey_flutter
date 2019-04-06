import 'package:corwey_flutter/UserRepository.dart';
import 'package:corwey_flutter/bloc/LoginBloc.dart';
import 'package:corwey_flutter/events/LoginEvents.dart';
import 'package:corwey_flutter/pages/LoginPage.dart';
import 'package:corwey_flutter/pages/MainPage.dart';
import 'package:corwey_flutter/pages/NotFoundPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CorweyApp extends StatefulWidget {
  final UserRepository userRepository;

  CorweyApp({
    Key key,
    @required this.userRepository,
  }) : super(key: key);

  @override
  State<CorweyApp> createState() => _CorweyAppState();
}

class _CorweyAppState extends State<CorweyApp> {
  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    _loginBloc = LoginBloc(userRepository: _userRepository);
    _loginBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Во всех дочерних элементах можно получить bloc через
    // вызов loginBloc = BlocProvider.of<LoginBloc>(context);
    return BlocProvider<LoginBloc>(
      bloc: _loginBloc,
      child: MaterialApp(
        title: "Corwey Application",
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            fontFamily: "Montserrat"),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.routeName,
        onGenerateRoute: _generateRoute,
        onUnknownRoute: _unknownRoute,
      ),
    );
  }

  Route _unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => PageNotFound());
  }

  Route _generateRoute(RouteSettings settings) {
    print('generateRoute: ' + settings.name);
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(
            builder: (context) => LoginPage(loginBloc: _loginBloc));
      case MainPage.routeName:
        return MaterialPageRoute(builder: (context) => MainPage());
      default:
        return _unknownRoute(settings);
    }
  }
}
