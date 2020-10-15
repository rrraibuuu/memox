import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memox/entity/memo_entity.dart';

class MemoListModel extends ChangeNotifier {
  List<MemoEntity> memos = [];

  Future fetchMemos() async {
    final docs = await Firestore.instance.collection('memo').get();

    final memos = docs.docs
        .map((doc) =>
            MemoEntity(doc['title'], doc['body'], doc['date'].toDate()))
        .toList();

    this.memos = memos;
    notifyListeners();
  }
}
