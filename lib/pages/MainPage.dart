import 'package:corwey_flutter/bloc/AuthenticationBloc.dart';
import 'package:corwey_flutter/events/AuthenticationEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
    BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: RaisedButton(
              child: Text('logout'),
              onPressed: () {
                authenticationBloc.dispatch(LoggedOut());
              },
            )),
      ),
    );
  }
}
