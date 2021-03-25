import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light ,
  primarySwatch: Colors.indigo ,
  accentColor: Colors.blue ,
  primaryColor: Colors.blueAccent ,
  scaffoldBackgroundColor: Colors.white
) ;

ThemeData dark = ThemeData(
  brightness: Brightness.dark ,
  primarySwatch: Colors.indigo ,
  primaryColor: Colors.blue,
  accentColor: Colors.blueAccent ,
);

class DarkThemeNotifier extends ChangeNotifier{
  bool _darkMode ;
  String  _key = "darkMode";
  SharedPreferences _sharedPref ;

  DarkThemeNotifier(){
    _darkMode = false ;
    _loadFromPref();
  }

  bool get darhTheme => _darkMode ;

  setTheme(){
    _darkMode = !_darkMode ;
    _savePref() ;
    notifyListeners() ;
  }

  _initPref() async{
    if (_sharedPref == null) {
      _sharedPref = await SharedPreferences.getInstance() ;
    }
    return _sharedPref ;
  }

  _loadFromPref() async{
    await _initPref() ;
    _darkMode = _sharedPref.getBool(_key) ?? false ;
    notifyListeners() ;
  }

  _savePref() async{
    await _initPref() ;
    _sharedPref.setBool(_key, _darkMode) ;
  }
}