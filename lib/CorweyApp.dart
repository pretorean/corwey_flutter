import 'package:corwey_flutter/LoginPage.dart';
import 'package:flutter/material.dart';

class CorweyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Corwey Application",
      theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          fontFamily: "Montserrat"
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPageActivity(),
    );
  }
}
