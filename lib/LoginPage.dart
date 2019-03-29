import 'package:flutter/material.dart';

class LoginPageActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: _LoginForm()),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Введите номер телефона и код из СМС',
                      style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(prefixIcon: Icon(Icons.phone)),
                    keyboardType: TextInputType.number,
                    validator: _phoneFieldValidate,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: _codeFieldValidate,
                  ),
                  SizedBox(height: 100.0),
                  SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child: RaisedButton(
                        child: Text(
                          'Подтвердить',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: _submitButtonClick,
                      ))
                ])));
  }

  _submitButtonClick() {
    if (_formKey.currentState.validate())
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Форма успешно заполнена'),
        backgroundColor: Colors.green,
      ));
  }

  String _phoneFieldValidate(String value) {
    if (value.isEmpty) return 'Введите номер телефона';
    return null;
  }

  String _codeFieldValidate(String value) {
    return null;
  }
}
