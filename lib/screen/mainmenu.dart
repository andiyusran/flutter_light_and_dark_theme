import 'package:flutter/material.dart';
import 'package:light_dark_mode/theme/theme_data.dart';
import 'package:light_dark_mode/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  bool _darkTheme = true;

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      appBar: AppBar(
        title: _darkTheme == true ? Text('Dark Theme') : Text('Light Theme'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch(
                  value: _darkTheme,
                  onChanged: (val) {
                    setState(() {
                      _darkTheme = val;
                    });
                    onThemeChanged(val, themeNotifier);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                _darkTheme == true
                    ? Text('This is Dark Theme')
                    : Text('This is Light Theme'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
