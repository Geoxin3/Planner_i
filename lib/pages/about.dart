// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/provider_theme.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    //app bar color change
    final uiProvider=Provider.of<UiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: uiProvider.dark ? Colors.black : Colors.white30,
      ),
      body: SafeArea(child: 
              Padding(
              padding: const EdgeInsets.only(left: 50,right: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Text("About",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.indigoAccent),
                    ),
                    //line
                    Divider(thickness: 1.5,color: Colors.indigoAccent,
                    ),
                    SizedBox(height: 20,),
                    //name
                    Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      shadowColor: Colors.red,
                      child: Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 80,bottom: 40),
                      child: Stack(
                        children:[
                           Padding(
                             padding: const EdgeInsets.only(left: 10,top: 10),
                             child: Text("Name",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.indigo),),
                           ),
                           
                           Center(
                             child: Padding(
                               padding: const EdgeInsets.only(top: 70,left: 35),
                               child: Text("Geoxin3",style: TextStyle(fontWeight: FontWeight.w600),),
                             ),
                           ),

                           Center(
                             child: Padding(
                               padding: const EdgeInsets.only(top: 100,left: 40),
                               child: Text("",style: TextStyle(fontWeight: FontWeight.w600),),
                             ),
                           ),

                           Center(
                             child: Padding(
                               padding: const EdgeInsets.only(top: 130),
                               child: Text("",style: TextStyle(fontWeight: FontWeight.w600),),
                             ),
                           ),

                           Center(
                             child: Padding(
                               padding: const EdgeInsets.only(top: 160,left: 60),
                               child: Text("",style: TextStyle(fontWeight: FontWeight.w600),),
                             ),
                           ),

                           Center(
                             child: Padding(
                               padding: const EdgeInsets.only(top: 210,left: 45),
                               child: Text("",style: TextStyle(fontWeight: FontWeight.w600),),
                             ),
                           ) 
                        ]
                      ),
                      ),
                    ),
                    SizedBox(height: 60,),
                    //institution and course
                    Card(
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      shadowColor: Colors.blue,
                      child: Padding(padding: EdgeInsets.only(top: 20,left: 20,right: 80,bottom: 40),
                      child: Stack(
                        children:[
                           Padding(
                             padding: const EdgeInsets.only(left: 10,top: 10),
                             child: Text("Institution",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.indigo),),
                           ),
                           
                           Center(
                             child: Padding(
                               padding: const EdgeInsets.only(top: 60,left: 80),
                               child: Text("",style: TextStyle(fontWeight: FontWeight.bold),),
                             ),
                           ),

                            Padding(
                               padding: const EdgeInsets.only(top: 120,left: 10),
                               child: Text("Course",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.indigo),),
                             ),

                              Center(
                             child: Padding(
                               padding: const EdgeInsets.only(top: 180,left: 45),
                               child: Text("",style: TextStyle(fontWeight: FontWeight.bold),),
                             ),
                           ),
                        ]
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              )
      )
    );
  }
}