import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:memox/entity/memo_entity.dart';
import 'package:memox/model/memo_edit_model.dart';
import 'package:memox/screens/memo_list_screen.dart';
import 'package:provider/provider.dart';

class MemoEditScreen extends StatelessWidget {
  MemoEditScreen(this.memo);

  final MemoEntity memo;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    titleController.text = memo.title;
    bodyController.text = memo.body;

    return ChangeNotifierProvider<MemoEditModel>(
      create: (_) => MemoEditModel(memo.title, memo.body),
      child: Consumer<MemoEditModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white10,
            elevation: 0.0,
            leading: IconButton(
              icon: Icon(
                LineIcons.arrow_left,
                color: Colors.black38,
              ),
              onPressed: () => updateMemo(model, context),
            ),
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
                    controller: titleController,
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
                    controller: bodyController,
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
    );
  }

  Future updateMemo(MemoEditModel model, BuildContext context) async {
    await model.updateMemoToFirebase(memo);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MemoListScreen()),
    );
  }
}
