import 'package:flutter/material.dart';

class test extends StatefulWidget {
  @override
  _test createState() => _test();
}

class _test extends State<test> {
  
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Theme Switcher'),),
          body: Center(child: 
            IconButton(
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: _isDarkMode
                    ? Icon(Icons.light_mode, key: ValueKey<bool>(_isDarkMode))
                    : Icon(Icons.dark_mode, key: ValueKey<bool>(_isDarkMode)),
              ),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
            ),
          
        ),
        
      ),
    );
  }
}