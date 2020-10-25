import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:line_icons/line_icons.dart';
import 'package:memox/entity/memo_entity.dart';
import 'package:memox/model/memo_list_model.dart';
import 'package:memox/screens/memo_edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';

import 'memo_create_screen.dart';

class MemoListScreenFul extends StatefulWidget {
  @override
  _MemoListScreenFulState createState() => _MemoListScreenFulState();
}

class _MemoListScreenFulState extends State<MemoListScreenFul> {
  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(onPhoneShake: () {
      showDialog(
          context: context,
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
  }

  @override
  Widget build(BuildContext context) {
    return MemoListScreen();
  }
}

class MemoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemoListModel>(
      create: (_) => MemoListModel()..fetchMemos(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white10,
            flexibleSpace: Container(
              child: Center(
                child: Text(
                  "一覧",
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                ),
              ),
            ),
            elevation: 0.0,
          ),
        ),
        body: Consumer<MemoListModel>(builder: (context, model, child) {
          final memos = model.memos;
          final listTiles = memos
              .map(
                (memo) => Slidable(
                  secondaryActions: [
                    IconSlideAction(
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => _deleteMemo(context, model, memo),
                    ),
                  ],
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: ListTile(
                      title: Text(
                        memo.title,
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      trailing:
                          Text(memo.date.toDate().toString().substring(0, 16)),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemoEditScreen(memo),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
              .toList();
          return ListView(
            children: listTiles,
          );
        }),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            LineIcons.plus,
            color: Colors.black38,
          ),
          backgroundColor: Colors.white10,
          elevation: 0.0,
          tooltip: "新規追加",
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MemoCreateScreen(),
                fullscreenDialog: true),
          ),
        ),
      ),
    );
  }

  _deleteMemo(BuildContext context, MemoListModel model, MemoEntity memo) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(
                "削除しますか？",
                style:
                    TextStyle(fontWeight: FontWeight.w100, fontFamily: "Font"),
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text(
                    "はい",
                    style: TextStyle(color: Colors.black, fontFamily: "Font"),
                  ),
                  onPressed: () async {
                    await model.deleteMemo(memo);
                    await model.fetchMemos();
                    Navigator.pop(context);
                  },
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
  }
}
