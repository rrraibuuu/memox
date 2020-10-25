import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:memox/screens/memo_list_screen.dart';
import 'package:shake/shake.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "memox",
      theme: ThemeData(
        fontFamily: "Font",
      ),
      home: MemoListScreen(),
    );
  }
}
