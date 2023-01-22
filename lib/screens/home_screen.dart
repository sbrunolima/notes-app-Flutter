import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/notes_provider.dart';
import '../providers/colors_provider.dart';
import '../providers/language_provider.dart';

//Widgets
import '../widgets/popup_menu.dart';

//Screens
import '../screens/add_notes_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String defaultLocale = Platform.localeName;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<ThemeProvider>(context).loadAndSetTheme();
    final theme = Provider.of<ThemeProvider>(context, listen: false);

    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (theme.themeColor.isEmpty) {
        Provider.of<ThemeProvider>(context).addTheme('theme', '1');
      }
    });

    if (_isInit) {
      Provider.of<AppLanguageProvider>(context).setLanguage(defaultLocale);
    }

    Provider.of<NotesProvider>(context).loadAndSetNotes();

    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final notesData = Provider.of<NotesProvider>(context, listen: false);
    final themeData = Provider.of<ThemeProvider>(context, listen: false);
    final locale = Provider.of<AppLanguageProvider>(context, listen: false);

    return Scaffold(
      backgroundColor:
          themeData.themeColor[0].colorID == '1' ? Colors.black : Colors.white,
      body: themeData.themeColor.isEmpty
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  shape: Border(
                    bottom: BorderSide(
                      color: themeData.themeColor[0].colorID == '1'
                          ? Colors.white24
                          : Colors.grey,
                    ),
                  ),
                  backgroundColor: themeData.themeColor[0].colorID == '1'
                      ? Colors.black
                      : Colors.white,
                  titleSpacing: 10,
                  floating: true,
                  pinned: true,
                  title: Text(
                    locale.language[0].title!.isNotEmpty
                        ? locale.language[0].title!
                        : 'Notas',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: themeData.themeColor[0].colorID == '1'
                              ? Colors.white
                              : Colors.black,
                          fontSize: 30,
                        ),
                  ),
                  actions: [
                    popupMenu(
                      context,
                      themeData.themeColor[0].colorID.toString(),
                      locale,
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: notesData.notes.length <= 0
                        ? Container(
                            height: 300,
                            child: Center(
                              child: Text(
                                locale.language[0].noNotes!.isNotEmpty
                                    ? locale.language[0].noNotes!
                                    : 'Sem notas',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                      color:
                                          themeData.themeColor[0].colorID == '1'
                                              ? Colors.black
                                              : Colors.grey,
                                      fontSize: 20,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 8),
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
                                          horizontal: 10, vertical: 4),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade900,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 17, vertical: 12),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notesData.notes[i].title
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18,
                                                    ),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    130,
                                                child: Text(
                                                  notesData.notes[i].textContent
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(
                                                        color: Colors.white70,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                DateFormat('EEEE d MMM, h:mm a')
                                                    .format(notesData
                                                        .notes[i].dateTime!),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2!
                                                    .copyWith(
                                                      color: Colors.white60,
                                                      fontSize: 12,
                                                    ),
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
              children: [
                Icon(Icons.edit_outlined, size: 26),
                const SizedBox(width: 2),
                Text(
                  locale.language[0].addButton!.isNotEmpty
                      ? locale.language[0].addButton!
                      : 'Adicionar',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                )
              ],
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
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
