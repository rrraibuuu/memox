import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memox/entity/memo_entity.dart';

class MemoEditModel extends ChangeNotifier {
  MemoEditModel(this.title, this.body);
  String title = "";
  String body = "";
  DateTime date = DateTime.now();
  String memoBackUp = "";

  Future updateMemoToFirebase(MemoEntity memo) async {
    final document =
    Firestore.instance.collection('memo').document(memo.documentID);
    await document.update({
      'title': title,
      'body': body,
      'date': date,
    });
  }

  Future shuffleMemo(MemoEntity memo) async {

    final document =
    Firestore.instance.collection('memo').document(memo.documentID);
    await document.update({
      'title': title,
      'body': body,
      'date': date,
    });

  }

}
