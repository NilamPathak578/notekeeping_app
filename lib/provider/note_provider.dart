import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteProvider {
  static Database db;

  static Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'notes.db'),
        version: 1, onCreate: (Database db, int version) async {
      db.execute('''
          create table Notes(
            id integer primary key autoincrement,
            title text not null,
            text text not null
          );
        ''');
    });
  }

  Future<List<Map<String, dynamic>>> getNoteList() async {
    if (db == null) {
      await open();
    }
    return await db.query('Notes');
  }

  Future insertNote(Map<String, dynamic> note) async {
    await db.insert('Notes', note);
  }

  Future updatetNote(Map<String, dynamic> note) async {
    await db.update('Notes', note, where: 'id = ?', whereArgs: [note['id']]);
  }

  Future deletenote(int id) async {
    await db.delete('Notes', where: 'id = ?', whereArgs: ['id']);
  }
}
