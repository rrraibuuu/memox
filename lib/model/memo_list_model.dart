import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memox/entity/memo_entity.dart';
import 'package:shake/shake.dart';

class MemoListModel extends ChangeNotifier {
  List<MemoEntity> memos = [];
  List<String> backUpList;
  String backUp;

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

  shakeGesture(BuildContext context) {
    ShakeDetector detector = ShakeDetector.waitForStart(onPhoneShake: () {
      showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: Text(
                  "メモをシャッフルしますか？",
                  style: TextStyle(
                      fontWeight: FontWeight.w100, fontFamily: "Font"),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      "はい",
                      style: TextStyle(color: Colors.black, fontFamily: "Font"),
                    ),
                    onPressed: () => shuffleMemo(),
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      "いいえ",
                      style: TextStyle(color: Colors.black, fontFamily: "Font"),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ));
    });
    detector.startListening();
  }

  shuffleMemo() async {

    bool shuffleFlg = true;
    List<String> backUpList;

    if (shuffleFlg) {

      for (int i = 0; memos.length <= i; i++) {

        backUp = memos[i].body;
        backUpList.add(backUp);

        String afterMemo = stringShuffle(memos[i].body);

        final document =
        Firestore.instance.collection('memo').document(memos[i].documentID);
        await document.update({
          'body': afterMemo,
        });

      }

      shuffleFlg = false;

    } else {

      for (int i = 0; memos.length <= i; i++) {

        String beforeMemo = backUpList[i];

        final document =
        Firestore.instance.collection('memo').document(memos[i].documentID);
        await document.update({
          'body': beforeMemo,
        });

      }

    }

  }

  String stringShuffle(String body) {

    List shuffleMemos = body.split('');
    shuffleMemos.shuffle();
    String afterMemo = shuffleMemos.join();

    return afterMemo;

  }
}
