import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memox/entity/memo_entity.dart';
import 'package:shake/shake.dart';

class MemoListModel extends ChangeNotifier {
  List<MemoEntity> memos = [];

  Future fetchMemos() async {
    final docs = await Firestore.instance.collection('memo').get();

    final memos = docs.docs.map((doc) => MemoEntity(doc)).toList();

    memos.sort((a, b) => b.date.compareTo(a.date));

    this.memos = memos;
    notifyListeners();
  }

  Future deleteMemo(MemoEntity memo) async {
    await Firestore.instance.collection('memo').doc(memo.documentID).delete();
  }

  shakeGesture() {
    ShakeDetector detector = ShakeDetector.waitForStart(onPhoneShake: () {
      showDialog(
          builder: (context) => CupertinoAlertDialog(
                title: Text(
                  "テストダイアログ",
                  style: TextStyle(
                      fontWeight: FontWeight.w100, fontFamily: "Font"),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      "はい",
                      style: TextStyle(color: Colors.black, fontFamily: "Font"),
                    ),
                  ),
                ],
              ));
    });
    detector.startListening();
  }
}
