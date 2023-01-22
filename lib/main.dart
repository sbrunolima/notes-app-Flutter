import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

//Providers
import './providers/notes_provider.dart';
import './providers/colors_provider.dart';
import './providers/language_provider.dart';

//Screens
import './screens/home_screen.dart';
import './screens/add_notes_screen.dart';
import 'screens/settings_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Maintain the splash until initialization has completed
  FlutterNativeSplash.removeAfter(initialization);
  runApp(NotesApp());
}

Future initialization(BuildContext? context) async {
  //Load content
  await Future.delayed(const Duration(seconds: 2));
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => NotesProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AppLanguageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes APP',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.orange,
          ),
        ),
        home: HomeScreen(),
        routes: {
          AddNotesScreen.routeName: (ctx) => AddNotesScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
        },
      ),
    );
  }
}
