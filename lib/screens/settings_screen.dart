import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Providers
import '../providers/colors_provider.dart';
import '../providers/language_provider.dart';

//Widgets
import '../widgets/about_author.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/test-screen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _whiteTheme;
  var _blackTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final noteId = ModalRoute.of(context)!.settings.arguments;
    if (noteId != null) {
      _whiteTheme = noteId == '0';
      _blackTheme = noteId == '1';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context, listen: false);
    final locale = Provider.of<AppLanguageProvider>(context, listen: false);
    final divider = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Divider(color: _blackTheme ? Colors.white : Colors.grey),
    );
    return Scaffold(
      backgroundColor: _blackTheme ? Colors.black : Colors.white,
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: _blackTheme ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: _blackTheme ? Colors.white : Colors.black,
        ),
        shape: Border(
          bottom: BorderSide(
            color: _blackTheme ? Colors.white24 : Colors.grey,
          ),
        ),
        title: Text(
          locale.language[0].settings!.isNotEmpty
              ? locale.language[0].settings!
              : 'Settings',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: _blackTheme ? Colors.white : Colors.black,
              ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              locale.language[0].themeColorTitle!.isNotEmpty
                  ? locale.language[0].themeColorTitle!
                  : 'Theme color',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _blackTheme ? Colors.white : Colors.black,
                  ),
            ),
          ),
          GestureDetector(
            onTap: () {
              themeData.addTheme('theme', '0');
              setState(() {
                _whiteTheme = true;
                _blackTheme = false;
              });
            },
            child: Row(
              children: [
                IconButton(
                  icon: _whiteTheme
                      ? Icon(Icons.check_box, color: Colors.orange)
                      : Icon(
                          Icons.check_box_outline_blank,
                          color: _blackTheme ? Colors.white : Colors.black,
                        ),
                  onPressed: null,
                ),
                Text(
                  locale.language[0].whiteThemeTitle!.isNotEmpty
                      ? locale.language[0].whiteThemeTitle!
                      : 'White theme',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: _blackTheme ? Colors.white : Colors.black,
                      ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              themeData.addTheme('theme', '1');
              setState(() {
                _blackTheme = true;
                _whiteTheme = false;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: _blackTheme
                      ? Icon(Icons.check_box, color: Colors.orange)
                      : Icon(
                          Icons.check_box_outline_blank,
                          color: _whiteTheme ? Colors.black : Colors.white,
                        ),
                  onPressed: null,
                ),
                Text(
                  locale.language[0].blackThemeTitle!.isNotEmpty
                      ? locale.language[0].blackThemeTitle!
                      : 'Black theme',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: _blackTheme ? Colors.white : Colors.black,
                      ),
                ),
              ],
            ),
          ),
          divider,
          GestureDetector(
            onTap: () => showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) => DraggableScrollableSheet(
                initialChildSize: 0.97,
                builder: (_, conttroller) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ],
                      ),
                      AboutAuthor(),
                    ],
                  ),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                locale.language[0].about!.isNotEmpty
                    ? locale.language[0].about!
                    : 'About the Author',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: _blackTheme ? Colors.white : Colors.black,
                      fontSize: 18,
                    ),
              ),
            ),
          ),
          divider,
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locale.language[0].version!.isNotEmpty
                      ? locale.language[0].version!
                      : 'Version',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: _blackTheme ? Colors.white : Colors.black,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  '1.0.2',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
