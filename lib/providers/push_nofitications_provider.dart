import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/providers/tokens_fcm_provider.dart';

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

    final TokensFCMProvider _tokenFCMProvider = TokensFCMProvider();
    List<DocumentSnapshot> _listOfTokenSnap = await _tokenFCMProvider.getAllTheAdminsTokens();

    List<String> _listOfToken = [];
    _listOfTokenSnap.forEach((value){
      _listOfToken.add(value.data["token"]);
    });
    
    ///Look at all the admin tokens available
    

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
          'registration_ids': _listOfToken,
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
