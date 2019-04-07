import 'package:corwey_flutter/bloc/LoginBloc.dart';
import 'package:corwey_flutter/events/LoginEvents.dart';
import 'package:corwey_flutter/items/ItemDetails.dart';
import 'package:corwey_flutter/items/ItemListing.dart';
import 'package:corwey_flutter/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  static const String routeName = 'main';

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Corwey'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              loginBloc.dispatch(LoggedOut());
              Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ItemListing(
          itemSelectedCallback: (item) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ItemDetails(
                    isInTabletLayout: false,
                    item: item,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
