import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class PushNotificationProvider {
  // Replace with server token from firebase console settings.
  final String serverToken =
      'AAAAkWqDPv0:APA91bFV_69oRn4hTcZDLxD41-iM5vSr6Gto_DfwEtUc36Xcf9i1qCKjJld2g_MH6PUcyLy2Q0uT4ppceLwTH1lbjcDrsyP7z16uq0Ckq6_-r2W-Dqz2EIS49qpm_D1dfAIozw_uGxi5';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

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
