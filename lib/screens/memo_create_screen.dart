import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:memox/model/memo_create_model.dart';
import 'package:provider/provider.dart';

import 'memo_list_screen.dart';

class MemoCreateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MemoCreateModel>(
      create: (_) => MemoCreateModel(),
      child: SafeArea(
        child: Consumer<MemoCreateModel>(builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white10,
              title: Text(
                "新規作成",
                style: TextStyle(color: Colors.black),
              ),
              elevation: 0.0,
              leading: IconButton(
                icon: Icon(
                  LineIcons.close,
                  color: Colors.black38,
                ),
                onPressed: () => showDialog(
                    context: context,
                    builder: (context) => _deleteDialog(context)),
              ),
              actions: [
                IconButton(
                    padding: EdgeInsets.only(right: 17.0),
                    icon: Icon(
                      LineIcons.check,
                      color: Colors.black38,
                    ),
                    onPressed: () {
                      model.createMemoToFirebase();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MemoListScreen()),
                      );
                    }),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (title) {
                        model.title = title;
                      },
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                      cursorColor: Colors.black,
                      maxLength: 15,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        labelText: "題名",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      onChanged: (body) {
                        model.body = body;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      cursorColor: Colors.black,
                      maxLength: 140,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        labelText: "本文",
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _deleteDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        "削除しますか？",
        style: TextStyle(fontWeight: FontWeight.w100, fontFamily: "Font"),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(
            "はい",
            style: TextStyle(color: Colors.black, fontFamily: "Font"),
          ),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MemoListScreen()),
          ),
        ),
        CupertinoDialogAction(
          child: Text(
            "いいえ",
            style: TextStyle(color: Colors.black, fontFamily: "Font"),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
