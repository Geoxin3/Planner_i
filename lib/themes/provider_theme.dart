import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier{

  bool dark=false;
  //storage variable
  late SharedPreferences storage;
  //dark theme
  final darkTheme=ThemeData(
    primaryColor: Colors.grey[800],
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black
  );
  //light theme
  final lightTheme=ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white70
  );
  
  //toggle function
  changeTheme(){
    dark=!dark;
    //save the value
    storage.setBool("dark",dark);
    notifyListeners();
  }

  init()async{
    //retriving the previous state
    storage= await SharedPreferences.getInstance();
    dark=storage.getBool("dark")??false;
    notifyListeners();
  }
}