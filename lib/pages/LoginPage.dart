import 'package:corwey_flutter/UserRepository.dart';
import 'package:corwey_flutter/bloc/LoginBloc.dart';
import 'package:corwey_flutter/events/LoginEvents.dart';
import 'package:corwey_flutter/pages/LoadingWidget.dart';
import 'package:corwey_flutter/pages/MainPage.dart';
import 'package:corwey_flutter/pages/SplashWidget.dart';
import 'package:corwey_flutter/states/LoginStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexed_validator/regexed_validator.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = 'login';

  final LoginBloc loginBloc;

  LoginPage({
    Key key,
    @required this.loginBloc,
  })  : assert(loginBloc != null),
        super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<LoginEvent, LoginState>(
            bloc: _loginBloc, builder: _handleStates),
      ),
    );
  }

  Widget _handleStates(BuildContext context, LoginState state) {
    // показ заставки
    if (state is LoginSplash) return SplashWidget();

    // показ индикатора загрузки
    if (state is LoginLoading) return LoadingWidget();

    // показ форм ввода
    if (state is LoginGetPhoneNumber) return _phoneNumberWidgets();
    if (state is LoginGetVerifyCode) return _verifyCodeWidgets(state);

    // показ выбора роли
    if (state is LoginSelectRole) return _selectRoleWidgets(state);

    // переход на главное окно
    if (state is LoginAuthenticated)
      _onWidgetDidBuild(() {
        Navigator.of(context).pushReplacementNamed(MainPage.routeName);
      });

    // показ ошибки
    if (state is LoginFailure)
      _onWidgetDidBuild(() {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.red,
          ),
        );
      });

    return _buildStub();
  }

  Center _buildStub() {
    return Center(
      child: CircularProgressIndicator(),
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

  Widget _selectRoleWidgets(LoginSelectRole state) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image(
            height: 180.0,
            image: AssetImage('assets/images/select_role_head.png'),
          ),
          Container(
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.purple,
              borderRadius: new BorderRadius.all(new Radius.circular(40.0)),
            ),
            child: Center(
              child: Text(
                'Выберите кто Вы?',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          SizedBox(
            height: 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text(
                      'Арендатор',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      _userRoleSelectClick(state, UserRole.tenant);
                    },
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    child: Text(
                      'Собственник',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.deepOrange,
                    textColor: Colors.black,
                    onPressed: () {
                      _userRoleSelectClick(state, UserRole.homeowner);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _userRoleSelectClick(LoginSelectRole state, UserRole userRole) {
    _loginBloc
        .dispatch(LoginRoleSelected(userRole: userRole, phone: state.phone));
  }
}
