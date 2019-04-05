import 'package:corwey_flutter/bloc/LoginBloc.dart';
import 'package:corwey_flutter/events/LoginEvents.dart';
import 'package:corwey_flutter/states/LoginStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexed_validator/regexed_validator.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState state,
      ) {
        if (state is LoginFailure) {
          _onWidgetDidBuild(() {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }

        if (state is LoginGetPhoneNumber) return _phoneNumberWidgets();
        if (state is LoginGetVerifyCode) return _verifyCodeWidgets(state);

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  Widget _phoneNumberWidgets() {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Введите номер телефона',
                    style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(prefixIcon: Icon(Icons.phone)),
                  keyboardType: TextInputType.number,
                  controller: _phoneController,
                ),
              ],
            ),
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
                onPressed: _phoneNumberEntered,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _phoneNumberEntered() {
    if (validator.phone(_phoneController.text))
      _loginBloc.dispatch(
        LoginPhoneNumberEntered(phone: _phoneController.text),
      );
    else
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Введите номер телефона'),
        backgroundColor: Colors.red,
      ));
  }

  Widget _verifyCodeWidgets(LoginGetVerifyCode state) {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Введите код из СМС', style: TextStyle(fontSize: 18.0)),
                SizedBox(height: 20.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _codeController,
                ),
              ],
            ),
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
                onPressed: () {
                  _verifyCodeEntered(state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _verifyCodeEntered(LoginGetVerifyCode state) {
    if (state.code == _codeController.text)
      _loginBloc.dispatch(
        LoginVerifyCodeEntered(phone: _phoneController.text),
      );
    else
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Введенный код не верен'),
        backgroundColor: Colors.red,
      ));
  }
}
