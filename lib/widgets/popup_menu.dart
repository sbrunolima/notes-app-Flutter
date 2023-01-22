import 'package:flutter/material.dart';

//Here all screens
import '../screens/settings_screen.dart';

Widget popupMenu(BuildContext context, String themeColor, var title) {
  return PopupMenuButton(
    icon: Icon(
      Icons.more_vert_outlined,
      color: themeColor == '1' ? Colors.white : Colors.black,
    ),
    color: Colors.grey.shade800,
    itemBuilder: (context) => [
      PopupMenuItem(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(
              SettingsScreen.routeName,
              arguments: themeColor.toString(),
            );
          },
          child: Container(
            width: 130,
            child: Text(
              title.language[0].settings!.isNotEmpty
                  ? title.language[0].settings!
                  : 'Settings',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    ],
  );
}
