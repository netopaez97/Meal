import 'package:http/http.dart' as http;

class SmsProvider {
  static String chargeServerHost = "https://mealkc.herokuapp.com";
  final String chargeUrl = "$chargeServerHost/sms";
  sendSms(String guestNumber, String textMessage) {
    http.post(chargeUrl, body: {
      "guestNumber": guestNumber,
      "textMessage": textMessage,
    });
  }
}
