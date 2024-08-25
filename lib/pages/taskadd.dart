 // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/provider_theme.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Taskadd extends StatefulWidget {
  final Function(Map<String, String>) onSave;

  const Taskadd({super.key,required this.onSave});

  @override
  State<Taskadd> createState() => _TaskaddState();
}

class _TaskaddState extends State<Taskadd> {
  //stepper
  int currentstep=0;
  //next function
  void continuestepfun(){
    if(currentstep<3){
    setState(() {
      currentstep=currentstep+1;
     });
    }else{
      submitdata();
    }
  }
  //back function
  void cancelstepfun(){
    if(currentstep>0){
      setState(() {
        currentstep=currentstep-1;
      });
    }
  }
  //naviagte steps function 
  void onstepfun(int value){
    setState(() {
      currentstep=value;
    });
  }
  //submit data function
  void submitdata(){
    //instance of uuid package for creating unique id for each task 
    final uuid=Uuid();
    final taskData = {
      'id':uuid.v4(),
      'title':title.text,
      'note':note.text,
      'date':d1.text,
      'priority':selectedbutton.toString(),
    };

    widget.onSave(taskData); // Call the callback function with the task data
    Navigator.pop(context); // Close the Taskadd page
  }
  // stepper button builder
  Widget controlsBuilder(context,details){
    return Row(
      children: [
        //next button
        ElevatedButton(onPressed: details.onStepContinue,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white 
        ),
        //save button
         child: currentstep>2 ? Text("Save",style: TextStyle(fontWeight: FontWeight.bold),)
         : Text("Next",style: TextStyle(fontWeight: FontWeight.bold),)
         ),

         SizedBox(width: 10,),
         
         //back button
         ElevatedButton(onPressed: details.onStepCancel,
         style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[600],
          foregroundColor: Colors.white
         ),
         child: Text("Back")),
      ],
    );
  }
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
  //title and note values
  var title=TextEditingController();
  var note=TextEditingController();
  //priority variables and function
  Color button1=Colors.red;
  Color button2=Colors.amber;
  Color button3=Colors.blue;
  Color button4=Colors.cyan; 

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
      //storing the index
      selectedbutton=buttonindex;
    });
  }
  @override
  Widget build(BuildContext context) {
    //appbar color change
    final uiProvider=Provider.of<UiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        shadowColor: uiProvider.dark ? Colors.indigo : Colors.grey[900],
        elevation: 5,
        backgroundColor: uiProvider.dark ? Colors.grey[900] : Colors.indigo,
        leading: BackButton(color: Colors.white,),
        title: Text("Add Task",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.white,letterSpacing: 1),),
      ),
      body: SingleChildScrollView(child: 
      //heading
      Column(
        children: [
          SizedBox(height: 40,),
          Text("Add your task here.",
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,
          color: uiProvider.dark ? Colors.white : Colors.grey[900],letterSpacing: 1),),
          Padding(
            padding: const EdgeInsets.only(left: 60,right: 60,top: 5),
            child: Divider(
              thickness: 1.5,color: Colors.indigo,
            ),
          ),
          SizedBox(height: 20,),
          //stepper
          SingleChildScrollView(
            child: Stepper(
              connectorThickness: 2,
              currentStep: currentstep,
              onStepContinue: continuestepfun,
              onStepCancel: cancelstepfun,
              onStepTapped: onstepfun,
              controlsBuilder: controlsBuilder,
              steps: [
              //title
              Step(title: Text("Title"),
              isActive: currentstep>=0,
              stepStyle: currentstep>0 ? StepStyle(boxShadow: BoxShadow(color: Colors.green,blurRadius: 20),
                  color: Colors.green)
                  : StepStyle(color: Colors.indigo),
              state: currentstep>0 ? StepState.complete : StepState.indexed,
               content: Column(
                 children: [
                   TextField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: "What are you planning ?",
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),
                  ),
                  SizedBox(height: 20,)
                 ],
               )),
              //note or description
              Step(title: Text("Description"), 
              isActive: currentstep>=1,
              stepStyle: currentstep>1 ? StepStyle(boxShadow: BoxShadow(color: Colors.green,blurRadius: 20),
                  color: Colors.green)
                  : StepStyle(color: Colors.indigo),
              state: currentstep>1 ? StepState.complete : StepState.indexed,
               content: Column(
                 children: [
                   TextField(
                    controller: note,
                    maxLength: 1000,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: "Notes",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                  ),
                 ],
               )),
              //date
              Step(title: Text("Date"),
              isActive: currentstep>=2,
              stepStyle: currentstep>2 ? StepStyle(boxShadow: BoxShadow(color: Colors.green,blurRadius: 20),
                  color: Colors.green)
                  : StepStyle(color: Colors.indigo),
              state: currentstep>2 ? StepState.complete : StepState.indexed,
               content: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(right: 150),
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
                   SizedBox(height: 20,)
                 ],
               )),
              //priority box
              Step(title: Text("Priority"),
              isActive: currentstep>=3,
              stepStyle: currentstep>3 ? StepStyle(boxShadow: BoxShadow(color: Colors.green,blurRadius: 20),
                  color: Colors.green)
                  : StepStyle(color: Colors.indigo),
              state: currentstep>3 ? StepState.complete : StepState.indexed,
               content:  Column(
                   children: [
                     Text("Select your priority level",style: TextStyle(color: Colors.indigo,fontSize: 17,fontWeight: FontWeight.w400),),
                     Divider(thickness: 2,endIndent: 20,indent: 20,),
                     SizedBox(height: 10,),
                  //buttons
                  Wrap(
                  children: [
                  //priority button 1 
                  GestureDetector(
                    onTap: (){
                      onpressfun(1);
                    },
                    child: Card(
                      color: button1.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: button1,
                          width: 3
                        )
                      ),
                      child: Column(
                        children: [
                          IconButton(onPressed: (){
                              onpressfun(1);
                              },
                              padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10), 
                              splashColor: Colors.white,
                              color: button1,
                              tooltip: "Low",
                              icon: Icon(Icons.low_priority_outlined),
                              ),
                              Text("Low",style: TextStyle(
                                color: (uiProvider.dark) ? button1
                                : (button1==Colors.green) ? Colors.green
                                : Colors.white,
                                fontSize: 15,fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ),
                  //priority button 2 
                  GestureDetector(
                    onTap: (){
                      onpressfun(2);
                    },
                    child: Card(
                      color: button2.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: button2,
                          width: 3
                        )
                      ),
                      child: Column(
                        children: [
                          IconButton(onPressed: (){
                              onpressfun(2);
                              },
                              padding: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10), 
                              splashColor: Colors.white,
                              color: button2,
                              tooltip: "Medium",
                              icon: Icon(Icons.nat),
                              ),
                              Text("Medium",style: TextStyle(
                                color: (uiProvider.dark) ? button2
                                : (button2==Colors.green) ? Colors.green
                                : Colors.white,
                                fontSize: 15
                              ),),
                              SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ),
                  //priority button 3 
                  GestureDetector(
                    onTap: (){
                      onpressfun(3);
                    },
                    child: Card(
                      color: button3.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: button3,
                          width: 3
                        )
                      ),
                      child: Column(
                        children: [
                          IconButton(onPressed: (){
                              onpressfun(3);
                              },
                              padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10), 
                              splashColor: Colors.white,
                              color: button3,
                              tooltip: "High",
                              icon: Icon(Icons.priority_high),
                              ),
                              Text("High",style: TextStyle(
                                color: (uiProvider.dark) ? button3
                                : (button3==Colors.green) ? Colors.green
                                : Colors.white,
                                fontSize: 15
                              ),),
                              SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ),   
                  //priority button 4
                  GestureDetector(
                    onTap: (){
                      onpressfun(4);
                    },
                    child: Card(
                      color: button4.withOpacity(0.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: button4,
                          width: 3
                        )
                      ),
                      child: Column(
                        children: [
                          IconButton(onPressed: (){
                              onpressfun(4);
                              },
                              padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10), 
                              splashColor: Colors.white,
                              color: button4,
                              tooltip: "Urgent",
                              icon: Icon(Icons.timeline),
                              ),
                              Text("Urgent",style: TextStyle(
                                color: (uiProvider.dark) ? button4
                                : (button4==Colors.green) ? Colors.green
                                : Colors.white,
                                fontSize: 15
                              ),),
                              SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ),
                  ]
                 ),SizedBox(height: 20,),
                 Divider(thickness: 2,endIndent: 50,indent: 50),
                 SizedBox(height: 10,)
               ]
              )
             
            ),//next step
                 ]
                ),
          ),
        ],
      )
   ));
  }
}