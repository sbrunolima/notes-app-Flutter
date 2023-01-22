import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/notes_provider.dart';
import '../providers/colors_provider.dart';
import '../providers/language_provider.dart';

//Widgets
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<ThemeProvider>(context).loadAndSetTheme();
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
    final themeData = Provider.of<ThemeProvider>(context, listen: false);
    final locale = Provider.of<AppLanguageProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        if (hasContent.toString().isNotEmpty && editing) {
          _saveNote();
          savePopDialog(
              context, locale.language[0].savePoput!.toString(), false);
        } else if (hasContent.toString().isNotEmpty && isFirst) {
          _saveNote();
          savePopDialog(
              context, locale.language[0].savePoput!.toString(), false);
        }

        return true;
      },
      child: Scaffold(
        backgroundColor: themeData.themeColor[0].colorID == '1'
            ? Colors.black
            : Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: themeData.themeColor[0].colorID == '1'
                ? Colors.white
                : Colors.black,
          ),
          shape: Border(
            bottom: BorderSide(
              color: themeData.themeColor[0].colorID == '1'
                  ? Colors.white24
                  : Colors.grey.shade200,
            ),
          ),
          backgroundColor: themeData.themeColor[0].colorID == '1'
              ? Colors.black
              : Colors.white,
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
                      savePopDialog(context,
                          locale.language[0].savePoput!.toString(), false);
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
                      popUpDialog(context, opendNoteId, locale);
                    }
                  : null,
            ),
            const SizedBox(width: 15),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  initialValue: _initialValues['title'].toString(),
                  onChanged: (value) {
                    setState(() {
                      hasContent = value.toString();
                    });
                  },
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: themeData.themeColor[0].colorID == '1'
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 24,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                    hintText: locale.language[0].noteTitle!.isNotEmpty
                        ? locale.language[0].noteTitle!
                        : 'Título',
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: themeData.themeColor[0].colorID == '1'
                            ? Colors.grey
                            : Colors.grey.shade200,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: themeData.themeColor[0].colorID == '1'
                            ? Colors.grey
                            : Colors.grey.shade200,
                      ),
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
                Expanded(
                  child: TextFormField(
                    initialValue: _initialValues['textContent'].toString(),
                    onChanged: (value) {
                      setState(() {
                        hasContent = value.toString();
                      });
                    },
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: themeData.themeColor[0].colorID == '1'
                              ? Colors.white
                              : Colors.black,
                          height: 1.5,
                          fontSize: 16,
                        ),
                    decoration: InputDecoration(
                      hintStyle:
                          Theme.of(context).textTheme.bodyText2!.copyWith(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                      border: InputBorder.none,
                      hintText: locale.language[0].noteContent!.isNotEmpty
                          ? locale.language[0].noteContent!
                          : 'Conteúdo',
                    ),
                    onSaved: (value) {
                      _newNote = Notes(
                        id: _newNote.id,
                        title: _newNote.title,
                        textContent: value.toString(),
                        dateTime: _newNote.dateTime,
                      );
                    },
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 1000,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
