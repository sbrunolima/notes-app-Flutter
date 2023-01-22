import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Here all other files
import '../providers/notes_provider.dart';
import '../widgets/save_pop_dialog.dart';

Future popUpDialog(BuildContext context, String opendNoteId, var text) {
  return showDialog(
    context: context,
    builder: (context) => Container(
      child: AlertDialog(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        title: Center(
          child: Text(
            text.language[0].deleteTitle!.isNotEmpty
                ? text.language[0].deleteTitle!
                : 'Essa nota será deletada',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        actions: [
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  width: 250,
                  child: OutlinedButton(
                    onPressed: () async {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home-screen', (Route<dynamic> route) => false);
                      //Navigator.of(context).pop(HomeScreen.routeName);
                      await Provider.of<NotesProvider>(context, listen: false)
                          .deleteNote(opendNoteId.toString());
                      savePopDialog(context,
                          text.language[0].removePoput.toString(), true);
                    },
                    child: Text(
                      text.language[0].deleteButton!.isNotEmpty
                          ? text.language[0].deleteButton!
                          : 'Deletar',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  width: 250,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      text.language[0].cancelButton!.isNotEmpty
                          ? text.language[0].cancelButton!
                          : 'Cancelar',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
