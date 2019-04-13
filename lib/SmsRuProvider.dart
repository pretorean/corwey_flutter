import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class SmsRuProvider {
  final String baseUrl =
      'https://sms.ru/sms/send?api_id=65B77E45-C928-DB0C-5CFB-A76562537082';

  // эмуляция отправки сообщения
  Future<String> sendMessageStub({@required String phone}) async {
    Future.delayed(Duration(seconds: 1));
    return '1111';
  }

  // отправляет сообщение и возвращает код, который отправлен
  Future<String> sendMessage({@required String phone}) async {
    String code = _generateCode();
    String requestText = '&to=$phone&msg=Код+подтверждения:+$code&json=1';

    var response = await http.get(baseUrl + requestText);

    if (response.statusCode != 200)
      throw Exception(
          'Не удалось отправить СМС. Ошибка http $response.statusCode');
    final answer = jsonDecode(response.body);
    final statusCode = answer['status_code'];
    if (statusCode != 100)
      throw Exception('Не удалось отправить СМС. Ошибка шлюза $statusCode');
    return code;
  }

  // случайный код для отправки в сообщении
  String _generateCode() {
    return Random().nextInt(99999).toString().padLeft(5, '0');
  }
}
