import 'package:flutter/foundation.dart';

import '../models/notes.dart';
import '../database/text_db.dart';

class NotesProvider with ChangeNotifier {
  List<Notes> _notes = [];

  List<Notes> get notes {
    return [..._notes];
  }

  Notes findById(String id) {
    return _notes.firstWhere((note) => note.id == id);
  }

  Future<void> addNotes(Notes notes) async {
    final timestamp = DateTime.now();

    final newNote = Notes(
      id: timestamp.toString().toLowerCase(),
      title: notes.title,
      textContent: notes.textContent,
      dateTime: DateTime.now(),
    );

    _notes.add(newNote);
    notifyListeners();
    TextDB.insertData(
      'user_notes',
      {
        'id': timestamp.toString().toLowerCase(),
        'title': newNote.title.toString(),
        'textContent': newNote.textContent.toString(),
        'dateTime': timestamp.toIso8601String(),
      },
    );
  }

  Future<void> loadAndSetNotes() async {
    final dataList = await TextDB.getData('user_notes');
    _notes = dataList
        .map(
          (note) => Notes(
            id: note['id'].toString().toLowerCase(),
            title: note['title'],
            textContent: note['textContent'],
            dateTime: DateTime.parse(note['dateTime']),
          ),
        )
        .toList();
    _notes.reversed;
    notifyListeners();
  }

  Future<void> updateNote(String id, Notes editedNote) async {
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      TextDB.insertData(
        'user_notes',
        {
          'id': editedNote.id.toString().toLowerCase(),
          'title': editedNote.title.toString(),
          'textContent': editedNote.textContent.toString(),
          'dateTime': editedNote.dateTime.toString(),
        },
      );
      _notes[noteIndex] = editedNote;
      notifyListeners();
    } else {
      return;
    }
  }

  Future<void> deleteNote(String id) async {
    final existingNoteIndex = _notes.indexWhere((note) => note.id == id);

    _notes.removeAt(existingNoteIndex);

    final db = await TextDB.database();
    await db.delete(
      'user_notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    print('DELETED: ${id}');
    notifyListeners();
  }
}
