import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../themes/provider_theme.dart';

class taskadd extends StatefulWidget {
  const taskadd({super.key});

  @override
  State<taskadd> createState() => _taskaddState();
}

class _taskaddState extends State<taskadd> {
  //textfield variable and dateformat variable
  var d1=TextEditingController();
  final DateFormat formatDate = DateFormat('dd-MM-yyyy');
  //date picking funtion
  void datefunction()async{
    final DateTime? datetime=await showDatePicker(context: context,
      firstDate: DateTime(1800), 
      lastDate: DateTime(2500),
      initialDate: DateTime.now()); 
      //check if the picked date is not null
     if (datetime!=null){
      setState(() {
        d1.text=formatDate.format(datetime);
      });
     }
  }
  //priority buttons
  Color button1=Colors.blue;
  Color button2=Colors.blue;
  Color button3=Colors.blue;
  Color button4=Colors.blue; 

  Color selected=Colors.green;
  int selectedbutton=0;
  void onpressfun(int buttonindex){
    setState(() {
      button1=Colors.red;
      button2=Colors.red;
      button3=Colors.red;
      button4=Colors.red;

      switch(buttonindex){
        case 1:
          button1=selected;
          break;
        case 2:
          button2=selected;
          break;
        case 3:
          button3=selected;
          break;
        case 4:
          button4=selected;
          break;
      }
      selectedbutton=buttonindex;
    });
  }
  @override
  Widget build(BuildContext context) {
    //appbar color change
    final uiProvider=Provider.of<UiProvider>(context);
    return Scaffold(
      //appbar
      appBar: AppBar(
        backgroundColor: uiProvider.dark ? Colors.grey[800] : Colors.indigo,
        leading: BackButton(color: Colors.white,),
        title: Text("New Task",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.white),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: Colors.white,),
          tooltip: "Search",
          )
        ],
      ),
      //body
      body: SafeArea(child: 
       Column(
        children: [
          //title
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 70,right: 70),
            child: TextField(
              decoration: InputDecoration(
                hintText: "What are you planning ",
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                )
              ),
            ),
          ),
          //description
           Padding(
            padding: const EdgeInsets.only(top: 10,left: 60,right: 60),
            child: TextField(
              maxLength: 500,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: "Notes",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),  
                )
              ),
            ),
          ),
          //priority button 1
          Center(
            child: Text("Select your priority level for the task",
            style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Padding(
               padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10),
               child: MaterialButton(onPressed: (){
                onpressfun(1);
                           },
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
                ),
                textColor: Colors.white, 
                hoverColor: Colors.green, 
                splashColor: Colors.white,
                color: button1,
                
                child: Text("Low",style: TextStyle(fontWeight: FontWeight.bold)),
                ),
             ),
          //priority button 2 
          Padding(
            padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10),
            child: MaterialButton(onPressed: (){
                onpressfun(2);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              textColor: Colors.white,
              hoverColor: Colors.green,
              splashColor: Colors.white,
              color: button2,
              child: Text("Medium",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
          ),
          //priority button 3 
             Padding(
               padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10),
               child: MaterialButton(onPressed: (){
                onpressfun(3);
                },
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
                ),
              textColor: Colors.white,
              hoverColor: Colors.green,
              splashColor: Colors.white,
              color: button3,
              child: Text("High",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
             ),
            //priority button 4
            Padding(
              padding: const EdgeInsets.only(right: 10,top: 10,bottom: 10),
              child: MaterialButton(onPressed: (){
                onpressfun(4);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              textColor: Colors.white,
              hoverColor: Colors.green,
              splashColor: Colors.white,
              color: button4,
              child: Text("Urgent",style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ),
          ]),     
          //date
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Container(
                    width: 180,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: TextField(
                          controller: d1,
                          decoration: InputDecoration(
                            hintText: "Date",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.date_range_sharp)
                          ),
                          onTap: (){ datefunction(); },
                        ),
                      ),
                    ), 
                   ],
                ),
                //save
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(onPressed: (){},
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white
                  ),child: Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
                ),
            ],
        ),
      )
    );
  }
}