import 'package:flutter/material.dart';
import 'package:notekeep_app/inherited_widgets/note_inherited_widgets.dart';
import 'package:notekeep_app/provider/note_provider.dart';

enum NoteMode { Editing, Adding }

class Note extends StatefulWidget {
  final NoteMode noteMode;
  final Map<String, dynamic> note;
  Note(this.noteMode, this.note);

  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
  List<Map<String, String>> get _notes => NoteInheritedWidget.of(context).notes;
  @override
  void didChangeDependencies() {
    if (widget.noteMode == NoteMode.Editing) {
      _titleController.text = widget.note['title'];
      _textController.text = widget.note['text'];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.noteMode == NoteMode.Adding ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: "Note Title"),
            ),
            Divider(
              height: 10.0,
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(hintText: "Note Text"),
            ),
            Divider(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _NoteButton('Save', Colors.blue, () {
                  final title = _titleController.text;
                  final text = _textController.text;
                  if (widget?.noteMode == NoteMode.Adding) {
                    NoteProvider().insertNote({
                      'title': title,
                      'text': text,
                    });
                  } else if (widget?.noteMode == NoteMode.Editing) {
                    NoteProvider().updatetNote({
                      'id': widget.note['id'],
                      'title': _titleController.text,
                      'text': _textController.text
                    });
                  }
                  Navigator.pop(context);
                }),
                _NoteButton('Discard', Colors.grey, () {
                  Navigator.pop(context);
                }),
                widget.noteMode == NoteMode.Editing
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _NoteButton('Delete', Colors.red, () async {
                          await NoteProvider().deletenote(widget.note['id']);
                          Navigator.pop(context);
                        }),
                      )
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onpressed;

  _NoteButton(this.text, this.color, this.onpressed);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(color: Colors.blue),
      ),
      color: color,
    );
  }
}
