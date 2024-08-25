// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_i/model/storage.dart';
import 'package:project_i/pages/home.dart';
import 'package:project_i/themes/provider_theme.dart';
import 'package:provider/provider.dart';

class EditTask extends StatefulWidget {
 final String id;
 final String tasktitle;
 final String tasknote;
 final String taskdate;
 final String taskpriority;
       bool iscomplete; 
  
  EditTask({super.key,
  required this.id,
  required this.tasktitle,
  required this.tasknote,
  required this.taskdate,
  required this.taskpriority,
  required this.iscomplete
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {

  late TextEditingController title_contorl;
  late TextEditingController note_control;
  late TextEditingController date_contorl;
  late TextEditingController priority_contorl;

  @override
  void initState() {
    super.initState();
    title_contorl=TextEditingController(text: widget.tasktitle);
    note_control=TextEditingController(text: widget.tasknote);
    date_contorl=TextEditingController(text: widget.taskdate);
    priority_contorl=TextEditingController(text: widget.taskpriority);

    //checking the seletedbutton if the recieved value is number
    //if number then continue else it assigns 0
    selectedbutton=(int.tryParse(widget.taskpriority) ?? 0);
    if(selectedbutton==1){
      selectedbutton=1;
    }else if(selectedbutton==2){
      selectedbutton=2;
    }else if(selectedbutton==3){
      selectedbutton=3;
    }else if(selectedbutton==4){
      selectedbutton=4;
    }
    onpressfun(selectedbutton);
  }
 //stepper
  int currentstep=0;
  //next function
  void continuestepfun(){
    if(currentstep<3){
    setState(() {
      currentstep=currentstep+1;
     });
    }else{
      //saving data while pressing save  
      submitdata();  
      //navigating to homescreen
       Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
        builder:(context)=>HomeScreen()),
        (Route<dynamic>route)=>false,);
      //snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Row(
          children: [
            Icon(Icons.edit_document,color: Colors.green,),
            SizedBox(width: 15,),
            Text("Task edited succesfully !"),
          ],
        )));
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
  //storage class obj
  Storage db=Storage();
  //submit data function
  void submitdata(){
    setState(() {
      final updatedlist=[
      widget.iscomplete,
      widget.id,
      title_contorl.text,
      note_control.text,
      date_contorl.text,
      selectedbutton.toString(),
      ];
      //checking the id in the list 
      if(widget.iscomplete==false){
      final newlist=db.tasklist.indexWhere((task)=>task[1]==widget.id);
        db.tasklist[newlist]=updatedlist;
        db.updatedata();
        }
    });
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
  final DateFormat formatDate = DateFormat('dd-MM-yyyy');
  //date picking funtion
  void datefunction()async{
    final DateTime? datetime=await showDatePicker(context: context,
      firstDate: DateTime(1800), 
      lastDate: DateTime(2500),
    );
      //check if the picked date is not null
     if (datetime!=null){
      setState(() {
        date_contorl.text=formatDate.format(datetime);
      });
     }
  }
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
        title: Text("Edit Task",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.white,letterSpacing: 1),),
      ),
      body: SingleChildScrollView(child: 
      //stepper
      Column(
        children: [
          SizedBox(height: 40,),
          Text("Edit your task here.",
          style: TextStyle(fontSize: 25,fontWeight: FontWeight.w400,
          color: uiProvider.dark ? Colors.white : Colors.grey[900],letterSpacing: 1),),
          Padding(
            padding: const EdgeInsets.only(left: 60,right: 60,top: 5),
            child: Divider(
              thickness: 1.5,color: Colors.indigo,
            ),
          ),
          SizedBox(height: 20,),
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
                    controller: title_contorl,
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
                    controller: note_control,
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
                        controller: date_contorl,
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
              //priority buttons
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