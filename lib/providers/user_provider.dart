import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal/models/user_model.dart';
import 'package:meal/preferences/userpreferences.dart';

class UserProvider /* with ChangeNotifier*/ {
  CollectionReference _db = Firestore.instance.collection("users");
  final prefs = new UserPreferences();

  insertUser() async {
    UserModel user = UserModel();
    user.idUser = prefs.uid;
    user.phone = prefs.phone;
    user.ready = false;
    user.tokenFCM = prefs.tokenFCM;
    await _db.document(prefs.uid).setData(user.toJson());

    return true;
  }

  getUser(String phone) async {
    UserModel user = UserModel();
    final res = await _db.where('phone', isEqualTo: phone).getDocuments();
    user = userModelFromJson(jsonEncode(res.documents[0].data));
    return user;
  }

  readyUser(String idUser, bool ready) async {
    return await _db.document(idUser).updateData({"ready": ready});
  }
}
