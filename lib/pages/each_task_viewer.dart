// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:project_i/model/storage.dart';
import 'package:project_i/pages/edit_task.dart';
import 'package:project_i/pages/home.dart';
import 'package:project_i/themes/provider_theme.dart';
import 'package:provider/provider.dart';

class EachTask extends StatefulWidget {
  final String id;
  final String tsktitle;
  final String tsknote;
  final String tskdate;
        String tskprio;
        bool iscomplete;

  EachTask({super.key,
  required this.id,
  required this.tsktitle,
  required this.tsknote,
  required this.tskdate,
  required this.tskprio,
  required this.iscomplete
  });

  @override
  State<EachTask> createState() => _EachTaskState();
}

class _EachTaskState extends State<EachTask> {
  Storage db=Storage();
  //delete task
  @override
  Widget build(BuildContext context) {
    final uiProvider=Provider.of<UiProvider>(context);
    void deletetsk(){
    showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: uiProvider.dark ? Colors.grey[900] : Colors.white,
          title: Row(
            children: [
              Text("Delete"),
              SizedBox(width: 10,),
              Icon(Icons.delete_forever_outlined,color: Colors.red,)
            ],
          ),
          content: Text("Are you sure you want to delete."),
          actions: [
              TextButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text("Cancel")),
              TextButton(onPressed: ()async{
                //showing progressindicator first
                showDialog(context: context,
                builder: (context){
                return Center(child: CircularProgressIndicator(color: Colors.red.shade300,));
                });
                //dialog shown before removing the task
                await Future.delayed(Duration(milliseconds: 300));
                //remove / delete task
                db.removetask(widget.id);
                //navigate to homepage
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                  builder:(context)=>HomeScreen()),
                 (Route<dynamic>route)=>false,);
                //sanckbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Row(
                    children: [
                      Icon(Icons.close_rounded,color: Colors.red,),
                      SizedBox(width: 15,),
                      Text("Task deleted !"),
                    ],
                  )));
              }, child: Text("Delete"))
          ],
        );
    });    
  }
    return AlertDialog(
      backgroundColor: uiProvider.dark ? Colors.grey[900] : Colors.white,
      content: Container(
        height: 500, width: 300,
        child: Column(
          children: [
            Row(
              children: [
              //priority tag
              Container(
                padding: EdgeInsets.only(left: 9,right: 9,top: 5,bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (widget.tskprio=="No priority") ? Colors.transparent
                              :widget.iscomplete ? Colors.green
                              :(widget.tskprio=="Low")
                              ? Colors.red
                              :(widget.tskprio=="Medium")
                              ? Colors.amber
                              :(widget.tskprio=="High")
                              ? Colors.blue
                              :(widget.tskprio=="Urgent")
                              ? Colors.cyan
                              : Colors.transparent
                ),child: Text(widget.tskprio,style: TextStyle(
                  fontSize: 13,fontWeight: FontWeight.bold,
                  decoration: widget.iscomplete ? TextDecoration.lineThrough : TextDecoration.none
                ),),
              ),
              Spacer(),
              //popupmenu button 
              PopupMenuButton(itemBuilder: (context)=>
              [
                PopupMenuItem(child: Row(
                  children: [
                    Text("Edit"),
                    Spacer(),
                    Icon(Icons.edit_document,color:Colors.green,)
                  ],
                ),value: 1,),
                PopupMenuItem(child: Row(
                  children: [
                    Text("Delete"),
                    Spacer(),
                    Icon(Icons.delete_forever_outlined,color:Colors.red,)
                  ],
                ),value: 2,)
              ],onSelected: (value) {
                if(value==1){
                  if(widget.iscomplete==false){
                  //edit task
                  //the priority text to int for edit task priority buttons
                  if(widget.tskprio=="Low"){
                    widget.tskprio="1";
                  }else if(widget.tskprio=="Medium"){
                    widget.tskprio="2";
                  }else if(widget.tskprio=="High"){
                    widget.tskprio="3";
                  }else if(widget.tskprio=="Urgent"){
                    widget.tskprio="4";
                  }
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>
                   EditTask(
                    id: widget.id,
                    tasktitle: widget.tsktitle,
                    tasknote: widget.tsknote,
                    taskdate: widget.tskdate,
                    taskpriority: widget.tskprio,
                    iscomplete: widget.iscomplete,
                   )));
                   }else{
                    //is task completed or not
                    showDialog(context: context,
                     builder: (context){
                      return AlertDialog(
                        backgroundColor: uiProvider.dark ? Colors.grey[900] : Colors.white,
                        title: Row(
                          children: [
                            Text("Task completed"),
                            SizedBox(width: 10,),
                            Icon(Icons.info,color: Colors.red,)
                          ],
                        ),
                        content: Text("This task was completed."),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          },
                           child: Text("Ok"))
                        ],
                      );
                     });
                   }
                }else{
                //delete task
                deletetsk();
                }
              },
              icon: Icon(Icons.more_horiz),)
            ],),
            //task title
            Text(widget.tsktitle,style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold,
              decoration: widget.iscomplete ? TextDecoration.lineThrough : TextDecoration.none
            ),),
            Divider(thickness: 3,height: 20,),
            //descrition / notes
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,top: 10),
                      child: Text(widget.tsknote,style: TextStyle(
                        fontSize: 15,fontWeight: FontWeight.w500,
                        decoration: widget.iscomplete ? TextDecoration.lineThrough : TextDecoration.none
                      ),),
                    )
                  ],),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(widget.iscomplete ? "Completed" : 
                    "Not Completed",style: TextStyle(
                      fontSize: 15,fontWeight: FontWeight.bold,
                      color: widget.iscomplete ? Colors.green : Colors.red
                    ),
                    )),
                ),  
                Spacer(),
                //task date
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(widget.tskdate,style: TextStyle(
                    fontSize: 13,fontWeight: FontWeight.bold,color: widget.iscomplete ? Colors.green : Colors.red,
                    decoration: widget.iscomplete ? TextDecoration.lineThrough : TextDecoration.none
                    ),),
                  ),
                )
            ])
          ],
        ),
      ),
    );
  }
}