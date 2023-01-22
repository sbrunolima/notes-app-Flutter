import 'package:flutter/foundation.dart';

class AppLanguage {
  final String? locale;
  final String? title;
  final String? noNotes;
  final String? addButton;
  final String? settings;
  final String? themeColorTitle;
  final String? whiteThemeTitle;
  final String? blackThemeTitle;
  final String? about;
  final String? version;
  final String? noteTitle;
  final String? noteContent;
  final String? savePoput;
  final String? removePoput;
  final String? deleteTitle;
  final String? deleteButton;
  final String? cancelButton;

  AppLanguage({
    required this.locale,
    required this.title,
    required this.noNotes,
    required this.addButton,
    required this.settings,
    required this.themeColorTitle,
    required this.whiteThemeTitle,
    required this.blackThemeTitle,
    required this.about,
    required this.version,
    required this.noteTitle,
    required this.noteContent,
    required this.savePoput,
    required this.removePoput,
    required this.deleteTitle,
    required this.deleteButton,
    required this.cancelButton,
  });
}

class AppLanguageProvider with ChangeNotifier {
  List<AppLanguage> _language = [];

  List<AppLanguage> get language {
    return [..._language];
  }

  Future<void> setLanguage(String locale) async {
    final List<AppLanguage> loadedLanguage = [];
    if (locale == 'pt_BR') {
      loadedLanguage.add(
        AppLanguage(
          locale: 'pt_BR',
          title: 'Notas',
          noNotes: 'Sem notas',
          addButton: 'Adicionar',
          settings: 'Configurações',
          themeColorTitle: 'Cor do tema',
          whiteThemeTitle: 'Tema claro',
          blackThemeTitle: 'Tema escuro',
          about: 'Sobre o autor',
          version: 'Versão',
          noteTitle: 'Título',
          noteContent: 'Conteúdo',
          savePoput: 'Nota salva',
          removePoput: 'Nota removida',
          deleteTitle: 'Essa nota será deletada',
          deleteButton: 'Deletar',
          cancelButton: 'Cancelar',
        ),
      );
    } else {
      loadedLanguage.add(
        AppLanguage(
          locale: 'en_US',
          title: 'Notes',
          noNotes: 'No notes',
          addButton: 'Add note',
          settings: 'Settings',
          themeColorTitle: 'Theme color',
          whiteThemeTitle: 'White theme',
          blackThemeTitle: 'Dark theme',
          about: 'About the Author',
          version: 'Version',
          noteTitle: 'Title',
          noteContent: 'Content',
          savePoput: 'Note saved',
          removePoput: 'Note removed',
          deleteTitle: 'This note will be deleted',
          deleteButton: 'Delete',
          cancelButton: 'Cancel',
        ),
      );
    }
    _language = loadedLanguage.toList();
    notifyListeners();
    print('LOCALE => ${_language[0].locale.toString()}');
  }
}
