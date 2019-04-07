import 'package:corwey_flutter/SmsRuProvider.dart';
import 'package:meta/meta.dart';

enum UserRole { tenant, homeowner }

class UserRepository {
  final _smsProvider = SmsRuProvider();

  Future<String> sendVerificationSMS({@required String phone}) async {
    return _smsProvider.sendMessage(phone: phone);
  }

  Future<String> authenticate({
    @required String phone,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }

  Future<void> deleteUserRole() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistUserRole({UserRole userRole}) async {
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasUserRole() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
