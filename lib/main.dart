import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Here all other files
import './providers/notes_provider.dart';

//Here all screens
import './screens/home_screen.dart';
import './screens/add_notes_screen.dart';

void main() => runApp(NotesApp());

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: NotesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes APP',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
        routes: {
          AddNotesScreen.routeName: (ctx) => AddNotesScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}
