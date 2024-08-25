import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_i/model/login_functions.dart';
import 'package:project_i/pages/home.dart';
import 'package:project_i/pages/login.dart';
import 'package:project_i/themes/provider_theme.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState(){
    super.initState();
    splash();
  }

  Future <void> splash()async{
    await Future.delayed(Duration(seconds: 2)); 
    //checking shared_prefs is user logined
    var islogin=await getdata(); 
    if(islogin==true){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> HomeScreen()));
    }else{
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final uiProvider=Provider.of<UiProvider>(context);
    return Scaffold(
      backgroundColor: uiProvider.dark ? Colors.black : Colors.white,
        body:SafeArea(child: 
        (uiProvider.dark)
        ? Center(
          child: Transform.scale(
            scale: 2.0,
              child: Lottie.asset("assets/anim_2.json"),
          ),
        )
        : Center(
          child: Transform.scale(
            scale: 2.0,
              child: Lottie.asset("assets/anim.json"),
          ),
        )
      )
    );
  }
}