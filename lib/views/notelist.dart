import 'package:flutter/material.dart';
import 'package:notekeep_app/provider/note_provider.dart';

import 'package:notekeep_app/views/note.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Keep Note",
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      body: FutureBuilder(
        future: NoteProvider().getNoteList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final notes = snapshot.data;
            return ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Note(NoteMode.Editing, notes[index])));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, bottom: 30.0, left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _Notetitle(notes[index]['title']),
                          Divider(height: 12.0),
                          _Notetext(notes[index]['text']),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: notes.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Note(NoteMode.Adding, null)));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _Notetitle extends StatelessWidget {
  final String _title;
  _Notetitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
    );
  }
}

class _Notetext extends StatelessWidget {
  final String _text;
  _Notetext(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(fontSize: 20.0, color: Colors.grey.shade600),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
