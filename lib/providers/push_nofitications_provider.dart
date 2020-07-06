import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:meal/preferences/userpreferences.dart';

class PushNotificationProvider {
  // Replace with server token from firebase console settings.
  final String serverToken =
      'AAAAkWqDPv0:APA91bFV_69oRn4hTcZDLxD41-iM5vSr6Gto_DfwEtUc36Xcf9i1qCKjJld2g_MH6PUcyLy2Q0uT4ppceLwTH1lbjcDrsyP7z16uq0Ckq6_-r2W-Dqz2EIS49qpm_D1dfAIozw_uGxi5';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  static int contador = 0;
  UserPreferences _userPreferences = UserPreferences();

  final _mensajesStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications() {
    firebaseMessaging.requestNotificationPermissions();
    firebaseMessaging.getToken().then((token) {

      print('====== FCM Token ======');
      print(token);

      if(_userPreferences.tokenFCM == null || _userPreferences.tokenFCM == ''){
        _userPreferences.tokenFCM = token;
        print("The user toker in preferences is: ${_userPreferences.tokenFCM}");
      }
      print("The user toker in preferences is: ${_userPreferences.tokenFCM}");
    });
    firebaseMessaging.configure(
      onMessage: (info) async {
        if (contador == 0) {
          print('====== On Message ======');
          print(info);
          String argumento = 'Message';
          _mensajesStreamController.sink.add(argumento);
          contador++;
        } else {
          contador = 0;
        }
      },
      onLaunch: (info) async {
        if (contador == 0) {
          print('====== On Launch ======');
          print(info);
          String argumento = 'Launch';
          _mensajesStreamController.sink.add(argumento);
        } else {
          contador = 0;
        }
      },
      onResume: (info) async {
        if (contador == 0) {
          print('====== On Resume ======');
          print(info);

          String argumento = 'Resume';

          _mensajesStreamController.sink.add(argumento);
        } else {
          contador = 0;
        }
      },
    );
  }

  dispose() {
    _mensajesStreamController?.close();
  }

  Future<Map<String, dynamic>> sendAndRetrieveMessage() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'title': 'New order!',
            'body':
                'There is a new order waiting to be delivered! Tap for more details.'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            // 'id': '1',
            // 'status': 'done'
          },
          //'restricted_package_name': 'com.netopaez.meal_admin',
          'registration_ids': [
            'cHkFjasmRE2CaoBhpiYT-c:APA91bEZTt-UGUaX9W0uJMceeZEv8-cymoZXrFOM5aSmAYuPjYZqPafI8t_LcoAI4vWNG4wjMtBJFU4KiFY0wrJpU0kZ5mUXV856-p5ygcM90Hhr9gBp_qharFeU3Oh3HW1VujRYYgH1',
            'c7XGJBuHKe_LbidKny5Xa8:APA91bFqRPS0U2I1CfIzXEwRTqbu76lqtccKF5z76yvPSyvc83T2DUwr8Qn6GDmccuO8vJfcrwuzbxLc4zvxvX-BbCi7xMOu2HjX6N3OF4UcOfj-3D78cMqMSwHU8So9awU_dcLaZiZi'
          ],
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }
}
