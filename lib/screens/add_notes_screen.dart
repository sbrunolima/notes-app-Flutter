import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Here all other files
import '../providers/notes_provider.dart';
import '../models/notes.dart';
import '../widgets/save_pop_dialog.dart';
import '../widgets/delete_pop_dialog.dart';

class AddNotesScreen extends StatefulWidget {
  static const routeName = '/add-notes';

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final _form = GlobalKey<FormState>();
  //Variables to identify if the title or content are empty
  var hasContent = '';

  var opendNoteId;
  //Variables to verify if it is a new note or editing a existing note
  var editing = false;
  var isFirst = true;
  var _newNote = Notes(
    id: null,
    title: '',
    textContent: '',
    dateTime: DateTime.now(),
  );

  var _initialValues = {
    'title': '',
    'textContent': '',
    'dateTime': DateTime.now(),
  };

  var _isInit = true;

  @override
  void didChangeDependencies() {
    final noteId = ModalRoute.of(context)!.settings.arguments;
    opendNoteId = noteId.toString();
    if (noteId != null) {
      _newNote = Provider.of<NotesProvider>(context, listen: false)
          .findById(noteId.toString());
      _initialValues = {
        'title': _newNote.title.toString(),
        'textContent': _newNote.textContent.toString(),
        'dateTime': _newNote.dateTime.toString(),
      };
      isFirst = false;
      editing = true;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _saveNote() async {
    _form.currentState!.save();

    if (_newNote.id != null) {
      await Provider.of<NotesProvider>(context, listen: false)
          .updateNote(_newNote.id.toString(), _newNote);
    } else {
      await Provider.of<NotesProvider>(context, listen: false)
          .addNotes(_newNote);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (hasContent.toString().isNotEmpty && editing) {
          _saveNote();
          savePopDialog(context, 'Nota salva', false);
        } else if (hasContent.toString().isNotEmpty && isFirst) {
          _saveNote();
          savePopDialog(context, 'Nota salva', false);
        }

        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          shape: const Border(bottom: BorderSide(color: Colors.white24)),
          backgroundColor: Colors.grey.shade900,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                Icons.check,
                color: (hasContent.toString().isNotEmpty || editing)
                    ? Colors.orange
                    : Colors.grey,
              ),
              onPressed: (hasContent.toString().isNotEmpty || editing)
                  ? () {
                      _saveNote();
                      savePopDialog(context, 'Nota salva', false);
                    }
                  : null,
            ),
            const SizedBox(width: 5),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: (hasContent.toString().isNotEmpty || editing)
                    ? Colors.red
                    : Colors.grey,
              ),
              onPressed: (hasContent.toString().isNotEmpty || editing)
                  ? () async {
                      popUpDialog(context, opendNoteId);
                    }
                  : null,
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: Form(
          key: _form,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  initialValue: _initialValues['title'].toString(),
                  onChanged: (value) {
                    setState(() {
                      hasContent = value.toString();
                    });
                  },
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    labelStyle: GoogleFonts.roboto(
                      fontSize: 24,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                    ),
                    labelText: 'Título',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onSaved: (value) {
                    _newNote = Notes(
                      id: _newNote.id,
                      title: value.toString(),
                      textContent: _newNote.textContent,
                      dateTime: _newNote.dateTime,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: TextFormField(
                      initialValue: _initialValues['textContent'].toString(),
                      onChanged: (value) {
                        setState(() {
                          hasContent = value.toString();
                        });
                      },
                      style: GoogleFonts.roboto(
                          color: Colors.white, height: 1.5, fontSize: 15),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        labelStyle: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        label: Column(
                          children: const [
                            Text('Conteúdo'),
                          ],
                        ),
                      ),
                      textCapitalization: TextCapitalization.words,
                      maxLines: 1000,
                      onSaved: (value) {
                        _newNote = Notes(
                          id: _newNote.id,
                          title: _newNote.title,
                          textContent: value.toString(),
                          dateTime: _newNote.dateTime,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
