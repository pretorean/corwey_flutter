import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class SmsRuProvider {
  final String baseUrl =
      'https://sms.ru/sms/send?api_id=65B77E45-C928-DB0C-5CFB-A76562537082';

  // отправляет сообщение и возвращает код, который отправлен
  Future<String> sendMessage({@required String phone}) async {
    String code = _generateCode();
    String requestText = '&to=$phone&msg=Код+подтверждения:+$code&json=1';

    var response = await http.get(baseUrl + requestText);
    if (response.statusCode == 200)
      return code;
    else {
      throw Exception('Не удалось отправить СМС');
    }
  }

  String _generateCode() {
    return Random().nextInt(99999).toString().padLeft(5, '0');
  }
}
