import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Here all other files
import '../providers/notes_provider.dart';
import '../widgets/save_pop_dialog.dart';

Future popUpDialog(BuildContext context, String opendNoteId) {
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
            'Essa nota será deletada',
            style: GoogleFonts.roboto(
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
                      savePopDialog(context, 'Nota removida', true);
                    },
                    child: Text(
                      'Deletar',
                      style: GoogleFonts.roboto(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
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
                      'Cancelar',
                      style: GoogleFonts.roboto(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
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
