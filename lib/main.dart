import 'package:flutter/material.dart';
import 'package:light_dark_mode/theme/theme_data.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/mainmenu.dart';
import 'theme/theme_notifier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    bool darkModeOn = prefs.getBool('darkMode') ?? true;
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeNotifier.getTheme(),
      home: MainMenu(),
    );
  }
}
