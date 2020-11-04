import 'package:cloud_firestore/cloud_firestore.dart';

class MemoEntity {

  MemoEntity(DocumentSnapshot doc) {
    documentID = doc.documentID;
    title = doc['title'];
    body = doc['body'];
    date = doc['date'];
  }

  String documentID = "";
  String title = "";
  String body = "";
  Timestamp date = Timestamp.now();

}