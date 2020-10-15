
import 'package:cloud_firestore/cloud_firestore.dart';

class MemoEntity {

  MemoEntity(this.title, this.body, this.date);

  String title;
  String body;
  DateTime date;

}