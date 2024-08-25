import 'package:shared_preferences/shared_preferences.dart';

Future<void> savedata(bool value)async{

  final SharedPreferences store=await SharedPreferences.getInstance();
  await store.setBool("1", value);

}

Future<bool> getdata()async{

  final SharedPreferences store=await SharedPreferences.getInstance();
  return store.getBool("1") ?? false;

}