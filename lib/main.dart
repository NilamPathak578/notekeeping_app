import 'package:flutter/material.dart';
import 'package:notekeep_app/inherited_widgets/note_inherited_widgets.dart';
import 'package:notekeep_app/views/notelist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoteInheritedWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NoteKeep App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NoteList(),
      ),
    );
  }
}
