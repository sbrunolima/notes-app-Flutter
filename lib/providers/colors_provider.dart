import 'package:flutter/foundation.dart';

import '../models/theme_color.dart';
import '../database/theme_db.dart';

class ThemeProvider with ChangeNotifier {
  List<ThemeColor> _themeColor = [];

  List<ThemeColor> get themeColor {
    return [..._themeColor];
  }

  Future<void> addTheme(String id, String theme) async {
    ThemeDB.insertData(
      'user_theme',
      {
        'id': id.toString().toLowerCase(),
        'colorID': theme.toString(),
      },
    );
    notifyListeners();
  }

  Future<void> loadAndSetTheme() async {
    final dataList = await ThemeDB.getData('user_theme');
    _themeColor = dataList
        .map(
          (theme) => ThemeColor(
            id: theme['id'].toString().toLowerCase(),
            colorID: theme['colorID'],
          ),
        )
        .toList();

    notifyListeners();
  }
}
