import 'package:corwey_flutter/SmsRuProvider.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserRole { tenant, homeowner }

class UserRepository {
  final _token = 'token';
  final _userRole = 'userRole';

  final _smsProvider = SmsRuProvider();

  // отправка смс и возврат кода, который отправлен
  Future<String> sendVerificationSMS({@required String phone}) async {
    //return _smsProvider.sendMessageStub(phone: phone);
    return _smsProvider.sendMessage(phone: phone);
  }

  Future<String> authenticate({@required String phone}) async {
    await Future.delayed(Duration(seconds: 1));
    return 'authToken';
  }

  // удаление токена из хранилища
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_token);
    return;
  }

  // сохранение токена в хранилище
  Future<void> persistToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_token, token);
    return;
  }

  // проверка наличия токена
  Future<bool> hasToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(_token) != null ? true : false;
  }

  // удаление сохраненной роли
  Future<void> deleteUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_userRole);
    return;
  }

  // сохранение роли
  Future<void> persistUserRole({UserRole userRole}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_userRole, userRole.toString());
    return;
  }

  // проверка наличия роли
  Future<bool> hasUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(_userRole) != null ? true : false;
  }

  // получение роли
  Future<UserRole> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_userRole);
    return UserRole.values.firstWhere((e) => e.toString() == value);
  }
}
