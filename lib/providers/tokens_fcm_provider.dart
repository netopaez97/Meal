import 'package:cloud_firestore/cloud_firestore.dart';

class TokensFCMProvider {

  CollectionReference _dbAdmin = Firestore.instance.collection("tokenAdmin");

  Future getAllTheAdminsTokens() async {
    print((await _dbAdmin.getDocuments()).documents);
    return (await _dbAdmin.getDocuments()).documents;
  }
  
}