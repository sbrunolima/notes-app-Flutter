import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

//Here all other files
import '../providers/notes_provider.dart';

//Here all screens
import '../screens/add_notes_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    Provider.of<NotesProvider>(context).loadAndSetNotes();

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<NotesProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            shape: Border(bottom: BorderSide(color: Colors.white24)),
            backgroundColor: Colors.grey.shade900,
            //expandedHeight: 200,
            //collapsedHeight: 70,
            floating: true,
            pinned: true,
            title: Text(
              'Notas',
              style: GoogleFonts.roboto(
                  fontSize: 26, fontWeight: FontWeight.normal),
            ),
          ),
          SliverToBoxAdapter(
            child: notesData.notes.length <= 0
                ? Container(
                    height: 400,
                    child: Center(
                      child: Text(
                        'Sem notas',
                        style: GoogleFonts.roboto(
                            color: Colors.grey, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: notesData.notes.length,
                          itemBuilder: (ctx, i) => GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  AddNotesScreen.routeName,
                                  arguments: notesData.notes[i].id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 17, vertical: 4),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black26,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17, vertical: 12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notesData.notes[i].title.toString(),
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        DateFormat('EEEE d MMM, h:mm a').format(
                                            notesData.notes[i].dateTime!),
                                        style: GoogleFonts.roboto(
                                            color: Colors.grey.shade500,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
        child: SizedBox(
          height: 50,
          width: 140,
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.edit_outlined, size: 26),
                Text(
                  'Adicionar',
                  style: GoogleFonts.roboto(
                      fontSize: 18, fontWeight: FontWeight.w700),
                )
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AddNotesScreen.routeName);
            },
          ),
        ),
      ),
    );
  }
}
