import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memox/entity/memo_entity.dart';

class MemoCreateModel extends ChangeNotifier {

  String title = "";
  String body = "";
  DateTime date = DateTime.now();

  Future createMemoToFirebase() async {
    if (title.isEmpty) {
      throw("題名を入力してください。");
    }
    Firestore.instance.collection('memo').add({
      'title': title,
      'body': body,
      'date': date,
    });
  }

}