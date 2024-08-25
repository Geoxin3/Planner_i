import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_i/pages/splash.dart';
import 'package:project_i/themes/provider_theme.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('storage');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //theme
    return ChangeNotifierProvider(
      create: (BuildContext context) =>UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context,UiProvider notifier,child) {
          //theme provider end//
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: notifier.dark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: notifier.dark ? notifier.darkTheme : notifier.lightTheme,
            theme:ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
              useMaterial3: true
            ),
            home: SplashScreen(),
          );
        }
      ),
    );
  }
}