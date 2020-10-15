import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:memox/model/memo_list_model.dart';
import 'package:memox/screens/memo_edit_screen.dart';
import 'package:provider/provider.dart';

import 'memo_create_screen.dart';

class MemoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemoListModel>(
      create: (_) =>
      MemoListModel()
        ..fetchMemos(),
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
                (memo) =>
                ListTile(
                  title: Text(
                    memo.title,
                    style:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(memo.date.toString().substring(0, 16)),
                  onTap: () => _editScreenView(context),
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
          onPressed: () => _createScreenView(context),
        ),
      ),
    );
  }

  _createScreenView(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MemoCreateScreen(), fullscreenDialog: true),
    );
  }

  _editScreenView(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MemoEditScreen(),),
    );
  }

}
