import 'package:corwey_flutter/bloc/LoginBloc.dart';
import 'package:corwey_flutter/events/LoginEvents.dart';
import 'package:corwey_flutter/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  static const String routeName = '/main';

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: RaisedButton(
          child: Text('logout'),
          onPressed: () {
            loginBloc.dispatch(LoggedOut());
            Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
          },
        )),
      ),
    );
  }
}
