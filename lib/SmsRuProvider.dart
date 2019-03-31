class SmsRuProvider {
  // отправляет сообщение и возвращает код, который отправлен
  Future<String> sendMessage() async {
    await Future.delayed(Duration(seconds: 1));
    return _generateCode();
  }

  String _generateCode() => '1111';
}
