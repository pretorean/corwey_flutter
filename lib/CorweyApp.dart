import 'package:corwey_flutter/UserRepository.dart';
import 'package:corwey_flutter/pages/LoginPage.dart';
import 'package:corwey_flutter/pages/MainPage.dart';
import 'package:corwey_flutter/pages/NotFoundPage.dart';
import 'package:flutter/material.dart';

class CorweyApp extends StatelessWidget {
  final UserRepository userRepository;

  CorweyApp({
    Key key,
    @required this.userRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Corwey Application",
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat"),
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) =>
            LoginPage(userRepository: userRepository),
        MainPage.routeName: (context) => MainPage(),
      },
      onUnknownRoute: _unknownRoute,
    );
  }

  Route _unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => PageNotFound());
  }
}

class CorweyAppOld extends StatefulWidget {
  final UserRepository userRepository;

  CorweyAppOld({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<CorweyAppOld> createState() => _CorweyAppOldState();
}

class _CorweyAppOldState extends State<CorweyAppOld> {
  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _builderFunction(context);
  }

  Widget _builderFunction(BuildContext context) {
    return MaterialApp(
      title: "Corwey Application",
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat"),
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.routeName,
      routes: {
        LoginPage.routeName: (context) =>
            LoginPage(userRepository: _userRepository)
      },
      onGenerateRoute: _generateRoute,
    );
  }

  Route _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainPage.routeName:
        return MaterialPageRoute(builder: (context) => MainPage());
      case LoginPage.routeName:
        return MaterialPageRoute(
            builder: (context) => LoginPage(userRepository: _userRepository));
    }

//    if (state is AuthenticationAuthenticated) {
//    switch (settings.name) {
//      case '/':
//        return MaterialPageRoute(builder: (context) => MainPage());
//    }
//    }

//    if (state is AuthenticationUninitialized) {
//      return MaterialPageRoute(builder: (context) => SplashPage());
//    }

//    if (state is AuthenticationUnauthenticated) {
//      return MaterialPageRoute(
//          builder: (context) => LoginPage(userRepository: _userRepository));
//    }
//    if (state is AuthenticationLoading) {
//      return MaterialPageRoute(builder: (context) => LoadingIndicator());
//    }
    return null;
  }
}
